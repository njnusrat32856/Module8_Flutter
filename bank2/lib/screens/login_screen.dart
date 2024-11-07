import 'dart:convert';


import 'package:bank2/screens/admin_dashboard_screen.dart';
import 'package:bank2/screens/register_screen.dart';
import 'package:bank2/screens/user_dashboard_screen.dart';
import 'package:bank2/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginScreen extends StatelessWidget {

  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final storage = new FlutterSecureStorage();
  AuthService authService=AuthService();



  Future<void> loginUser(BuildContext context) async {

    final response = await authService.login(email.text, password.text);

    // Successful login, role-based navigation
    final  role =await authService.getUserRole(); // Get role from AuthService


    if (role == 'ADMIN') {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => AdminDashboardScreen()),
      );
    } else if (role == 'USER') {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => UserDashboardScreen()),
        // MaterialPageRoute(builder: (context) => UserDashboardScreen()),
      );
    } else {
      print('Unknown role: $role');
    }

  }




  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'BMS BanK Ltd.',
          style: TextStyle(
              color: Colors.white
          ),
        ),
        automaticallyImplyLeading: false, // Hides the back button
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/banklogo.png', width: 90, height: 90,),
            SizedBox(height: 20,),
            Form(
                child: Column(
                  children: [
                    TextField(
                      controller: email,
                      decoration: InputDecoration(
                          labelText: 'Email',
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.email)),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextField(
                      controller: password,
                      decoration: InputDecoration(
                          labelText: 'Password',
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.password)),
                      obscureText: true,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    ElevatedButton(
                        onPressed: () {
                          loginUser(context);

                        },
                        child: Text(
                          "Login",
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
                          MaterialPageRoute(builder: (context) => RegisterScreen()),
                        );
                      },
                      child: Text(
                        'Registration',
                        style: TextStyle(
                          color: Colors.blue,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    )
                  ],
                )
            )
          ],
        ),
      ),
    );
  }
}



