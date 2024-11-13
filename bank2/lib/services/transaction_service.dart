import 'dart:convert';
import 'package:bank2/models/transaction.dart';
import 'package:bank2/services/auth_service.dart';
import 'package:dio/dio.dart';

import 'package:http/http.dart' as http;

class TransactionService {
  final String baseUrl = 'http://localhost:8881/api/transactions';
  final AuthService userService = AuthService();

  Future<Map<String, String>> _getAuthHeaders() async {
    final token = await userService.getToken();
    return {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json'
    };
  }

  Future<List<Transaction>> getAllTransactions() async {
    try {
      final dio = Dio();
      final response = await dio.get("http://localhost:8881/api/transactions/");

      if (response.statusCode == 200) {
        final data = response.data as List;
        return data.map((json) => Transaction.fromJson(json)).toList();
      } else {
        throw Exception("Failed to load transactions: ${response.statusMessage}");
      }
    } on DioError catch (e) {
      print("DioError: ${e.message}");
      throw Exception("Failed to fetch transactions due to network error");
    }
  }

  Future<List<Transaction>> getTransactions() async {
    final response = await http.get(Uri.parse('$baseUrl/'));

    print(response.statusCode);

    if (response.statusCode == 200) {
      final List<dynamic> transactionData = json.decode(response.body);
      return transactionData.map((json) => Transaction.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load transactions');
    }
  }

  Future<Transaction> getTransactionById(int id) async {
    final headers = await _getAuthHeaders();
    final response =
        await http.get(Uri.parse('$baseUrl/$id'), headers: headers);

    if (response.statusCode == 200) {
      return Transaction.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load transaction');
    }
  }

  // Future<List<Map<String, dynamic>>> getTransactionsByUserId(int userId) async {
  //   final headers = await _getAuthHeaders();
  //   final response =
  //       await http.get(Uri.parse('${baseUrl}/user/$userId'), headers: headers);
  //
  //   if (response.statusCode == 200) {
  //     return List<Map<String, dynamic>>.from(json.decode(response.body));
  //   } else {
  //     throw Exception('Failed to load transactions');
  //   }
  // }

  Future<List<Transaction>> getTransactionsByUserId(int userId) async {
    final headers = await _getAuthHeaders();
    final response =
        await http.get(Uri.parse('$baseUrl/user/$userId'), headers: headers);

    // print(response.body);

    if (response.statusCode == 200) {
      final List<dynamic> transactionData = json.decode(response.body);
      // print(response.body);
      return transactionData.map((data) => Transaction.fromJson(data)).toList();
    } else {
      throw Exception('Failed to load user transactions');
    }
  }

  Future<void> depositMoney(
      int userId, double amount, String description) async {
    final url = Uri.parse(
        '$baseUrl/deposit?userId=$userId&amount=$amount&description=$description');
    final response = await http.post(url);

    if (response.statusCode == 200) {
      print('Deposit successful: ${response.body}');
    } else {
      throw Exception('Failed to deposit: ${response.body}');
    }
  }

  // Future<void> depositMoney(int userId, double amount, String description) async {
  //   final headers = await _getAuthHeaders();
  //   final url = Uri.parse('${baseUrl}/deposit');
  //   final params = {
  //     'userId': userId.toString(),
  //     'amount': amount.toString(),
  //     'description': description,
  //   };
  //
  //   final response = await http.post(url, body: json.encode(params), headers: headers);
  //
  //   if (response.statusCode != 200) {
  //     throw Exception('Failed to deposit money');
  //   }
  // }

  Future<void> transferMoney(
      int senderId, int receiverId, double amount, String description) async {
    final url = Uri.parse(
        '$baseUrl/transfer?senderId=$senderId&receiverId=$receiverId&amount=$amount&description=$description');
    final response = await http.post(url);

    if (response.statusCode == 200) {
      print('Transfer successful: ${response.body}');
    } else {
      throw Exception('Failed to transfer: ${response.body}');
    }
  }

  // Future<void> transferMoney(
  //     int senderId, int receiverId, double amount, String description) async {
  //   final headers = await _getAuthHeaders();
  //   final url = Uri.parse('${baseUrl}/transfer');
  //   final params = {
  //     'senderId': senderId.toString(),
  //     'receiverId': receiverId.toString(),
  //     'amount': amount.toString(),
  //     'description': description,
  //   };
  //
  //   final response =
  //       await http.post(url, body: json.encode(params), headers: headers);
  //
  //   print('Status code: ${response.statusCode}');
  //   print('Response body: ${response.body}');
  //
  //   if (response.statusCode != 200) {
  //     throw Exception('Failed to transfer money');
  //   }
  // }

  Future<void> withdrawMoney(
      int userId, double amount, String description) async {
    final url = Uri.parse(
        '$baseUrl/withdraw?userId=$userId&amount=$amount&description=$description');
    final response = await http.post(url);

    if (response.statusCode == 200) {
      print('Withdrawal successful: ${response.body}');
    } else {
      throw Exception('Failed to withdraw: ${response.body}');
    }
  }

  // Future<void> withdrawMoney(
  //     int userId, double amount, String description) async {
  //   final headers = await _getAuthHeaders();
  //   final url = Uri.parse('${baseUrl}/withdraw');
  //   final params = {
  //     'userId': userId.toString(),
  //     'amount': amount.toString(),
  //     'description': description,
  //   };
  //
  //   final response =
  //       await http.post(url, body: json.encode(params), headers: headers);
  //
  //   if (response.statusCode != 200) {
  //     throw Exception('Failed to withdraw money');
  //   }
  // }

  Future<void> updateTransactionStatus(int transactionId, String status) async {
    final headers = await _getAuthHeaders();
    final response = await http.put(
      Uri.parse('${baseUrl}/$transactionId/status'),
      headers: headers,
      body: json.encode({'status': status}),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to update transaction status');
    }
  }

  Future<void> deleteTransaction(int id) async {
    final headers = await _getAuthHeaders();
    final response =
        await http.delete(Uri.parse('$baseUrl/$id'), headers: headers);

    if (response.statusCode != 200) {
      throw Exception('Failed to delete transaction');
    }
  }
}
