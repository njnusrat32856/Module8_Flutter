import 'package:bank_flutter/models/user.dart';
import 'package:flutter/material.dart';
// import 'user.dart'; // Ensure you import your User model

class UserProfile extends StatelessWidget {
  final User? user;
  final String? errorMessage;

  const UserProfile({
    Key? key,
    required this.user,
    this.errorMessage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return user != null
        ? SingleChildScrollView(
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Text(
              'Profile',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(height: 16.0),

          // Profile Image (if available)
          if (user!.image != null)
            Center(
              child: CircleAvatar(
                radius: 60,
                backgroundImage: NetworkImage(user!.image!),
              ),
            ),
          SizedBox(height: 16.0),

          // Profile Details
          _buildProfileItem('Account Number:', user!.accountNumber),
          _buildProfileItem('Full Name:', '${user!.firstName} ${user!.lastName}'),
          _buildProfileItem('Email:', user!.email),
          _buildProfileItem('Gender:', user!.gender),
          _buildProfileItem('Address:', user!.address),
          _buildProfileItem('Mobile No:', user!.mobileNo),
          _buildProfileItem('NID:', user!.nid),
          _buildProfileItem('Date of Birth:', user!.dob),
          _buildProfileItem('Account Type:', user!.accountType),
          _buildProfileItem('Account Balance:', '\$${user!.balance.toStringAsFixed(2)}'),
          // _buildProfileItem('Account Status:', user!.status ? 'Active' : 'Inactive'),

          // Error message (if available)
          if (errorMessage != null)
            Padding(
              padding: EdgeInsets.only(top: 16.0),
              child: Text(
                errorMessage!,
                style: TextStyle(color: Colors.red),
              ),
            ),
        ],
      ),
    )
        : Center(
      child: Text(
        'User profile not available',
        style: TextStyle(fontSize: 18.0, color: Colors.red),
      ),
    );
  }

  // Widget to build individual profile items
  Widget _buildProfileItem(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          SizedBox(width: 8.0),
          Expanded(
            child: Text(value),
          ),
        ],
      ),
    );
  }
}
