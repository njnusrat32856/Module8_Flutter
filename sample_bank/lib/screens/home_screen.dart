import 'package:flutter/material.dart';
import 'package:sample_bank/models/user.dart';
import 'package:sample_bank/screens/login_screen.dart';
import 'package:sample_bank/screens/transaction_history_screen.dart';
import 'package:sample_bank/screens/transfer_funds_screen.dart';

class HomeScreen extends StatelessWidget {
  final User currentUser = User(userId: '12345', name: 'John Doe', balance: 1000.0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Account Summary')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Welcome, ${currentUser.name}!', style: TextStyle(fontSize: 24)),
            SizedBox(height: 20),
            Text('Account Balance: \$${currentUser.balance}', style: TextStyle(fontSize: 18)),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Navigate to transactions
                Navigator.push(context, MaterialPageRoute(builder: (context) => TransactionHistoryScreen()));
              },
              child: Text('View Transaction History'),
            ),
            SizedBox(height: 20,),
            ElevatedButton(
              onPressed: () {
                // Navigate to transfer funds
                Navigator.push(context, MaterialPageRoute(builder: (context) => TransferFundsScreen()));
              },
              child: Text('Transfer Funds'),
            ),
            SizedBox(height: 20,),
            ElevatedButton(
              onPressed: () {
                // Navigate to transfer funds
                // Navigator.push(context, MaterialPageRoute(builder: (context) => LoginScreen()));
                LoginScreen();
              },
              child: Text('Logout'),
            ),
          ],
        ),
      ),
    );
  }
}
