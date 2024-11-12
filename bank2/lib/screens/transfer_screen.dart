import 'package:flutter/material.dart';
import 'package:bank2/services/transaction_service.dart';

class TransferScreen extends StatefulWidget {
  const TransferScreen({super.key});

  @override
  State<TransferScreen> createState() => _TransferScreenState();
}

class _TransferScreenState extends State<TransferScreen> {
  final TransactionService transactionService = TransactionService();
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false;

  int senderId = 0;
  int receiverId = 0;
  double amount = 0;
  String description = '';
  String message = '';
  String errorMessage = '';

  void makeTransfer() async {
    if (_formKey.currentState?.validate() ?? false) {
      setState(() {
        isLoading = true;
        message = '';
        errorMessage = '';
      });

      try {
        await transactionService.transferMoney(senderId, receiverId, amount, description);
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text("Transfer Successful"),
            content: Text(
              "Your transfer funds has been processed successfully.",
              // "Your transfer of \$${amount.toStringAsFixed(2)} from user $senderId to user $receiverId has been processed successfully.",
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
          message = 'Successfully transferred \$${amount.toStringAsFixed(2)} from user $senderId to user $receiverId.';
          clearForm();
        });
      } catch (error) {
        setState(() {
          errorMessage = 'An error occurred during the transfer: $error';
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
      senderId = 0;
      receiverId = 0;
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
            "Transfer",
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
                "Transfer Funds",
                style: TextStyle(
                  fontSize: 24,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20),
              _buildInputField(
                label: 'Sender ID',
                onChanged: (value) => senderId = int.tryParse(value) ?? 0,
                validator: (value) {
                  if (value == null || value.isEmpty || int.tryParse(value) == null) {
                    return 'Please enter a valid sender ID';
                  }
                  return null;
                },
                icon: Icons.person,
              ),
              SizedBox(height: 20),
              _buildInputField(
                label: 'Receiver ID',
                onChanged: (value) => receiverId = int.tryParse(value) ?? 0,
                validator: (value) {
                  if (value == null || value.isEmpty || int.tryParse(value) == null) {
                    return 'Please enter a valid receiver ID';
                  }
                  return null;
                },
                icon: Icons.person_add,
              ),
              SizedBox(height: 20),
              _buildInputField(
                label: 'Amount',
                onChanged: (value) => amount = double.tryParse(value) ?? 0,
                validator: (value) {
                  if (value == null || value.isEmpty || double.tryParse(value) == null || double.parse(value) <= 0) {
                    return 'Transfer amount must be greater than zero.';
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
                  onPressed: isLoading ? null : makeTransfer,
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
                    'Make Transfer',
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
  //       title: Text("Transfer"),
  //     ),
  //     body: Padding(
  //       padding: const EdgeInsets.all(8.0),
  //       child: Form(
  //         key: _formKey,
  //         child: Column(
  //           children: [
  //             TextFormField(
  //               decoration: InputDecoration(labelText: 'Sender ID'),
  //               keyboardType: TextInputType.number,
  //               onChanged: (value) => senderId = int.tryParse(value) ?? 0,
  //               validator: (value) {
  //                 if (value == null || value.isEmpty || int.tryParse(value) == null) {
  //                   return 'Please enter a valid sender ID';
  //                 }
  //                 return null;
  //               },
  //             ),
  //             TextFormField(
  //               decoration: InputDecoration(labelText: 'Receiver ID'),
  //               keyboardType: TextInputType.number,
  //               onChanged: (value) => receiverId = int.tryParse(value) ?? 0,
  //               validator: (value) {
  //                 if (value == null || value.isEmpty || int.tryParse(value) == null) {
  //                   return 'Please enter a valid receiver ID';
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
  //                   return 'Transfer amount must be greater than zero.';
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
  //               onPressed: isLoading ? null : makeTransfer,
  //               child: isLoading
  //                   ? CircularProgressIndicator(color: Colors.white)
  //                   : Text('Make Transfer'),
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
