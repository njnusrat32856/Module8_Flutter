import 'package:bank2/models/transaction.dart';
import 'package:bank2/services/transaction_service.dart';
import 'package:flutter/material.dart';

class BankStatementScreen extends StatefulWidget {
  final int userId;
  // const BankStatementScreen({super.key});
  const BankStatementScreen({super.key, required this.userId});

  // const BankStatementScreen({Key? key, required this.userId}) : super(key: key);

  @override
  State<BankStatementScreen> createState() => _BankStatementScreenState();
}

class _BankStatementScreenState extends State<BankStatementScreen> {
  late Future<List<Transaction>> transactions;
  // late Future<List<Map<String, dynamic>>> transactions;
  final TransactionService transactionService = TransactionService();

  // @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   transactions = transactionService.getTransactions();
  // }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    transactions = transactionService.getTransactionsByUserId(widget.userId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Bank Statement"),
        backgroundColor: Color.fromARGB(255, 16, 80, 98),
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color.fromARGB(255, 16, 80, 98), Color.fromARGB(255, 32, 160, 180)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Recent Transactions",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: FutureBuilder<List<Transaction>>(
                future: transactions,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator(color: Colors.white));
                  } else if (snapshot.hasError) {
                    return Center(child: Text("Error: ${snapshot.error}", style: TextStyle(color: Colors.white)));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Center(child: Text("No transactions found", style: TextStyle(color: Colors.white)));
                  } else {
                    return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        final transaction = snapshot.data![index];
                        // return Card(
                        //   color: Colors.white.withOpacity(0.9),
                        //   margin: EdgeInsets.symmetric(vertical: 8.0),
                        //   shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        //   child: ListTile(
                        //     leading: Icon(
                        //       transaction.amount < 0 ? Icons.remove_circle : Icons.add_circle,
                        //       color: transaction.amount < 0 ? Colors.red : Colors.green,
                        //     ),
                        //     title: Text(
                        //       transaction.description,
                        //       style: TextStyle(fontWeight: FontWeight.bold),
                        //     ),
                        //     subtitle: Text(
                        //       transaction.transactionDate,
                        //       style: TextStyle(color: Colors.grey[600]),
                        //     ),
                        //     trailing: Text(
                        //       "${transaction.amount < 0 ? "-" : "+"} \$${transaction.amount.abs().toStringAsFixed(2)}",
                        //       style: TextStyle(
                        //         fontWeight: FontWeight.bold,
                        //         color: transaction.amount < 0 ? Colors.red : Colors.green,
                        //       ),
                        //     ),
                        //   ),
                        // );
                        return _buildTransactionCard(transaction);
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTransactionCard(Transaction transaction) {
    return Card(
      color: Colors.white.withOpacity(0.9),
      margin: EdgeInsets.symmetric(vertical: 8.0),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: ListTile(
        leading: Icon(
          transaction.amount < 0 ? Icons.remove_circle : Icons.add_circle,
          color: transaction.amount < 0 ? Colors.red : Colors.green,
        ),
        title: Text(
          transaction.description,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          transaction.transactionDate,
          style: TextStyle(color: Colors.grey[600]),
        ),
        trailing: Text(
          "${transaction.amount < 0 ? "-" : "+"} \$${transaction.amount.abs().toStringAsFixed(2)}",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: transaction.amount < 0 ? Colors.red : Colors.green,
          ),
        ),
      ),
    );
  }
}
