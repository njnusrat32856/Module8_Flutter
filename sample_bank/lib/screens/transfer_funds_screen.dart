import 'package:flutter/material.dart';

class TransferFundsScreen extends StatelessWidget {
  final TextEditingController _recipientController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();

  void _transferFunds() {
    // Handle fund transfer logic
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Transfer Funds')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _recipientController,
              decoration: InputDecoration(labelText: 'Recipient Account ID'),
            ),
            TextField(
              controller: _amountController,
              decoration: InputDecoration(labelText: 'Amount'),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _transferFunds,
              child: Text('Transfer'),
            ),
          ],
        ),
      ),
    );
  }
}
