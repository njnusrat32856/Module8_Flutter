import 'package:bank_flutter/services/admin_service.dart';
import 'package:flutter/material.dart';
// import 'package:bank_management_system/services/admin_service.dart';

class AdminDashboardScreen extends StatefulWidget {
  @override
  _AdminDashboardScreenState createState() => _AdminDashboardScreenState();
}

class _AdminDashboardScreenState extends State<AdminDashboardScreen> {
  final _adminService = AdminService();
  int newApplications = 0;
  int activeCustomers = 0;
  double totalTransactionAmount = 0.0;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchMetrics();
  }

  Future<void> _fetchMetrics() async {
    final metrics = await _adminService.getAggregateMetrics();
    setState(() {
      newApplications = metrics['newApplications'];
      activeCustomers = metrics['activeCustomers'];
      totalTransactionAmount = metrics['totalTransactionAmount'];
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Admin Dashboard')),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildMetricCard('New Applications', newApplications),
            _buildMetricCard('Active Customers', activeCustomers),
            _buildMetricCard('Total Transaction Amount', totalTransactionAmount),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/pendingApplications');
              },
              child: Text('View Pending Applications'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMetricCard(String title, dynamic value) {
    return Card(
      child: ListTile(
        title: Text(title),
        trailing: Text(value.toString()),
      ),
    );
  }
}
