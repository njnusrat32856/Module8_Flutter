import 'package:fintech_mobile_app/pages/activity_page.dart';
import 'package:fintech_mobile_app/pages/home.dart';
import 'package:fintech_mobile_app/pages/my_card_page.dart';
import 'package:fintech_mobile_app/pages/profile_page.dart';
import 'package:fintech_mobile_app/pages/scan_page.dart';
import 'package:fintech_mobile_app/widgets/action_buttons.dart';
import 'package:fintech_mobile_app/widgets/credit_card.dart';
import 'package:fintech_mobile_app/widgets/transaction_list.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fintech App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MainPage(),
    );
  }
}
class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {

  int currentIndex = 0;

  final List<Widget> pages = [
    Home(),
    MyCardPage(),
    ScanPage(),
    ActivityPage(),
    ProfilePage(),
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
            tabItem(Icons.home, "Home", 0),
            tabItem(Icons.credit_card, "My Cards", 1),
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


