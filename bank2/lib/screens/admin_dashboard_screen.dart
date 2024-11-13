import 'package:bank2/screens/bank_statement_screen.dart';
import 'package:bank2/screens/login_screen.dart';
import 'package:bank2/screens/transaction_list_screen.dart';
import 'package:flutter/material.dart';

class AdminDashboardScreen extends StatefulWidget {
  const AdminDashboardScreen({super.key});

  @override
  State<AdminDashboardScreen> createState() => _AdminDashboardScreenState();
}

class _AdminDashboardScreenState extends State<AdminDashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'BMSBank Admin Dashboard',
          style: TextStyle(color: Colors.white),
        ),
        automaticallyImplyLeading: false,
        backgroundColor: Color.fromARGB(255, 16, 80, 98),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildHeader(),
              SizedBox(height: 20),
              _buildDashboardOption(
                icon: Icons.people,
                label: 'View Users Accounts',
                color: Colors.blueAccent,
                onTap: () {
                  print("View Users clicked");
                },
              ),
              _buildDashboardOption(
                icon: Icons.attach_money,
                label: 'Manage Transactions',
                color: Colors.green,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => TransactionListScreen()),
                  );
                },
              ),
              _buildDashboardOption(
                icon: Icons.approval,
                label: 'Approve/Deny Account',
                color: Colors.orange,
                onTap: () {
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(builder: (context) => BankStatementScreen()),
                  // );
                },
              ),
              _buildDashboardOption(
                icon: Icons.settings,
                label: 'Settings',
                color: Colors.teal,
                onTap: () {
                  print("Settings clicked");
                },
              ),
              SizedBox(height: 20),
              _buildLogoutButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      children: [
        Center(
          child: CircleAvatar(
            radius: 40,
            backgroundImage: AssetImage(
              "assets/images/banklogo.png",
            ),
            // backgroundColor: Colors.grey,
          ),
        ),
        SizedBox(height: 16),
        Center(
          child: Text(
            'Welcome, Admin!',
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 16, 80, 98),
            ),
          ),
        ),
        Divider(height: 30, thickness: 1, color: Colors.grey[400]),
      ],
    );
  }

  Widget _buildDashboardOption({
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 4,
      margin: EdgeInsets.symmetric(vertical: 10),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: color.withOpacity(0.2),
          child: Icon(icon, color: color),
        ),
        title: Text(
          label,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        trailing: Icon(Icons.arrow_forward_ios, color: Colors.grey),
        onTap: onTap,
      ),
    );
  }

  Widget _buildLogoutButton() {
    return ElevatedButton(
      onPressed: () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => LoginScreen()),
        );
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.redAccent,
        padding: EdgeInsets.symmetric(vertical: 14),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
      child: Text(
        'Logout',
        style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }
}
