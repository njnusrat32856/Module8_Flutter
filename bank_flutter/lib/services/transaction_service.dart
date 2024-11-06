import 'dart:convert';
import 'package:bank_flutter/models/transaction.dart';
import 'package:bank_flutter/services/auth_service.dart';
import 'package:http/http.dart' as http;


class TransactionService {
  final String baseUrl = 'http://localhost:8881/api/transactions/';
  final AuthService userService = AuthService();

  Future<Map<String, String>> _getAuthHeaders() async {
    final token = await userService.getToken();
    return {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json'
    };
  }

  Future<List<Transaction>> getTransactions() async {
    final headers = await _getAuthHeaders();
    final response = await http.get(Uri.parse(baseUrl), headers: headers);

    if (response.statusCode == 200) {
      final List<dynamic> transactionData = json.decode(response.body);
      return transactionData.map((data) => Transaction.fromJson(data)).toList();
    } else {
      throw Exception('Failed to load transactions');
    }
  }

  Future<Transaction> getTransactionById(int id) async {
    final headers = await _getAuthHeaders();
    final response = await http.get(Uri.parse('$baseUrl$id'), headers: headers);

    if (response.statusCode == 200) {
      return Transaction.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load transaction');
    }
  }

  Future<List<Transaction>> getTransactionsByUserId(int userId) async {
    final headers = await _getAuthHeaders();
    final response = await http.get(Uri.parse('${baseUrl}user/$userId'), headers: headers);

    if (response.statusCode == 200) {
      final List<dynamic> transactionData = json.decode(response.body);
      return transactionData.map((data) => Transaction.fromJson(data)).toList();
    } else {
      throw Exception('Failed to load user transactions');
    }
  }

  Future<void> depositMoney(int userId, double amount, String description) async {
    final url = Uri.parse('${baseUrl}deposit');
    final params = {
      'userId': userId.toString(),
      'amount': amount.toString(),
      'description': description,
    };

    final response = await http.post(url, body: json.encode(params), headers: await _getAuthHeaders());

    if (response.statusCode != 200) {
      throw Exception('Failed to deposit money');
    }
  }

  Future<void> transferMoney(int senderId, int receiverId, double amount, String description) async {
    final url = Uri.parse('${baseUrl}transfer');
    final params = {
      'senderId': senderId.toString(),
      'receiverId': receiverId.toString(),
      'amount': amount.toString(),
      'description': description,
    };

    final response = await http.post(url, body: json.encode(params), headers: await _getAuthHeaders());

    if (response.statusCode != 200) {
      throw Exception('Failed to transfer money');
    }
  }

  Future<void> withdrawMoney(int userId, double amount, String description) async {
    final url = Uri.parse('${baseUrl}withdraw');
    final params = {
      'userId': userId.toString(),
      'amount': amount.toString(),
      'description': description,
    };

    final response = await http.post(url, body: json.encode(params), headers: await _getAuthHeaders());

    if (response.statusCode != 200) {
      throw Exception('Failed to withdraw money');
    }
  }

  Future<void> updateTransactionStatus(int transactionId, String status) async {
    final headers = await _getAuthHeaders();
    final response = await http.put(
      Uri.parse('${baseUrl}$transactionId/status'),
      headers: headers,
      body: json.encode({'status': status}),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to update transaction status');
    }
  }

  Future<void> deleteTransaction(int id) async {
    final headers = await _getAuthHeaders();
    final response = await http.delete(Uri.parse('$baseUrl$id'), headers: headers);

    if (response.statusCode != 200) {
      throw Exception('Failed to delete transaction');
    }
  }
}
