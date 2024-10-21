import 'package:flutter/material.dart';

class AddCreditsScreen extends StatefulWidget {
  @override
  _AddCreditsScreenState createState() => _AddCreditsScreenState();
}

class _AddCreditsScreenState extends State<AddCreditsScreen> {
  // Text Editing Controllers to capture the input values
  final TextEditingController _shiftNameController = TextEditingController();
  final TextEditingController _shiftStartController = TextEditingController();
  final TextEditingController _shiftEndController = TextEditingController();

  // Dropdown field value
  String _transactionType = 'Credit'; // Default value for dropdown

  @override
  void dispose() {
    // Dispose of the controllers when the widget is disposed
    _shiftNameController.dispose();
    _shiftStartController.dispose();
    _shiftEndController.dispose();
    super.dispose();
  }

  // Function to handle saving the shift
  void _saveShift() {
    if (_shiftNameController.text.isNotEmpty &&
        _shiftStartController.text.isNotEmpty &&
        _shiftEndController.text.isNotEmpty) {
      // Show a snackbar with the shift details (You can replace this with your actual saving logic)
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Shift Saved: ${_shiftNameController.text}, Transaction: $_transactionType')),
      );
      // After saving, navigate back to the Dashboard
      Navigator.pop(context);
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
        title: Text('Add Player'),
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
                Image.asset(
                  'assets/splash.png', // Path to your logo image
                  height: 100,
                  // Adjust the size as needed
                ),
                SizedBox(height: 20), // Space between the logo and text field
                TextField(
                  controller: _shiftNameController,
                  style: TextStyle(color: Colors.white), // Set input text color to white
                  decoration: InputDecoration(
                    labelText: 'Enter Player Name',
                    labelStyle: TextStyle(color: Colors.white), // Set label text color to white
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 20),

                // Dropdown for Credit or Debit selection
                DropdownButtonFormField<String>(
                  value: _transactionType, // The currently selected item
                  dropdownColor: Color(0xFF212B36), // Dropdown background color
                  style: TextStyle(color: Colors.white), // Text color inside dropdown
                  decoration: InputDecoration(
                    labelText: 'Select Transaction Type',
                    labelStyle: TextStyle(color: Colors.white), // Set label text color to white
                    border: OutlineInputBorder(),
                  ),
                  items: <String>['Credit', 'Debit']
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

                // Shift Start Field
                TextField(
                  controller: _shiftStartController,
                  style: TextStyle(color: Colors.white), // Set input text color to white
                  decoration: InputDecoration(
                    labelText: 'Enter Amount',
                    labelStyle: TextStyle(color: Colors.white), // Set label text color to white
                    border: OutlineInputBorder(),
                  ),
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