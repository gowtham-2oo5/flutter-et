import 'package:expense_tracker/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:expense_tracker/notifiers/expense_notifier.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:expense_tracker/services/ApiService.dart';
import 'package:expense_tracker/models/user_model.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  User? user;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadUserProfile();
  }

  Future<void> _loadUserProfile() async {
    setState(() {
      isLoading = true;
    });

    try {
      final prefs = await SharedPreferences.getInstance();
      String? userId = prefs.getString('userId');

      if (userId != null) {
        final apiService = ApiService();
        final userProfile = await apiService.getUserProfile(userId);
        setState(() {
          user = userProfile;
          isLoading = false;
        });
      } else {
        throw Exception('User ID not found');
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      _showErrorDialog('Failed to load user profile: ${e.toString()}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : Consumer<ExpenseNotifier>(
              builder: (context, expenseNotifier, child) {
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(height: 24),
                      const CircleAvatar(
                        radius: 50,
                        backgroundImage: AssetImage("assets/dp.png"),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        user?.name ?? 'User',
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        user?.email ?? 'user@example.com',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey[600],
                        ),
                      ),
                      const SizedBox(height: 24),
                      _buildProfileMenuItem(context,
                          Icons.account_balance_wallet, 'Total Expenses', () {
                        _showTotalExpenses(context, expenseNotifier);
                      }),
                      _buildProfileMenuItem(context, Icons.settings, 'Settings',
                          () {
                        _showComingSoonDialog(context, 'Settings');
                      }),
                      _buildProfileMenuItem(
                          context, Icons.notifications, 'Notifications', () {
                        _showComingSoonDialog(context, 'Notifications');
                      }),
                      _buildProfileMenuItem(
                          context, Icons.help, 'Help & Support', () {
                        _showComingSoonDialog(context, 'Help & Support');
                      }),
                      _buildProfileMenuItem(
                          context, Icons.exit_to_app, 'Logout', () {
                        _showLogoutDialog(context);
                      }),
                    ],
                  ),
                );
              },
            ),
    );
  }

  Widget _buildProfileMenuItem(
      BuildContext context, IconData icon, String title, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon, color: Theme.of(context).primaryColor),
      title: Text(title),
      trailing: const Icon(Icons.chevron_right),
      onTap: onTap,
    );
  }

  void _showTotalExpenses(
      BuildContext context, ExpenseNotifier expenseNotifier) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Total Expenses'),
          content: Text(
              'Your total expenses: \$${expenseNotifier.totalExpenses.toStringAsFixed(2)}'),
          actions: <Widget>[
            TextButton(
              child: const Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _showComingSoonDialog(BuildContext context, String feature) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Coming Soon'),
          content: Text('The $feature feature is coming soon!'),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Logout'),
          content: const Text('Are you sure you want to logout?'),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Logout'),
              onPressed: () async {
                // Clear user data
                final prefs = await SharedPreferences.getInstance();
                await prefs.clear();

                // Navigate to login screen (replace with your actual login screen route)
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => const LoginPage()),
                );
              },
            ),
          ],
        );
      },
    );
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Error'),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
