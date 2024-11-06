import 'package:flutter/material.dart';
import '../../services/transaction_service.dart';

class DepositScreen extends StatefulWidget {
  @override
  _DepositScreenState createState() => _DepositScreenState();
}

class _DepositScreenState extends State<DepositScreen> {
  final TransactionService transactionService = TransactionService();

  int userId = 0;
  double amount = 0;
  String description = '';
  String message = '';
  String errorMessage = '';

  final _formKey = GlobalKey<FormState>();

  void makeDeposit() async {
    if (_formKey.currentState?.validate() ?? false) {
      try {
        await transactionService.depositMoney(userId, amount, description);
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text("Deposit Pending"),
            content: Text(
                "Your deposit of $amount is pending approval. Once approved by the admin, your balance will be updated."),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text("OK"),
              ),
            ],
          ),
        );

        setState(() {
          message = 'Successfully deposited $amount for user $userId.';
          errorMessage = '';
          clearForm();
        });
      } catch (error) {
        setState(() {
          errorMessage = 'An error occurred during the deposit. Please try again.';
          message = '';
        });
        print(error);
      }
    }
  }

  void clearForm() {
    setState(() {
      userId = 0;
      amount = 0;
      description = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(title: Text('Deposit')),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _formKey,
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'User ID'),
                keyboardType: TextInputType.number,
                onChanged: (value) => userId = int.tryParse(value) ?? 0,
                validator: (value) {
                  if (value == null || value.isEmpty || int.tryParse(value) == null) {
                    return 'Please enter a valid user ID';
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Amount'),
                keyboardType: TextInputType.number,
                onChanged: (value) => amount = double.tryParse(value) ?? 0,
                validator: (value) {
                  if (value == null || value.isEmpty || double.tryParse(value) == null || double.parse(value) <= 0) {
                    return 'Deposit amount must be greater than zero.';
                  }
                  return null;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Description'),
                onChanged: (value) => description = value,
              ),
              SizedBox(height: 10.0),
              ElevatedButton(
                onPressed: makeDeposit,
                child: Text('Make Deposit'),
              ),
              if (errorMessage.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Text(
                    errorMessage,
                    style: TextStyle(color: Colors.red),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}


// import 'package:bank_flutter/services/transaction_service.dart';
// import 'package:flutter/material.dart';
// import 'transaction_service.dart'; // Import your service
//
// class DepositScreen extends StatefulWidget {
//   final int userId;
//
//   const DepositScreen({Key? key, required this.userId}) : super(key: key);
//
//   @override
//   _DepositScreenState createState() => _DepositScreenState();
// }
//
// class _DepositScreenState extends State<DepositScreen> {
//   final _formKey = GlobalKey<FormState>();
//   final _amountController = TextEditingController();
//   final _descriptionController = TextEditingController();
// final _transactionService = TransactionService('http://localhost:8881/api/transactions/deposit'); // Base URL of your API
//
//   final TransactionService _transactionService = TransactionService();
//
//   bool _isLoading = false;
//
//   Future<void> _performDeposit() async {
//     if (!_formKey.currentState!.validate()) return;
//
//     setState(() {
//       _isLoading = true;
//     });
//
//     try {
//       final amount = double.parse(_amountController.text);
//       final description = _descriptionController.text;
//
//       await _transactionService.depositMoney(
//         widget.userId,
//         amount,
//         description,
//       );
//
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Deposit successful')),
//       );
//
//       // Clear fields after successful deposit
//       _amountController.clear();
//       _descriptionController.clear();
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Failed to deposit money: $e')),
//       );
//     } finally {
//       setState(() {
//         _isLoading = false;
//       });
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Deposit Money'),
//       ),
//       body: Padding(
//         padding: EdgeInsets.all(16.0),
//         child: Form(
//           key: _formKey,
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               TextFormField(
//                 controller: _amountController,
//                 decoration: InputDecoration(labelText: 'Amount'),
//                 keyboardType: TextInputType.numberWithOptions(decimal: true),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter an amount';
//                   }
//                   if (double.tryParse(value) == null) {
//                     return 'Enter a valid number';
//                   }
//                   return null;
//                 },
//               ),
//               SizedBox(height: 16.0),
//               TextFormField(
//                 controller: _descriptionController,
//                 decoration: InputDecoration(labelText: 'Description'),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter a description';
//                   }
//                   return null;
//                 },
//               ),
//               SizedBox(height: 32.0),
//               _isLoading
//                   ? Center(child: CircularProgressIndicator())
//                   : SizedBox(
//                 width: double.infinity,
//                 child: ElevatedButton(
//                   onPressed: _performDeposit,
//                   child: Text('Deposit'),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   @override
//   void dispose() {
//     _amountController.dispose();
//     _descriptionController.dispose();
//     super.dispose();
//   }
// }



// // deposit_screen.dart
// import 'package:bank_flutter/services/transaction_service.dart';
// import 'package:flutter/material.dart';
//
// class DepositScreen extends StatefulWidget {
//   @override
//   _DepositScreenState createState() => _DepositScreenState();
// }
//
// class _DepositScreenState extends State<DepositScreen> {
//
//   final TransactionService transactionService = TransactionService();
//
//   final TextEditingController _amountController = TextEditingController();
//
//   void _makeDeposit() {
//     // Implement your deposit logic here, such as sending data to backend
//     String amount = _amountController.text;
//     if (amount.isNotEmpty) {
//       // Handle the deposit logic
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Deposited \$${amount} successfully!')),
//       );
//       _amountController.clear(); // Clear the field after deposit
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           TextField(
//             controller: _amountController,
//             keyboardType: TextInputType.number,
//             decoration: InputDecoration(
//               labelText: 'Enter deposit amount',
//               border: OutlineInputBorder(),
//             ),
//           ),
//           SizedBox(height: 10),
//           ElevatedButton(
//             onPressed: _makeDeposit,
//             child: Text('Deposit'),
//           ),
//         ],
//       ),
//     );
//   }
// }

