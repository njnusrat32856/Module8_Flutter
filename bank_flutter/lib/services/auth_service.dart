import 'dart:convert';
import 'package:bank_flutter/models/user.dart';
import 'package:http/http.dart' as http;
import 'package:jwt_decode/jwt_decode.dart';
import 'package:shared_preferences/shared_preferences.dart';


class AuthService {
  final String baseUrl = 'http://localhost:8881';

  Future<bool> login(String email, String password) async {
    final url = Uri.parse('$baseUrl/login');
    final headers = {'Content-Type': 'application/json'};

    final body = jsonEncode({'email': email, 'password': password});

    final response = await http.post(url, headers: headers, body: body);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      String token = data['token'];

      // Decode token to get role
      Map<String, dynamic> payload = Jwt.parseJwt(token);
      String role = payload['role'];

      // Store token and role
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('authToken', token);
      await prefs.setString('userRole', role);

      // Store user details (You can store a full object or individual fields)
      await prefs.setString('user', jsonEncode(data['user'])); // Save the full user object as a JSON string

      return true;
    } else {
      print('Failed to log in: ${response.body}');
      return false;
    }
  }


  Future<bool> register(Map<String, dynamic> user) async {
    final url = Uri.parse('$baseUrl/register');
    final headers = {'Content-Type': 'application/json'};
    final body = jsonEncode(user);

    final response = await http.post(url, headers: headers, body: body);

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      String token = data['token'];

      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('authToken', token);

      return true;
    } else {
      print('Failed to register: ${response.body}');
      return false;
    }
  }

  Future<String?> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('authToken');
  }

  Future<Map<String, dynamic>?> getUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userJson = prefs.getString('user');

    if (userJson != null) {
      return jsonDecode(userJson); // Parse the JSON string and return as a Map
    } else {
      return null; // Return null if no user is found
    }
  }

  Future<String?> getUserRole() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    print(prefs.getString('userRole'));
    return prefs.getString('userRole');
  }

  Future<bool> isTokenExpired() async {
    String? token = await getToken();
    if (token != null) {
      DateTime expiryDate = Jwt.getExpiryDate(token)!;
      return DateTime.now().isAfter(expiryDate);
    }
    return true;
  }

  Future<bool> isLoggedIn() async {
    String? token = await getToken();
    if (token != null && !(await isTokenExpired())) {
      return true;
    } else {
      await logout();
      return false;
    }
  }

  Future<void> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('authToken');
    await prefs.remove('userRole');
  }

  Future<bool> hasRole(List<String> roles) async {
    String? role = await getUserRole();
    return role != null && roles.contains(role);
  }

  Future<bool> isAdmin() async {
    return await hasRole(['ADMIN']);
  }



  Future<bool> isUser() async {
    return await hasRole(['USER']);
  }




  // Future<bool> login(String username, String password) async {
  //   final response = await http.post(
  //     Uri.parse('$baseUrl/login'),
  //     headers: {'Content-Type': 'application/json'},
  //     body: jsonEncode({'username': username, 'password': password}),
  //   );
  //
  //   if (response.statusCode == 200) {
  //     final data = jsonDecode(response.body);
  //     final prefs = await SharedPreferences.getInstance();
  //     await prefs.setString('token', data['token']);
  //     return true;
  //   } else {
  //     return false;
  //   }
  // }
  //
  // Future<void> logout() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   await prefs.remove('token');
  // }
  //
  // Future<User?> getUserProfile() async {
  //   final prefs = await SharedPreferences.getInstance();
  //   final token = prefs.getString('token');
  //
  //   if (token == null) {
  //     return null; // No token, user is not logged in
  //   }
  //
  //   final response = await http.get(
  //     Uri.parse('$baseUrl/user/profile'), // Adjust endpoint as needed
  //     headers: {
  //       'Content-Type': 'application/json',
  //       'Authorization': 'Bearer $token',
  //     },
  //   );
  //
  //   if (response.statusCode == 200) {
  //     final data = jsonDecode(response.body);
  //     return User.fromJson(data);
  //   } else {
  //     return null;
  //   }
  // }
  //
  // Future<bool> register(String email, String password, String firstName, String lastName, String accountType, double initialBalance) async {
  //   final response = await http.post(
  //     Uri.parse('$baseUrl/register'), // Adjust the endpoint based on your backend
  //     headers: {'Content-Type': 'application/json'},
  //     body: jsonEncode({
  //       'email': email,
  //       'password': password,
  //       'firstName': firstName,
  //       'lastName': lastName,
  //       'accountType': accountType,
  //       'balance': initialBalance,
  //     }),
  //   );
  //
  //   if (response.statusCode == 201) {
  //     return true; // Registration successful
  //   } else {
  //     return false; // Registration failed
  //   }
  // }


}
