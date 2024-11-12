import 'package:flutter/material.dart';
import 'package:bank2/services/transaction_service.dart';

class WithdrawScreen extends StatefulWidget {
  const WithdrawScreen({super.key});

  @override
  State<WithdrawScreen> createState() => _WithdrawScreenState();
}

class _WithdrawScreenState extends State<WithdrawScreen> {
  final TransactionService transactionService = TransactionService();
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;

  int userId = 0;
  double amount = 0;
  String description = '';
  String message = '';
  String errorMessage = '';

  void makeWithdrawal() async {
    if (_formKey.currentState?.validate() ?? false) {
      setState(() {
        isLoading = true;
        message = '';
        errorMessage = '';
      });

      try {
        await transactionService.withdrawMoney(userId, amount, description);
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text("Withdrawal Successful"),
            content: Text(
              "Your withdrawal has been processed successfully.",
              // "Your withdrawal of \$${amount.toStringAsFixed(2)} has been processed successfully.",
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text("OK"),
              ),
            ],
          ),
        );

        setState(() {
          message = 'Successfully withdrew \$${amount.toStringAsFixed(2)} for user $userId.';
          clearForm();
        });
      } catch (error) {
        setState(() {
          errorMessage = 'An error occurred during the withdrawal: $error';
        });
      } finally {
        setState(() {
          isLoading = false;
        });
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
      appBar: AppBar(
        leading: IconButton.outlined(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.arrow_back_ios_new),
          color: Colors.white,
        ),
        title: Text(
            "Withdraw",
          style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: Colors.greenAccent
          ),
        ),
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 16, 80, 98),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color.fromARGB(255, 16, 80, 98), Color.fromARGB(255, 32, 160, 180)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Withdraw Funds",
                style: TextStyle(
                  fontSize: 24,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20),
              _buildInputField(
                label: 'User ID',
                onChanged: (value) => userId = int.tryParse(value) ?? 0,
                validator: (value) {
                  if (value == null || value.isEmpty || int.tryParse(value) == null) {
                    return 'Please enter a valid user ID';
                  }
                  return null;
                },
                icon: Icons.person,
              ),
              SizedBox(height: 20),
              _buildInputField(
                label: 'Amount',
                onChanged: (value) => amount = double.tryParse(value) ?? 0,
                validator: (value) {
                  if (value == null || value.isEmpty || double.tryParse(value) == null || double.parse(value) <= 0) {
                    return 'Withdrawal amount must be greater than zero.';
                  }
                  return null;
                },
                icon: Icons.attach_money,
              ),
              SizedBox(height: 20),
              _buildInputField(
                label: 'Description',
                onChanged: (value) => description = value,
                icon: Icons.description,
              ),
              SizedBox(height: 30),
              Center(
                child: ElevatedButton(
                  onPressed: isLoading ? null : makeWithdrawal,
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 40, vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    backgroundColor: Colors.white,
                    foregroundColor: Color.fromARGB(255, 16, 80, 98),
                  ),
                  child: isLoading
                      ? CircularProgressIndicator(color: Colors.teal)
                      : Text(
                    'Make Withdrawal',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              if (errorMessage.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Center(
                    child: Text(
                      errorMessage,
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
                ),
              if (message.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: Center(
                    child: Text(
                      message,
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInputField({
    required String label,
    required Function(String) onChanged,
    String? Function(String?)? validator,
    required IconData icon,
  }) {
    return TextFormField(
      onChanged: onChanged,
      validator: validator,
      style: TextStyle(color: Colors.white),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: Colors.white70),
        filled: true,
        fillColor: Colors.white.withOpacity(0.1),
        prefixIcon: Icon(icon, color: Colors.white70),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     appBar: AppBar(
  //       leading: IconButton.outlined(
  //         onPressed: () => Navigator.pop(context),
  //         icon: Icon(Icons.arrow_back_ios_new),
  //       ),
  //       title: Text("Withdraw"),
  //     ),
  //     body: Padding(
  //       padding: const EdgeInsets.all(8.0),
  //       child: Form(
  //         key: _formKey,
  //         child: Column(
  //           children: [
  //             TextFormField(
  //               decoration: InputDecoration(labelText: 'User ID'),
  //               keyboardType: TextInputType.number,
  //               onChanged: (value) => userId = int.tryParse(value) ?? 0,
  //               validator: (value) {
  //                 if (value == null || value.isEmpty || int.tryParse(value) == null) {
  //                   return 'Please enter a valid user ID';
  //                 }
  //                 return null;
  //               },
  //             ),
  //             TextFormField(
  //               decoration: InputDecoration(labelText: 'Amount'),
  //               keyboardType: TextInputType.number,
  //               onChanged: (value) => amount = double.tryParse(value) ?? 0,
  //               validator: (value) {
  //                 if (value == null || value.isEmpty || double.tryParse(value) == null || double.parse(value) <= 0) {
  //                   return 'Withdrawal amount must be greater than zero.';
  //                 }
  //                 return null;
  //               },
  //             ),
  //             TextFormField(
  //               decoration: InputDecoration(labelText: 'Description'),
  //               onChanged: (value) => description = value,
  //             ),
  //             SizedBox(height: 10.0),
  //             ElevatedButton(
  //               onPressed: isLoading ? null : makeWithdrawal,
  //               child: isLoading
  //                   ? CircularProgressIndicator(color: Colors.white)
  //                   : Text('Make Withdrawal'),
  //             ),
  //             if (errorMessage.isNotEmpty)
  //               Padding(
  //                 padding: const EdgeInsets.only(top: 8.0),
  //                 child: Text(
  //                   errorMessage,
  //                   style: TextStyle(color: Colors.red),
  //                 ),
  //               ),
  //             if (message.isNotEmpty)
  //               Padding(
  //                 padding: const EdgeInsets.only(top: 8.0),
  //                 child: Text(
  //                   message,
  //                   style: TextStyle(color: Colors.green),
  //                 ),
  //               ),
  //           ],
  //         ),
  //       ),
  //     ),
  //   );
  // }
}
