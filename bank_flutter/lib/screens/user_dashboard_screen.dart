import 'package:floating_bottom_navigation_bar/floating_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';

class UserDashboardScreen extends StatefulWidget {
  const UserDashboardScreen({super.key});

  @override
  State<UserDashboardScreen> createState() => _UserDashboardScreenState();
}

class _UserDashboardScreenState extends State<UserDashboardScreen> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            'User Dashboard',
          style: TextStyle(
              color: Colors.white
          ),
        ),
        automaticallyImplyLeading: false, // Hides the back button
        backgroundColor: Colors.blue,
      ),
      //If you want to show body behind the navbar, it should be true
      extendBody: true,
      body: SingleChildScrollView( // This enables scrolling if content overflows
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Image.network(
              "https://t3.ftcdn.net/jpg/01/36/33/14/360_F_136331491_vRh0iHpvyi5juqXvbtujaibNIj6Xvyoh.jpg",
              fit: BoxFit.cover,
            ),
            SizedBox(height: 15,),
            Text(
              'Welcome to Bank!',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.blueAccent,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            tabItem(Icons.home, "Home", 0),
            tabItem(Icons.credit_card, "Transactions", 1),
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
