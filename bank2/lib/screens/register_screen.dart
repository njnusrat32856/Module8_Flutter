import 'dart:convert';

import 'package:bank2/screens/login_screen.dart';
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

  // final TextEditingController accountType = TextEditingController();
  final DateTimeFieldPickerPlatform dob = DateTimeFieldPickerPlatform.material;

  String? selectedGender;
  String? selectedAccountType;
  DateTime? selectedDOB;
  final _formKey = GlobalKey<FormState>();

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
      // String uAccountType = accountType.text;
      String uAccountType = selectedAccountType ?? 'Savings';

      final response = await _sendDataToBackend(uFirstName, uLastName, uEmail,
          uPassword, uMobileNo, uAddress, uNid, uGender, uDob, uAccountType);

      if (response.statusCode == 201 || response.statusCode == 200) {
        print('Registration successful!');
      } else if (response.statusCode == 409) {
        print('User already exists!');
      } else {
        print('Registration failed with status: ${response.statusCode}');
      }
    }
  }

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
      String accountType) async {
    const String url = 'http://localhost:8881/register';
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
      appBar: AppBar(
        title: Text(
          'BMS BanK Ltd.',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 30,
          ),
        ),
        backgroundColor: Color.fromARGB(255, 16, 80, 98),
        centerTitle: true,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 16, 80, 98),
              Color.fromARGB(255, 32, 160, 180),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  // Image.file(file),
                  CircleAvatar(
                    radius: 40,
                    backgroundColor: Colors.white,
                    child: Icon(
                      Icons.person_add,
                      color: Color.fromARGB(255, 16, 80, 98),
                      size: 50,
                    ),
                  ),
                  SizedBox(height: 20),
                  _buildTextField('First Name', firstName, Icons.person),
                  SizedBox(height: 20),
                  _buildTextField('Last Name', lastName, Icons.person),
                  SizedBox(height: 20),
                  _buildTextField('Email', email, Icons.email),
                  SizedBox(height: 20),
                  _buildPasswordField('Password', password, Icons.password),
                  SizedBox(height: 20),
                  _buildTextField('Mobile Number', mobileNo, Icons.phone),
                  SizedBox(height: 20),
                  _buildTextField(
                      'Address', address, Icons.maps_home_work_rounded),
                  SizedBox(height: 20),
                  _buildTextField('National ID', nid, Icons.privacy_tip),
                  SizedBox(height: 20),
                  DateTimeFormField(
                    decoration: InputDecoration(
                      labelText: 'Date of Birth',
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.1),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      ),
                      labelStyle: TextStyle(color: Colors.white70),
                      prefixIcon:
                          Icon(Icons.calendar_today, color: Colors.white70),
                    ),
                    style: TextStyle(color: Colors.white),
                    mode: DateTimeFieldPickerMode.date,
                    pickerPlatform: dob,
                    onChanged: (DateTime? value) {
                      setState(() {
                        selectedDOB = value;
                      });
                    },
                  ),
                  SizedBox(height: 20),
                  _buildGenderSelection(),
                  SizedBox(
                    height: 20,
                  ),
                  DropdownButtonFormField<String>(
                    value: selectedAccountType,
                    decoration: InputDecoration(
                      labelText: 'Account Type',
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.1),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none,
                      ),
                      labelStyle: TextStyle(color: Colors.white70),
                      prefixIcon:
                          Icon(Icons.account_balance, color: Colors.white70),
                    ),
                    style: TextStyle(color: Colors.white),
                    items:
                        ['Savings Account', 'Current Account', 'Fixed Deposit']
                            .map((type) => DropdownMenuItem(
                                  value: type,
                                  child: Text(
                                    type,
                                    style: TextStyle(color: Colors.black,),
                                    // style: TextStyle(color: Colors.white, backgroundColor: Colors.teal[900]),
                                  ),
                                ))
                            .toList(),
                    onChanged: (String? value) {
                      setState(() {
                        selectedAccountType = value;
                      });
                    },
                  ),
                  // _buildTextField('Account Type', accountType, Icons.account_balance),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _register,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 12.0, horizontal: 40.0),
                      child: Text(
                        "Register",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          fontFamily: GoogleFonts.lato().fontFamily,
                        ),
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Color.fromARGB(255, 16, 80, 98),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Divider(
                    endIndent: 8,
                    indent: 8,
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => LoginScreen()),
                      );
                    },
                    child: Text(
                      'Back to Login',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        decoration: TextDecoration.none,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(
      String label, TextEditingController controller, IconData icon) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        filled: true,
        fillColor: Colors.white.withOpacity(0.1),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
        labelStyle: TextStyle(color: Colors.white70),
        prefixIcon: Icon(icon, color: Colors.white70),
      ),
      style: TextStyle(color: Colors.white),
    );
  }

  Widget _buildPasswordField(
      String label, TextEditingController controller, IconData icon) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        filled: true,
        fillColor: Colors.white.withOpacity(0.1),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
        labelStyle: TextStyle(color: Colors.white70),
        prefixIcon: Icon(icon, color: Colors.white70),
      ),
      style: TextStyle(color: Colors.white),
    );
  }

  Widget _buildGenderSelection() {
    return Row(
      children: [
        Text('Gender:', style: TextStyle(color: Colors.white70)),
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
                activeColor: Colors.white,
              ),
              Text('Male', style: TextStyle(color: Colors.white70)),
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
                activeColor: Colors.white,
              ),
              Text('Female', style: TextStyle(color: Colors.white70)),
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
                  setState(() {
                    selectedGender = value;
                  });
                },
                activeColor: Colors.white,
              ),
              Text('Other', style: TextStyle(color: Colors.white70)),
            ],
          ),
        ),
      ],
    );
  }
}

// import 'dart:convert';
//
// import 'package:bank2/screens/login_screen.dart';
//
// import 'package:date_field/date_field.dart';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:http/http.dart' as http;
//
// class RegisterScreen extends StatefulWidget {
//
//   @override
//   State<RegisterScreen> createState() => _RegisterScreenState();
// }
//
// class _RegisterScreenState extends State<RegisterScreen> {
//
//   final TextEditingController firstName = TextEditingController();
//   final TextEditingController lastName = TextEditingController();
//
//   final TextEditingController email = TextEditingController();
//
//   final TextEditingController password = TextEditingController();
//
//   final TextEditingController mobileNo = TextEditingController();
//
//   final TextEditingController address = TextEditingController();
//   final TextEditingController nid = TextEditingController();
//   final TextEditingController accountType = TextEditingController();
//
//   final DateTimeFieldPickerPlatform dob= DateTimeFieldPickerPlatform.material;
//
//   // final TextEditingController gender = TextEditingController();
//
//   String? selectedGender;
//
//   DateTime? selectedDOB;
//
//   final _formKey = GlobalKey<FormState>();
//
//   // Method to validate form and check passwords
//   void _register() async {
//
//     if (_formKey.currentState!.validate()) {
//       String uFirstName = firstName.text;
//       String uLastName = lastName.text;
//       String uEmail = email.text;
//       String uPassword = password.text;
//       String uMobileNo = mobileNo.text;
//       String uAddress = address.text;
//       String uNid = nid.text;
//       String uGender = selectedGender ?? 'Other';
//       String uDob = selectedDOB != null ? selectedDOB!.toIso8601String() : '';
//       String uAccountType = accountType.text;
//
//       // Send data to the server
//       final response = await _sendDataToBackend(uFirstName, uLastName, uEmail, uPassword, uMobileNo, uAddress, uNid, uGender, uDob, uAccountType);
//
//       if (response.statusCode == 201 || response.statusCode == 200  ) {
//         // Registration successful
//         print('Registration successful!');
//       } else if (response.statusCode == 409) {
//         // User already exists
//         print('User already exists!');
//       } else {
//         print('Registration failed with status: ${response.statusCode}');
//       }
//     }
//   }
//
//   // HTTP POST Request to send data to backend
//   Future<http.Response> _sendDataToBackend(
//       String firstName,
//       String lastName,
//       String email,
//       String password,
//       String mobileNo,
//       String address,
//       String nid,
//       String gender,
//       String dob,
//       String accountType
//       ) async {
//
//     const String url = 'http://localhost:8881/register'; // Android emulator
//     final response = await http.post(
//       Uri.parse(url),
//       headers: {'Content-Type': 'application/json'},
//       body: jsonEncode({
//         'firstName': firstName,
//         'lastName': lastName,
//         'email': email,
//         'password': password,
//         'mobileNo': mobileNo,
//         'address': address,
//         'nid': nid,
//         'gender': gender,
//         'dob': dob,
//         'accountType': accountType
//       }),
//     );
//     return response;
//   }
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Center(
//           child: Text(
//             'BMS BanK Ltd.',
//             style: TextStyle(
//                 color: Colors.white,
//                 fontWeight: FontWeight.bold,
//                 fontSize: 30
//             ),
//           ),
//         ),
//         automaticallyImplyLeading: false, // Hides the back button
//         backgroundColor: Color.fromARGB(255, 16, 80, 98),
//       ),
//       body: Padding(
//         padding: EdgeInsets.all(16),
//         child: SingleChildScrollView(
//           child: Form(
//             key: _formKey,
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 TextField(
//                   controller: firstName,
//                   decoration: InputDecoration(
//                       labelText: 'First Name',
//                       border: OutlineInputBorder(),
//                       prefixIcon: Icon(Icons.person)),
//                 ),
//                 SizedBox(
//                   height: 20,
//                 ),TextField(
//                   controller: lastName,
//                   decoration: InputDecoration(
//                       labelText: 'Last Name',
//                       border: OutlineInputBorder(),
//                       prefixIcon: Icon(Icons.person)),
//                 ),
//                 SizedBox(
//                   height: 20,
//                 ),
//                 TextField(
//                   controller: email,
//                   decoration: InputDecoration(
//                       labelText: 'Email ',
//                       border: OutlineInputBorder(),
//                       prefixIcon: Icon(Icons.email)),
//                 ),
//                 SizedBox(
//                   height: 20,
//                 ),
//                 TextField(
//                   controller: password,
//                   decoration: InputDecoration(
//                       labelText: 'Password ',
//                       border: OutlineInputBorder(),
//                       prefixIcon: Icon(Icons.lock)
//                   ),
//                   obscureText: true,
//                 ),
//                 SizedBox(
//                   height: 20,
//                 ),
//                 TextField(
//                   controller: mobileNo,
//                   decoration: InputDecoration(
//                       labelText: 'Mobile Number',
//                       border: OutlineInputBorder(),
//                       prefixIcon: Icon(Icons.phone)),
//                 ),
//                 SizedBox(
//                   height: 20,
//                 ),
//                 TextField(
//                   controller: address,
//                   decoration: InputDecoration(
//                       labelText: 'Address',
//                       border: OutlineInputBorder(),
//                       prefixIcon: Icon(Icons.maps_home_work_rounded)),
//                 ),
//                 SizedBox(
//                   height: 20,
//                 ),
//                 TextField(
//                   controller: nid,
//                   decoration: InputDecoration(
//                       labelText: 'National ID',
//                       border: OutlineInputBorder(),
//                       prefixIcon: Icon(Icons.numbers)),
//                 ),
//                 SizedBox(
//                   height: 20,
//                 ),
//                 DateTimeFormField(
//                   decoration: const InputDecoration(labelText: 'Date of Birth'),
//                   mode: DateTimeFieldPickerMode.date,
//                   pickerPlatform: dob,
//                   onChanged: (DateTime? value) {
//                     setState(() {
//                       selectedDOB = value;
//                     });
//                   },
//                 ),
//
//                 SizedBox(
//                   height: 20,
//                 ),
//
//                 Row(
//                   children: [
//                     Text('Gender:'),
//                     Expanded(
//                       child: Row(
//                         children: [
//                           Radio<String>(
//                             value: 'Male',
//                             groupValue: selectedGender,
//                             onChanged: (String? value) {
//                               setState(() {
//                                 selectedGender = value;
//                               });
//                             },
//                           ),
//                           Text('Male'),
//                         ],
//                       ),
//                     ),
//                     Expanded(
//                       child: Row(
//                         children: [
//                           Radio<String>(
//                             value: 'Female',
//                             groupValue: selectedGender,
//                             onChanged: (String? value) {
//                               setState(() {
//                                 selectedGender = value;
//                               });
//                             },
//                           ),
//                           Text('Female'),
//                         ],
//                       ),
//                     ),
//                     Expanded(
//                       child: Row(
//                         children: [
//                           Radio<String>(
//                             value: 'Other',
//                             groupValue: selectedGender,
//                             onChanged: (String? value) {
//                               setState((){
//                                 selectedGender = value;
//                               });
//                             },
//                           ),
//                           Text('Other'),
//                         ],
//                       ),
//                     ),
//                   ],
//                 ),
//                 SizedBox(
//                   height: 20,
//                 ),
//                 DropdownMenuEntry(value: 'Savings Account', label: "Accounts Type"),
//                 // TextField(
//                 //   controller: accountType,
//                 //   decoration: InputDecoration(
//                 //       labelText: 'Account Type',
//                 //       border: OutlineInputBorder(),
//                 //       prefixIcon: Icon(Icons.numbers)),
//                 // ),
//                 SizedBox(
//                   height: 20,
//                 ),
//                 ElevatedButton(
//                     onPressed: () {
//                       Navigator.push(
//                         context,
//                         MaterialPageRoute(builder: (context) => LoginScreen()),
//                       );
//                     },
//                     child: Text(
//                       "Registration",
//                       style: TextStyle(
//                           fontWeight: FontWeight.w600,
//                           fontFamily:GoogleFonts.lato().fontFamily
//                       ),
//                     ),
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Colors.blueAccent,
//                       foregroundColor: Colors.white,
//                     )
//                 ),
//
//                 SizedBox(height: 20),
//
//                 // Login Text Button
//                 TextButton(
//                   onPressed: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(builder: (context) => LoginScreen()),
//                     );
//                   },
//                   child: Text(
//                     'Login',
//                     style: TextStyle(
//                       color: Colors.blue,
//                       decoration: TextDecoration.underline,
//                     ),
//                   ),
//                 )
//
//
//
//
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

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
