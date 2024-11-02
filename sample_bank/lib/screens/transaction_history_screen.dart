import 'package:flutter/material.dart';
import 'package:sample_bank/models/transaction.dart';

class TransactionHistoryScreen extends StatelessWidget {
  final List<Transaction> transactions = [
    Transaction(id: '1', description: 'Deposit', amount: 500.0, date: DateTime.now().subtract(Duration(days: 1))),
    Transaction(id: '2', description: 'Withdrawal', amount: 200.0, date: DateTime.now().subtract(Duration(days: 2))),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Transaction History')),
      body: ListView.builder(
        itemCount: transactions.length,
        itemBuilder: (context, index) {
          final transaction = transactions[index];
          return ListTile(
            title: Text(transaction.description),
            subtitle: Text(transaction.date.toString()),
            trailing: Text(transaction.amount.toStringAsFixed(2)),
          );
        },
      ),
    );
  }
}
