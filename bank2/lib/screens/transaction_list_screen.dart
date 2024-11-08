import 'package:bank2/models/transaction.dart';
import 'package:bank2/services/transaction_service.dart';
import 'package:flutter/material.dart';


class TransactionListScreen extends StatefulWidget {
  @override
  _TransactionListScreenState createState() => _TransactionListScreenState();
}

class _TransactionListScreenState extends State<TransactionListScreen> {
  final TransactionService transactionService = TransactionService();
  late Future<List<Transaction>> transactions;
  String errorMessage = '';

  @override
  void initState() {
    super.initState();
    // fetchTransactions();
    transactions = transactionService.getTransactions();
  }

  // Future<void> fetchTransactions() async {
  //   try {
  //     List<Transaction> fetchedTransactions = await transactionService.getTransactions();
  //     setState(() {
  //       transactions = fetchedTransactions;
  //     });
  //   } catch (error) {
  //     setState(() {
  //       errorMessage = 'Error fetching transaction data';
  //     });
  //     print(error);
  //   }
  // }
  //
  // Future<void> changeTransactionStatus(int transactionId, String status) async {
  //   try {
  //     await transactionService.updateTransactionStatus(transactionId, status);
  //     setState(() {
  //       transactions = transactions.map((transaction) {
  //         if (transaction.id == transactionId) {
  //           return transaction.copyWith(status: status);
  //         }
  //         return transaction;
  //       }).toList();
  //     });
  //   } catch (error) {
  //     setState(() {
  //       errorMessage = 'Failed to update transaction status. Please try again.';
  //     });
  //     print(error);
  //   }
  // }
  //
  // Future<void> deleteTransaction(int transactionId) async {
  //   bool confirmDelete = await showDialog(
  //     context: context,
  //     builder: (BuildContext context) => AlertDialog(
  //       title: Text('Confirm Delete'),
  //       content: Text('Are you sure you want to delete this transaction?'),
  //       actions: [
  //         TextButton(
  //           onPressed: () => Navigator.of(context).pop(false),
  //           child: Text('Cancel'),
  //         ),
  //         TextButton(
  //           onPressed: () => Navigator.of(context).pop(true),
  //           child: Text('Delete'),
  //         ),
  //       ],
  //     ),
  //   );
  //
  //   if (confirmDelete) {
  //     try {
  //       await transactionService.deleteTransaction(transactionId);
  //       setState(() {
  //         transactions.removeWhere((transaction) => transaction.id == transactionId);
  //       });
  //     } catch (error) {
  //       setState(() {
  //         errorMessage = 'Failed to delete transaction. Please try again.';
  //       });
  //       print(error);
  //     }
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Transaction List')),
      body: Column(),
      // body: FutureBuilder<List<Transaction>>(future: transactions, builder: (context, snapshot){
      //
      // }),
      // body: Padding(
      //   padding: const EdgeInsets.all(8.0),
      //   child: Column(
      //     children: [
      //       if (errorMessage.isNotEmpty)
      //         Text(
      //           errorMessage,
      //           style: TextStyle(color: Colors.red),
      //         ),
      //       transactions.isNotEmpty
      //           ? Expanded(
      //         child: ListView.builder(
      //           itemCount: transactions.length,
      //           itemBuilder: (context, index) {
      //             final transaction = transactions[index];
      //             return Card(
      //               margin: const EdgeInsets.symmetric(vertical: 4),
      //               child: ListTile(
      //                 title: Text(
      //                   'Transaction ID: ${transaction.id}',
      //                   style: TextStyle(fontWeight: FontWeight.bold),
      //                 ),
      //                 subtitle: Column(
      //                   crossAxisAlignment: CrossAxisAlignment.start,
      //                   children: [
      //                     Text('Date: ${transaction.transactionDate}'),
      //                     Text('Description: ${transaction.description}'),
      //                     Text('Amount: \$${transaction.amount.toStringAsFixed(2)}'),
      //                     Text('Transaction Type: ${transaction.transactionType}'),
      //                     Text('Target Account: ${transaction.targetAccountNumber}'),
      //                     Text('Status: ${transaction.status}'),
      //                   ],
      //                 ),
      //                 // trailing: Column(
      //                 //   children: [
      //                 //     if (transaction.status == 'PENDING') ...[
      //                 //       ElevatedButton(
      //                 //         onPressed: () =>
      //                 //             changeTransactionStatus(transaction.id, 'APPROVED'),
      //                 //         child: Text('Approve'),
      //                 //       ),
      //                 //       ElevatedButton(
      //                 //         onPressed: () =>
      //                 //             changeTransactionStatus(transaction.id, 'DECLINED'),
      //                 //         child: Text('Decline'),
      //                 //       ),
      //                 //     ] else if (transaction.status == 'APPROVED') ...[
      //                 //       Text('Approved', style: TextStyle(color: Colors.green)),
      //                 //     ] else if (transaction.status == 'DECLINED') ...[
      //                 //       Text('Declined', style: TextStyle(color: Colors.red)),
      //                 //     ],
      //                 //   ],
      //                 // ),
      //               ),
      //             );
      //           },
      //         ),
      //       )
      //           : Text('No transactions available.'),
      //     ],
      //   ),
      // ),
    );
  }
}
