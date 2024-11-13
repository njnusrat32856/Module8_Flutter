import 'transaction_type.dart';
import 'user.dart';

class Transaction {
  final int id;
  final String transactionDate;
  final double amount;
  final String? transactionType; // deposit, withdraw, fund transfer
  // final TransactionType transactionType; // deposit, withdraw, fund transfer
  final String description;
  final String targetAccountNumber;
  final String? status;
  final User userId;

  Transaction({
    required this.id,
    required this.transactionDate,
    required this.amount,
    required this.transactionType,
    required this.description,
    required this.targetAccountNumber,
    required this.status,
    required this.userId,
  });

  // Factory constructor for creating a new Transaction instance from a JSON object
  factory Transaction.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      throw Exception("Transaction data is null");
    }

    return Transaction(
      id: json['id'] ?? 0,
      transactionDate: json['transactionDate'] ?? '',
      amount: (json['amount'] as num?)?.toDouble() ?? 0.0,
      transactionType: json["transactionType"] ?? 'unknown',
      description: json['description'] ?? 'No description available',
      targetAccountNumber: json['targetAccountNumber'] ?? 'N/A',
      status: json['status'] ?? 'pending',
      userId: User.fromJson(json['userid'] ?? {}),
    );
  }

  // Method to convert a Transaction instance into a JSON object
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'transactionDate': transactionDate,
      'amount': amount,
      'transactionType': transactionType,
      // 'transactionType': transactionType.toJson(),
      // 'transactionType': transactionTypeToJson(transactionType),
      'description': description,
      'targetAccountNumber': targetAccountNumber,
      'status': status,
      'userid': userId.toJson(),
    };
  }
}
