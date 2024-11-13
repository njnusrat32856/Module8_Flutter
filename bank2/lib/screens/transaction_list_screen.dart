import 'package:flutter/material.dart';
import 'package:bank2/models/transaction.dart';
import 'package:bank2/services/transaction_service.dart';

class TransactionListScreen extends StatefulWidget {
  @override
  _TransactionListScreenState createState() => _TransactionListScreenState();
}

class _TransactionListScreenState extends State<TransactionListScreen> {
  final TransactionService _transactionService = TransactionService();
  late Future<List<Transaction>> _transactions;

  // @override
  // void initState() {
  //   super.initState();
  //   _transactions = _transactionService.getAllTransactions();
  // }
  @override
  void initState() {
    super.initState();
    _fetchTransactions();
  }

  void _fetchTransactions() {
    setState(() {
      _transactions = _transactionService.getAllTransactions();
    });
  }

  Future<void> _approveTransaction(Transaction transaction) async {
    try {
      await _transactionService.updateTransactionStatus(transaction.id, "Approved");
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Transaction Approved")));
      _fetchTransactions(); // Refresh the list after updating
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Failed to approve transaction")));
    }
  }

  Future<void> _denyTransaction(Transaction transaction) async {
    try {
      await _transactionService.updateTransactionStatus(transaction.id, "Denied");
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Transaction Denied")));
      _fetchTransactions(); // Refresh the list after updating
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Failed to deny transaction")));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton.outlined(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.arrow_back_ios_new),
          color: Colors.white,
        ),
        title: Text(
            "All Transactions",
          style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: Colors.white
          ),
        ),
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 16, 80, 98),
      ),
      body: FutureBuilder<List<Transaction>>(
        future: _transactions,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}", style: TextStyle(color: Colors.red)));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text("No transactions available"));
          } else {
            return ListView.builder(
              padding: EdgeInsets.all(10),
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final transaction = snapshot.data![index];
                return _buildTransactionCard(transaction);
              },
            );
          }
        },
      ),
    );
  }

  Widget _buildTransactionCard(Transaction transaction) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  _getIconForTransactionType(transaction.transactionType),
                  color: _getColorForTransactionType(transaction.transactionType),
                  // transaction.amount < 0 ? Icons.remove_circle : Icons.add_circle,
                  // color: transaction.amount < 0 ? Colors.red : Colors.green,
                ),
                SizedBox(width: 10),
                Text(
                  transaction.transactionType ?? 'Unknown',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
            SizedBox(height: 8),
            Text(
              transaction.description,
              style: TextStyle(fontSize: 14, color: Colors.grey[700]),
            ),
            SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Date: ${transaction.transactionDate}",
                  style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                ),
                Text(
                  "\$${transaction.amount.toStringAsFixed(2)}",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: transaction.amount < 0 ? Colors.red : Colors.green,
                  ),
                ),
              ],
            ),
            SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  onPressed: () => _approveTransaction(transaction),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                      "Approve",
                    style: TextStyle(
                      color: Colors.white
                    ),
                  ),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () => _denyTransaction(transaction),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Text(
                      "Deny",
                    style: TextStyle(
                        color: Colors.white
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
  IconData _getIconForTransactionType(String? type) {
    switch (type) {
      case 'deposit':
        return Icons.arrow_downward;
      case 'withdraw':
        return Icons.arrow_upward;
      case 'fundTransfer':
        return Icons.swap_horiz;
      default:
        return Icons.help_outline;
    }
  }

  Color _getColorForTransactionType(String? type) {
    switch (type) {
      case 'deposit':
        return Colors.green;
      case 'withdraw':
        return Colors.red;
      case 'fundTransfer':
        return Colors.blue;
      default:
        return Colors.grey;
    }
  }
}
