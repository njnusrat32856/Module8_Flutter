import 'package:flutter/material.dart';
import 'package:test_flutter/page/loginpage.dart';

class Adminpage extends StatelessWidget {
  const Adminpage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin Dashboard'),
        automaticallyImplyLeading: false,
        backgroundColor: Colors.blueAccent,
      ),
      body: Padding(
          padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Welcome, Admin!',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.blueAccent,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20,),
            ElevatedButton.icon(
              icon: Icon(Icons.people),
                label: Text('View Users'),
                onPressed: () {
                  print("View Users Clicked");
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                ),
            ),
            SizedBox(height: 10,),
            ElevatedButton.icon(
                icon: Icon(Icons.hotel),
                label: Text('Manage Hotels'),
                onPressed: () {
                  print("Manage Hotels Clicked");
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                ),
            ),
            SizedBox(height: 10,),
            ElevatedButton.icon(
                icon: Icon(Icons.settings),
                onPressed: () {
                  print("Settings Cliced");
                },
              label: Text('Settings'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueGrey,
              ),
            ),
            SizedBox(height: 20,),
            ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => LoginPage()),
                  );
                },
                child: Text('Logout'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.redAccent,
              ),
            )
          ],
        ),
      ),
    );
  }
}
