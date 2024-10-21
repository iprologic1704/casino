import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

import 'DashboardScreen.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false; // To show a loading indicator during API call

  @override
  void dispose() {
    _phoneController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  // Function to handle the login API call
  Future<void> _login() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true; // Show loading indicator
      });

      String url = 'https://casino-crm.blocmatrix.com/api/login';
      Map<String, String> headers = {"Content-Type": "application/json"};
      Map<String, String> body = {
        "email": _phoneController.text,
        "password": _passwordController.text,
      };

      try {
        http.Response response = await http.post(
          Uri.parse(url),
          headers: headers,
          body: jsonEncode(body),
        );

        if (response.statusCode == 200) {
          // Parse the response data
          var data = jsonDecode(response.body);

          // Check if login was successful
          if (data['success']) {
            var account = data['data']['account'];

            // Save the relevant details to SharedPreferences
            SharedPreferences prefs = await SharedPreferences.getInstance();
            await prefs.setString('_id', account['_id']);
            await prefs.setString('clientId', account['clientId']);
            await prefs.setString('firstName', account['firstName']);
            await prefs.setString('lastName', account['lastName']);
            await prefs.setString('username', account['username']);
            await prefs.setString('email', account['email']);
            await prefs.setString('companyName', account['companyName']);
            await prefs.setString('status', account['status']);
            await prefs.setString('roleType', data['data']['roleType']);
            await prefs.setString('token', data['token']); // Save token as well

            print('Login successful: $data');

            // Navigate to the DashboardScreen
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => DashboardScreen()),
            );
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Login failed: ${data['message']}')),
            );
          }
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Login failed: ${response.body}')),
          );
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('An error occurred: $e')),
        );
      } finally {
        setState(() {
          _isLoading = false; // Hide loading indicator
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      backgroundColor: Color(0xFF212B36), // Set background color
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              // Heading "Login"
              Text(
                'Login',
                style: TextStyle(
                  fontSize: 32, // Set font size for the heading
                  fontWeight: FontWeight.bold, // Make the heading bold
                  color: Colors.white, // Set text color to white
                ),
              ),
              SizedBox(height: 40), // Add space below the heading
              TextFormField(
                controller: _phoneController,
                style: TextStyle(color: Colors.white), // Set input text color to white
                decoration: InputDecoration(
                  labelText: 'User Name',
                  labelStyle: TextStyle(color: Colors.white), // Set label text color to white
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your phone number';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: _passwordController,
                style: TextStyle(color: Colors.white), // Set input text color to white
                decoration: InputDecoration(
                  labelText: 'Password',
                  labelStyle: TextStyle(color: Colors.white), // Set label text color to white
                  border: OutlineInputBorder(),
                ),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your password';
                  }
                  return null;
                },
              ),
              SizedBox(height: 30),
              _isLoading
                  ? CircularProgressIndicator() // Show loading indicator
                  : ElevatedButton(
                onPressed: _login,
                child: Text('Login'),
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(double.infinity, 50), // Full-width button
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
