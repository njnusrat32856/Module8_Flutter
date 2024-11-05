import 'dart:convert';

import 'package:bank_flutter/screens/login_screen.dart';
import 'package:bank_flutter/services/auth_service.dart';
import 'package:date_field/date_field.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

class RegisterScreen extends StatefulWidget {

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {

  final TextEditingController firstName = TextEditingController();
  final TextEditingController lastName = TextEditingController();

  final TextEditingController email = TextEditingController();

  final TextEditingController password = TextEditingController();

  final TextEditingController mobileNo = TextEditingController();

  final TextEditingController address = TextEditingController();
  final TextEditingController nid = TextEditingController();
  final TextEditingController accountType = TextEditingController();

  final DateTimeFieldPickerPlatform dob= DateTimeFieldPickerPlatform.material;

  // final TextEditingController gender = TextEditingController();

  String? selectedGender;

  DateTime? selectedDOB;

  final _formKey = GlobalKey<FormState>();

  // Method to validate form and check passwords
  void _register() async {

    if (_formKey.currentState!.validate()) {
      String uFirstName = firstName.text;
      String uLastName = lastName.text;
      String uEmail = email.text;
      String uPassword = password.text;
      String uMobileNo = mobileNo.text;
      String uAddress = address.text;
      String uNid = nid.text;
      String uGender = selectedGender ?? 'Other';
      String uDob = selectedDOB != null ? selectedDOB!.toIso8601String() : '';
      String uAccountType = accountType.text;

      // Send data to the server
      final response = await _sendDataToBackend(uFirstName, uLastName, uEmail, uPassword, uMobileNo, uAddress, uNid, uGender, uDob, uAccountType);

      if (response.statusCode == 201 || response.statusCode == 200  ) {
        // Registration successful
        print('Registration successful!');
      } else if (response.statusCode == 409) {
        // User already exists
        print('User already exists!');
      } else {
        print('Registration failed with status: ${response.statusCode}');
      }
    }
  }

  // HTTP POST Request to send data to backend
  Future<http.Response> _sendDataToBackend(
      String firstName,
      String lastName,
      String email,
      String password,
      String mobileNo,
      String address,
      String nid,
      String gender,
      String dob,
      String accountType
      ) async {

    const String url = 'http://localhost:8881/register'; // Android emulator
    final response = await http.post(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'firstName': firstName,
        'lastName': lastName,
        'email': email,
        'password': password,
        'mobileNo': mobileNo,
        'address': address,
        'nid': nid,
        'gender': gender,
        'dob': dob,
        'accountType': accountType
      }),
    );
    return response;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextField(
                  controller: firstName,
                  decoration: InputDecoration(
                      labelText: 'First Name',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.person)),
                ),
                SizedBox(
                  height: 20,
                ),TextField(
                  controller: lastName,
                  decoration: InputDecoration(
                      labelText: 'Last Name',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.person)),
                ),
                SizedBox(
                  height: 20,
                ),
                TextField(
                  controller: email,
                  decoration: InputDecoration(
                      labelText: 'Email ',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.email)),
                ),
                SizedBox(
                  height: 20,
                ),
                TextField(
                  controller: password,
                  decoration: InputDecoration(
                      labelText: 'Password ',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.lock)
                  ),
                  obscureText: true,
                ),
                SizedBox(
                  height: 20,
                ),
                TextField(
                  controller: mobileNo,
                  decoration: InputDecoration(
                      labelText: 'Mobile Number',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.phone)),
                ),
                SizedBox(
                  height: 20,
                ),
                TextField(
                  controller: address,
                  decoration: InputDecoration(
                      labelText: 'Address',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.maps_home_work_rounded)),
                ),
                SizedBox(
                  height: 20,
                ),
                TextField(
                  controller: nid,
                  decoration: InputDecoration(
                      labelText: 'National ID',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.numbers)),
                ),
                SizedBox(
                  height: 20,
                ),
                DateTimeFormField(
                  decoration: const InputDecoration(labelText: 'Date of Birth'),
                  mode: DateTimeFieldPickerMode.date,
                  pickerPlatform: dob,
                  onChanged: (DateTime? value) {
                    setState(() {
                      selectedDOB = value;
                    });
                  },
                ),

                SizedBox(
                  height: 20,
                ),

                Row(
                  children: [
                    Text('Gender:'),
                    Expanded(
                      child: Row(
                        children: [
                          Radio<String>(
                            value: 'Male',
                            groupValue: selectedGender,
                            onChanged: (String? value) {
                              setState(() {
                                selectedGender = value;
                              });
                            },
                          ),
                          Text('Male'),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Row(
                        children: [
                          Radio<String>(
                            value: 'Female',
                            groupValue: selectedGender,
                            onChanged: (String? value) {
                              setState(() {
                                selectedGender = value;
                              });
                            },
                          ),
                          Text('Female'),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Row(
                        children: [
                          Radio<String>(
                            value: 'Other',
                            groupValue: selectedGender,
                            onChanged: (String? value) {
                              setState((){
                                selectedGender = value;
                              });
                            },
                          ),
                          Text('Other'),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                TextField(
                  controller: accountType,
                  decoration: InputDecoration(
                      labelText: 'Account Type',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.numbers)),
                ),
                SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                    onPressed: () {
                      _register();
                    },
                    child: Text(
                      "Registration",
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontFamily:GoogleFonts.lato().fontFamily
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueAccent,
                      foregroundColor: Colors.white,
                    )
                ),

                SizedBox(height: 20),

                // Login Text Button
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LoginScreen()),
                    );
                  },
                  child: Text(
                    'Login',
                    style: TextStyle(
                      color: Colors.blue,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                )




              ],
            ),
          ),
        ),
      ),
    );
  }
}

// class RegisterScreen extends StatefulWidget {
//   @override
//   _RegisterScreenState createState() => _RegisterScreenState();
// }
//
// class _RegisterScreenState extends State<RegisterScreen> {
//   final _authService = AuthService();
//   final _formKey = GlobalKey<FormState>();
//   final TextEditingController _emailController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();
//   final TextEditingController _firstNameController = TextEditingController();
//   final TextEditingController _lastNameController = TextEditingController();
//   final TextEditingController _accountTypeController = TextEditingController();
//   final TextEditingController _balanceController = TextEditingController();
//
//   bool _isLoading = false;
//   String _errorMessage = '';
//
//   Future<void> _register() async {
//     if (_formKey.currentState!.validate()) {
//       setState(() {
//         _isLoading = true;
//         _errorMessage = '';
//       });
//
//       bool isRegistered = await _authService.register(
//         _emailController.text.trim(),
//         _passwordController.text.trim(),
//         _firstNameController.text.trim(),
//         _lastNameController.text.trim(),
//         _accountTypeController.text.trim(),
//         double.tryParse(_balanceController.text.trim()) ?? 0.0,
//       );
//
//       setState(() {
//         _isLoading = false;
//       });
//
//       if (isRegistered) {
//         // Navigate to login or dashboard screen after successful registration
//         Navigator.pushReplacementNamed(context, '/login');
//       } else {
//         setState(() {
//           _errorMessage = 'Registration failed. Please try again.';
//         });
//       }
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Register')),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Form(
//           key: _formKey,
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               TextFormField(
//                 controller: _firstNameController,
//                 decoration: InputDecoration(labelText: 'First Name'),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter your first name';
//                   }
//                   return null;
//                 },
//               ),
//               TextFormField(
//                 controller: _lastNameController,
//                 decoration: InputDecoration(labelText: 'Last Name'),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter your last name';
//                   }
//                   return null;
//                 },
//               ),
//               TextFormField(
//                 controller: _emailController,
//                 decoration: InputDecoration(labelText: 'Email'),
//                 keyboardType: TextInputType.emailAddress,
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter your email';
//                   }
//                   return null;
//                 },
//               ),
//               TextFormField(
//                 controller: _passwordController,
//                 decoration: InputDecoration(labelText: 'Password'),
//                 obscureText: true,
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter your password';
//                   }
//                   return null;
//                 },
//               ),
//               TextFormField(
//                 controller: _accountTypeController,
//                 decoration: InputDecoration(labelText: 'Account Type'),
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter your account type';
//                   }
//                   return null;
//                 },
//               ),
//               TextFormField(
//                 controller: _balanceController,
//                 decoration: InputDecoration(labelText: 'Initial Balance'),
//                 keyboardType: TextInputType.number,
//                 validator: (value) {
//                   if (value == null || value.isEmpty) {
//                     return 'Please enter your initial balance';
//                   }
//                   return null;
//                 },
//               ),
//               SizedBox(height: 16),
//               if (_errorMessage.isNotEmpty)
//                 Text(
//                   _errorMessage,
//                   style: TextStyle(color: Colors.red),
//                 ),
//               SizedBox(height: 16),
//               _isLoading
//                   ? CircularProgressIndicator()
//                   : ElevatedButton(
//                 onPressed: _register,
//                 child: Text('Register'),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
