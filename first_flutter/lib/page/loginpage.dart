import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:jwt_decode/jwt_decode.dart';
import 'package:test_flutter/page/AdminPage.dart';
import 'package:test_flutter/page/HotelProfilePage.dart';
import 'package:test_flutter/page/all_hotel_view_page.dart';
import 'package:test_flutter/page/homepage.dart';
import 'package:test_flutter/page/registerpage.dart';
import 'package:test_flutter/service/AuthService.dart';

class LoginPage extends StatelessWidget {
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();

  final storage = new FlutterSecureStorage();
  AuthService authService = AuthService();

  Future<void> loginUser(BuildContext context) async {

    final response = await authService.login(email.text, password.text);

    final role = await authService.getUserRole();

    if (role == 'ADMIN') {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Adminpage()),
      );
    } else if (role == 'HOTEL') {
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => HotelProfilePage(
                  hotelName: 'Grand Plaza',
                  hotelImageUrl: 'http://localhost:8080/images/hotel/The Grand Mustofa_882521f7-edbd-4372-b35b-870754d82684',
                  address: '123 Main st, CityHall',
                  rating: '4.5',
                  minPrice: 1000,
                  maxPrice: 3000
              ),
          ),
      );
    } else if (role == 'USER') {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => AllHotelViewPage()
          ),
      );
    } else {
      print('Unknown role: $role');
    }

    // final url = Uri.parse('http://localhost:8080/login');
    // final response = await http.post(
    //   url,
    //   headers: {'Content-Type': 'application/json'},
    //   body: jsonEncode({'email': email.text, 'password': password.text}),
    // );
    // if (response.statusCode == 200) {
    //   final responseData = jsonDecode(response.body);
    //   final token = responseData['token'];
    //
    //   // decode JWT to get sub and role
    //   Map<String, dynamic> payload = Jwt.parseJwt(token);
    //   String sub = payload['sub'];
    //   String role = payload['role'];
    //
    //   await storage.write(key: 'token', value: token);
    //   await storage.write(key: 'sub', value: sub);
    //   await storage.write(key: 'role', value: role);
    //
    //   print('Login Successful. Sub: $sub, Role: $role');
    //
    //   Navigator.push(
    //     context,
    //     MaterialPageRoute(builder: (context) => AllHotelViewPage()),
    //   );
    // } else {
    //   print('Login failed with status: ${response.statusCode}');
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: email,
              decoration: InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.email),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            TextField(
              controller: password,
              decoration: InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.password),
              ),
              obscureText: true,
            ),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () {
                loginUser(context);

                // String em = email.text;
                // String pass = password.text;
                // print('Email: $em, Password: $pass');
              },
              child: Text(
                "Login",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontFamily: GoogleFonts.aclonica().fontFamily,
                ),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
              ),
            ),
            SizedBox(height: 20),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => RegisterPage()),
                );
              },
              child: Text(
                'Register',
                style: TextStyle(
                  color: Colors.blue,
                  decoration: TextDecoration.underline,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
