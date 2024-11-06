import 'transaction_type.dart';
import 'user.dart';

class Transaction {
  final int id;
  final String transactionDate;
  final double amount;
  final TransactionType transactionType; // deposit, withdraw, fund transfer
  final String description;
  final String targetAccountNumber;
  final String status;
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
  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
      id: json['id'],
      transactionDate: json['transactionDate'],
      amount: json['amount'].toDouble(),
      // transactionType: TransactionType.fromJson(json['transactionType']),
      transactionType: transactionTypeFromJson(json['transactionType']),
      description: json['description'],
      targetAccountNumber: json['targetAccountNumber'],
      status: json['status'],
      userId: User.fromJson(json['userid']),
    );
  }

  // Method to convert a Transaction instance into a JSON object
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'transactionDate': transactionDate,
      'amount': amount,
      // 'transactionType': transactionType.toJson(),
      'transactionType': transactionTypeToJson(transactionType),
      'description': description,
      'targetAccountNumber': targetAccountNumber,
      'status': status,
      'userid': userId.toJson(),
    };
  }
}
