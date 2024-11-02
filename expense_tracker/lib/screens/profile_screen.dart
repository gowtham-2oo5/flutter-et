import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 24),
            const CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage("assets/dp.png"),
            ),
            const SizedBox(height: 16),
            const Text(
              'John Doe',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'john.doe@example.com',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 24),
            _buildProfileMenuItem(Icons.account_circle, 'Account Settings'),
            _buildProfileMenuItem(Icons.notifications, 'Notifications'),
            _buildProfileMenuItem(Icons.lock, 'Privacy & Security'),
            _buildProfileMenuItem(Icons.help, 'Help & Support'),
            _buildProfileMenuItem(Icons.exit_to_app, 'Logout'),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileMenuItem(IconData icon, String title) {
    return ListTile(
      leading: Icon(icon, color: Colors.blue[700]),
      title: Text(title),
      trailing: const Icon(Icons.chevron_right),
      onTap: () {
        // TODO: Implement navigation to respective screens
      },
    );
  }
}
