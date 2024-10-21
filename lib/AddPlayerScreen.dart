import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AddPlayerScreen extends StatefulWidget {
  @override
  _AddPlayerScreenState createState() => _AddPlayerScreenState();
}

class _AddPlayerScreenState extends State<AddPlayerScreen> {
  // Text Editing Controllers to capture the input values
  final TextEditingController _shiftNameController = TextEditingController();
  final TextEditingController _shiftStartController = TextEditingController();
  final TextEditingController _shiftEndController = TextEditingController();

  // Controllers for the new fields
  final TextEditingController _playerAgeController = TextEditingController();
  final TextEditingController _playerPositionController = TextEditingController();
  final TextEditingController _teamNameController = TextEditingController();

  // Dropdown field value
  String _transactionType = 'India'; // Default value for dropdown

  @override
  void dispose() {
    // Dispose of the controllers when the widget is disposed
    _shiftNameController.dispose();
    _shiftStartController.dispose();
    _shiftEndController.dispose();
    _playerAgeController.dispose();
    _playerPositionController.dispose();
    _teamNameController.dispose();
    super.dispose();
  }

  // Function to handle saving the shift
  Future<void> _saveShift() async {
    if (_shiftNameController.text.isNotEmpty &&
        _shiftStartController.text.isNotEmpty &&
        _shiftEndController.text.isNotEmpty &&
        _playerAgeController.text.isNotEmpty &&
        _playerPositionController.text.isNotEmpty &&
        _teamNameController.text.isNotEmpty) {

      // Prepare the request body
      final Map<String, dynamic> requestBody = {
        "affiliateId": "6706729f843417d0e4f6b23c",
        "firstName": _shiftNameController.text,
        "lastName": _shiftStartController.text,
        "email": _playerPositionController.text,
        "password": _teamNameController.text, // Assuming this is the password
        "mobile": _playerAgeController.text, // Assuming this is the phone number
        "dob": "1996-09-25", // You can replace this with a date picker value if needed
        "countryId": "66b1e4e0fc24cb205b54ca32"
      };

      // Make the API request
      final response = await http.post(
        Uri.parse('https://betz.blocmatrix.com/api/register'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(requestBody),
      );

      if (response.statusCode == 200) {
        // Handle successful response
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Registration Successful')),
        );
        Navigator.pop(context); // Navigate back to the previous screen
      } else {
        // Handle error response
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: ${response.body}')),
        );
      }
    } else {
      // Show error if any field is empty
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please fill all fields')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Credits'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back), // Back button icon
          onPressed: () {
            Navigator.pop(context); // Navigate to the previous screen
          },
        ),
      ),
      body: Container(
        color: Color(0xFF212B36), // Set background color
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: SingleChildScrollView( // Allows scrolling if needed
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center, // Center the fields vertically
              children: <Widget>[
                // Shift Name Field
                Image.asset(
                  'assets/splash.png', // Path to your logo image
                  height: 100, // Adjust the size as needed
                ),
                SizedBox(height: 20), // Space between the logo and text field
                TextField(
                  controller: _shiftNameController,
                  style: TextStyle(color: Colors.white), // Set input text color to white
                  decoration: const InputDecoration(
                    labelText: 'First Name',
                    labelStyle: TextStyle(color: Colors.white), // Set label text color to white
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 20),

                // Shift Start Field
                TextField(
                  controller: _shiftStartController,
                  style: TextStyle(color: Colors.white), // Set input text color to white
                  decoration: const InputDecoration(
                    labelText: 'Last Name',
                    labelStyle: TextStyle(color: Colors.white), // Set label text color to white
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 20),

                // Player Age Field
                TextField(
                  controller: _playerAgeController,
                  style: TextStyle(color: Colors.white), // Set input text color to white
                  decoration: const InputDecoration(
                    labelText: 'Phone Number',
                    labelStyle: TextStyle(color: Colors.white), // Set label text color to white
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 20),

                // Player Position Field
                TextField(
                  controller: _playerPositionController,
                  style: TextStyle(color: Colors.white), // Set input text color to white
                  decoration: InputDecoration(
                    labelText: 'Email',
                    labelStyle: TextStyle(color: Colors.white), // Set label text color to white
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 20),

                // Team Name Field
                TextField(
                  controller: _teamNameController,
                  style: TextStyle(color: Colors.white), // Set input text color to white
                  decoration: InputDecoration(
                    labelText: 'Password',
                    labelStyle: TextStyle(color: Colors.white), // Set label text color to white
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 20),

                DropdownButtonFormField<String>(
                  value: _transactionType, // The currently selected item
                  dropdownColor: Color(0xFF212B36), // Dropdown background color
                  style: TextStyle(color: Colors.white), // Text color inside dropdown
                  decoration: const InputDecoration(
                    labelText: 'Select Country',
                    labelStyle: TextStyle(color: Colors.white), // Set label text color to white
                    border: OutlineInputBorder(),
                  ),
                  items: <String>['India', 'China']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      _transactionType = newValue!;
                    });
                  },
                ),
                SizedBox(height: 20),

                // Save Shift Button
                ElevatedButton(
                  onPressed: _saveShift,
                  child: Text('Submit'),
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(double.infinity, 50), // Full-width button
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
