import 'package:expense_tracker/screens/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:expense_tracker/main.dart';
import 'package:expense_tracker/services/ApiService.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final ApiService _apiService = ApiService();

  final _formKey = GlobalKey<FormState>();
  bool _obscurePassword = true;
  String _name = '';
  String _email = '';
  String _password = '';
  String _currency = 'USD';

  final List<String> _currencies = ['USD', 'EUR', 'GBP', 'JPY', 'CAD'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.blue[600]),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: 24),
                Text(
                  'Create Account',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Poppins',
                    color: Colors.blue[800],
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 16),
                Text(
                  'Start tracking your expenses today!',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey[600],
                    fontFamily: 'Poppins',
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 48),
                _buildTextField(
                  label: 'Full Name',
                  prefixIcon: Icons.person,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your name';
                    }
                    return null;
                  },
                  onSaved: (value) => _name = value!,
                ),
                SizedBox(height: 16),
                _buildTextField(
                  label: 'Email',
                  prefixIcon: Icons.email,
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    }
                    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                        .hasMatch(value)) {
                      return 'Please enter a valid email';
                    }
                    return null;
                  },
                  onSaved: (value) => _email = value!,
                ),
                SizedBox(height: 16),
                _buildTextField(
                  label: 'Password',
                  prefixIcon: Icons.lock,
                  obscureText: _obscurePassword,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a password';
                    }
                    if (value.length < 6) {
                      return 'Password must be at least 6 characters long';
                    }
                    return null;
                  },
                  onSaved: (value) => _password = value!,
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscurePassword
                          ? Icons.visibility_off
                          : Icons.visibility,
                      color: Colors.grey[600],
                    ),
                    onPressed: () {
                      setState(() {
                        _obscurePassword = !_obscurePassword;
                      });
                    },
                  ),
                ),
                SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  value: _currency,
                  decoration: InputDecoration(
                    labelText: 'Preferred Currency',
                    prefixIcon:
                        Icon(Icons.attach_money, color: Colors.blue[600]),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: Colors.grey[300]!),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: Colors.grey[300]!),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide:
                          BorderSide(color: Colors.blue[600]!, width: 2),
                    ),
                    filled: true,
                    fillColor: Colors.grey[100],
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  ),
                  items: _currencies.map((String currency) {
                    return DropdownMenuItem<String>(
                      value: currency,
                      child: Text(currency),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      _currency = newValue!;
                    });
                  },
                ),
                SizedBox(height: 32),
                ElevatedButton(
                  onPressed: _submitForm,
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 16),
                    child: Text(
                      'Sign Up',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue[600],
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 3,
                  ),
                ),
                SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Already have an account? ',
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 14,
                        fontFamily: 'Poppins',
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text(
                        'Log in',
                        style: TextStyle(
                          color: Colors.blue[600],
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Poppins',
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    required IconData prefixIcon,
    TextInputType? keyboardType,
    bool obscureText = false,
    required String? Function(String?) validator,
    required void Function(String?) onSaved,
    Widget? suffixIcon,
  }) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(prefixIcon, color: Colors.blue[600]),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey[300]!),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.grey[300]!),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.blue[600]!, width: 2),
        ),
        filled: true,
        fillColor: Colors.grey[100],
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        suffixIcon: suffixIcon,
      ),
      keyboardType: keyboardType,
      obscureText: obscureText,
      validator: validator,
      onSaved: onSaved,
    );
  }

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      // Gather user data from the form fields
      Map<String, dynamic> userData = {
        'name': _name, // Assuming _name is the variable for username
        'email': _email, // Assuming _email is the variable for email
        'password':
            _password, // Assuming _password is the variable for password
        'currency':
            _currency, // Assuming _currency is the variable for currency
      };

      try {
        // Send the user data to your backend
        var response = await _apiService.registerUser(userData);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Submitted DATA: ${userData['name']}')),
        );

        // Check the response status
        if (response.statusCode == 201) {
          // Handle successful registration
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Account created successfully!')),
          );
          // Navigate to the home screen after successful sign-up
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => MainScreen()),
          );
        } else {
          // Handle error response from the server
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Registration failed: ${response.body}')),
          );
        }
      } catch (e) {
        // Handle any exceptions that occur during the HTTP request
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      }
    }
  }
}
