import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class TransactionList extends StatelessWidget {
  const TransactionList({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Today, Oct 28'),
                  Row(
                    children: [
                      Text('All Transaction')
                    ],
                  ),

                ],
              ),
            ),
            ListTile(
              leading: CircleAvatar(
                backgroundColor: Color.fromARGB(255, 239, 243, 245),
                child: Icon(
                  Icons.fitness_center,
                  color: Colors.purpleAccent,
                ),
              ),
              title: Text('Gym'),
              subtitle: Text('Payment'),
              trailing: Text(
                "-\$40.50",
                style: TextStyle(
                  color: Colors.red
                ),
              ),
            ),
            Divider(color: Colors.grey[200],),
            ListTile(
              leading: CircleAvatar(
                backgroundColor: Color.fromARGB(255, 239, 243, 245),
                child: Icon(
                  Icons.account_balance,
                  color: Colors.teal,
                ),
              ),
              title: Text('Dhaka Bank'),
              subtitle: Text('Deposit'),
              trailing: Text(
                "+\$550.50",
                style: TextStyle(
                  color: Colors.teal
                ),
              ),
            ),
            Divider(color: Colors.grey[200],),
            ListTile(
              leading: CircleAvatar(
                backgroundColor: Color.fromARGB(255, 239, 243, 245),
                child: Icon(
                  Icons.send,
                  color: Colors.orangeAccent,
                ),
              ),
              title: Text('To Raju Ahmed'),
              subtitle: Text('Sent'),
              trailing: Text(
                "-\$50.50",
                style: TextStyle(
                  color: Colors.red
                ),
              ),
            ),
            Divider(color: Colors.grey[200],),
          ],
        ),
    );
  }
}
