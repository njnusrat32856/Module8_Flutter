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
  AuthService authService = AuthService();

  Future<void> loginUser(BuildContext context) async {
    final response = await authService.login(email.text, password.text);

    // Successful login, role-based navigation
    final role = await authService.getUserRole(); // Get role from AuthService

    if (role == 'ADMIN') {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => AdminDashboardScreen()),
      );
    } else if (role == 'USER') {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => UserDashboardScreen()),
      );
    } else {
      print('Unknown role: $role');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            'BMS BanK Ltd.',
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              fontSize: 30
            ),
          ),
        ),
        automaticallyImplyLeading: false, // Hides the back button
        backgroundColor: Color.fromARGB(255, 16, 80, 98),
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
          padding: EdgeInsets.symmetric(horizontal: 32.0),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.white,
                    child: Image.asset('assets/images/banklogo.png', width: 70, height: 70),
                  ),
                  SizedBox(height: 30),
                  Form(
                    child: Column(
                      children: [
                        TextField(
                          controller: email,
                          decoration: InputDecoration(
                            labelText: 'Email',
                            labelStyle: TextStyle(color: Colors.white70),
                            filled: true,
                            fillColor: Colors.white.withOpacity(0.1),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide.none,
                            ),
                            prefixIcon: Icon(Icons.email, color: Colors.white70),
                          ),
                          style: TextStyle(color: Colors.white),
                        ),
                        SizedBox(height: 20),
                        TextField(
                          controller: password,
                          decoration: InputDecoration(
                            labelText: 'Password',
                            labelStyle: TextStyle(color: Colors.white70),
                            filled: true,
                            fillColor: Colors.white.withOpacity(0.1),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide.none,
                            ),
                            prefixIcon: Icon(Icons.lock, color: Colors.white70),
                          ),
                          obscureText: true,
                          style: TextStyle(color: Colors.white),
                        ),
                        SizedBox(height: 30),
                        ElevatedButton(
                          onPressed: () {
                            loginUser(context);
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 40.0),
                            child: Text(
                              "Login",
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
                              MaterialPageRoute(builder: (context) => RegisterScreen()),
                            );
                          },
                          child: Text(
                            'Don\'t have account? Open a new account',
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
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}




// import 'package:bank2/screens/admin_dashboard_screen.dart';
// import 'package:bank2/screens/register_screen.dart';
// import 'package:bank2/screens/user_dashboard_screen.dart';
// import 'package:bank2/services/auth_service.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
// import 'package:google_fonts/google_fonts.dart';
//
// class LoginScreen extends StatelessWidget {
//   final TextEditingController email = TextEditingController();
//   final TextEditingController password = TextEditingController();
//   final storage = new FlutterSecureStorage();
//   AuthService authService = AuthService();
//
//   Future<void> loginUser(BuildContext context) async {
//     final response = await authService.login(email.text, password.text);
//
//     // Successful login, role-based navigation
//     final role = await authService.getUserRole(); // Get role from AuthService
//
//     if (role == 'ADMIN') {
//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(builder: (context) => AdminDashboardScreen()),
//       );
//     } else if (role == 'USER') {
//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(builder: (context) => UserDashboardScreen()),
//         // MaterialPageRoute(builder: (context) => UserDashboardScreen()),
//       );
//     } else {
//       print('Unknown role: $role');
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text(
//           'BMS BanK Ltd.',
//           style: TextStyle(color: Colors.white),
//         ),
//         automaticallyImplyLeading: false, // Hides the back button
//         backgroundColor: Color.fromARGB(255, 16, 80, 98),
//       ),
//       body: Padding(
//         padding: EdgeInsets.all(16.0),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Image.asset(
//               'assets/images/banklogo.png',
//               width: 90,
//               height: 90,
//             ),
//             SizedBox(
//               height: 20,
//             ),
//             Form(
//                 child: Column(
//               children: [
//                 TextField(
//                   controller: email,
//                   decoration: InputDecoration(
//                       labelText: 'Email',
//                       border: OutlineInputBorder(),
//                       prefixIcon: Icon(Icons.email)),
//                 ),
//                 SizedBox(
//                   height: 20,
//                 ),
//                 TextField(
//                   controller: password,
//                   decoration: InputDecoration(
//                       labelText: 'Password',
//                       border: OutlineInputBorder(),
//                       prefixIcon: Icon(Icons.password)),
//                   obscureText: true,
//                 ),
//                 SizedBox(
//                   height: 20,
//                 ),
//                 ElevatedButton(
//                     onPressed: () {
//                       loginUser(context);
//                     },
//                     child: Text(
//                       "Login",
//                       style: TextStyle(
//                           fontWeight: FontWeight.w600,
//                           fontFamily: GoogleFonts.lato().fontFamily),
//                     ),
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: Color.fromARGB(255, 16, 80, 98),
//                       foregroundColor: Colors.white,
//                     )),
//                 SizedBox(height: 20),
//
//                 // Login Text Button
//                 TextButton(
//                   onPressed: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(builder: (context) => RegisterScreen()),
//                     );
//                   },
//                   child: Text(
//                     'Registration',
//                     style: TextStyle(
//                       color: Colors.blue,
//                       decoration: TextDecoration.underline,
//                     ),
//                   ),
//                 )
//               ],
//             ))
//           ],
//         ),
//       ),
//     );
//   }
// }
