import 'package:bank2/screens/dashboard.dart';
import 'package:flutter/material.dart';

class UserDashboardScreen extends StatefulWidget {
  const UserDashboardScreen({super.key});

  @override
  State<UserDashboardScreen> createState() => _UserDashboardScreenState();
}

class _UserDashboardScreenState extends State<UserDashboardScreen> {

  int currentIndex = 0;

  final List<Widget> pages = [
    Dashboard(),
    // MyCardPage(),
    // ScanPage(),
    // ActivityPage(),
    // ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[currentIndex],
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            tabItem(Icons.home, "Dashboard", 0),
            tabItem(Icons.credit_card, "Loan Management", 1),
            // tabItem(Icons.credit_card, "", 2),
            FloatingActionButton(
              onPressed: () => onTabTapped(2),
              backgroundColor: Color.fromARGB(255, 16, 80, 98),
              child: Icon(
                Icons.qr_code_scanner,
                color: Colors.white,
              ),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30)
              ),
            ),
            tabItem(Icons.bar_chart, "Activity", 3),
            tabItem(Icons.person, "Profile", 4),
          ],
        ),
      ),
    );
  }

  Widget tabItem(IconData icon, String label, int index) {
    return IconButton(
      onPressed: () => onTabTapped(index),
      icon: Column(
        children: [
          Icon(
            icon,
            color: currentIndex == index ? Colors.black : Colors.grey,
          ),
          Text(
            label,
            style: TextStyle(
              fontSize: 10,
              color: currentIndex == index ? Theme.of(context).primaryColor : Colors.grey,
            ),
          )
        ],
      ),
    );
  }

  void onTabTapped (int index) {
    setState(() {
      currentIndex = index;
    });
  }
}
