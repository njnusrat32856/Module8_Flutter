import 'package:bank2/services/transaction_service.dart';
import 'package:flutter/material.dart';

class DepositScreen extends StatefulWidget {
  const DepositScreen({super.key});

  @override
  State<DepositScreen> createState() => _DepositScreenState();
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
      setState(() {
        message = '';
        errorMessage = '';
      });

      try {
        await transactionService.depositMoney(userId, amount, description);
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text("Deposit Successful"),
            content: Text("Your deposit of \$${amount.toStringAsFixed(2)} has been processed."),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text("OK"),
              ),
            ],
          ),
        );

        setState(() {
          message = 'Successfully deposited \$${amount.toStringAsFixed(2)} for user $userId.';
          clearForm();
        });
      } catch (error) {
        setState(() {
          errorMessage = 'An error occurred during the deposit: $error';
        });
      }
    }
  }


  // void makeDeposit() async {
  //   if (_formKey.currentState?.validate() ?? false) {
  //     try {
  //       await transactionService.depositMoney(userId, amount, description);
  //       showDialog(
  //         context: context,
  //         builder: (context) => AlertDialog(
  //           title: Text("Deposit Pending"),
  //           content: Text(
  //               "Your deposit of $amount is pending approval. Once approved by the admin, your balance will be updated."),
  //           actions: [
  //             TextButton(
  //               onPressed: () => Navigator.pop(context),
  //               child: Text("OK"),
  //             ),
  //           ],
  //         ),
  //       );
  //
  //       setState(() {
  //         message = 'Successfully deposited $amount for user $userId.';
  //         errorMessage = '';
  //         clearForm();
  //       });
  //     } catch (error) {
  //       setState(() {
  //         errorMessage = 'An error occurred during the deposit. Please try again.';
  //         message = '';
  //       });
  //       print(error);
  //     }
  //   }
  // }

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
      appBar: AppBar(
        leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: Icon(Icons.arrow_back_ios_new)
        ),
        title: Text("Transfer"),
      ),
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
