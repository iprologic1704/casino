import 'package:flutter/material.dart';
import 'package:poscode/AddCreditsScreen.dart';
import 'package:poscode/LoginScreen.dart';
import 'package:poscode/UserListScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'AddPlayerScreen.dart';
import 'ReportScreen.dart';

class DashboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back), // Back button icon
          onPressed: () {
            // Navigate to the Login screen
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => LoginScreen()),
            );
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.logout), // Logout button icon
            onPressed: () async {
              SharedPreferences prefs = await SharedPreferences.getInstance();
              await prefs.clear(); // Clear all saved preferences or specific keys
              // Navigate to the Login screen
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => LoginScreen()),
              );
            },
          ),
        ],
      ),

      backgroundColor: Color(0xFF212B36), // Set background color
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start, // Align cards to the start
          children: [
            SizedBox(height: 20), // Space at the top
            // Heading for Name and Opening Balance
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    'Name: Test',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                ),
                Expanded(
                  child: Text(
                    'Opening Balance: \$200',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.grey),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20), // Space below the heading
//The specific RenderFlex in question is: RenderFlex#9a97d relayoutBoundary=up2 OVERFLOWING
            // Card for Adding Player
            Card(
              margin: EdgeInsets.only(bottom: 16,left: 16,right: 16), // Space between cards
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: InkWell(
                onTap: () {
                  // Navigate to AddShiftScreen
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AddPlayerScreen()),
                  );
                },
                child: Container(
                  height: 100,
                  width: double.infinity, // Full width of the parent
                  child: const ListTile(
                    leading: Icon(Icons.add, size: 40, color: Colors.blue),
                    title: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Add Player',
                            style: TextStyle(fontSize: 18),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            // Card for Adding Credits
            Card(
              margin: EdgeInsets.only(bottom: 16,left: 16,right: 16), // Space between cards
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: InkWell(
                onTap: () {
                  // Navigate to ReportScreen
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AddCreditsScreen()),
                  );
                },
                child: Container(
                  height: 100,
                  width: double.infinity, // Full width of the parent
                  child: const ListTile(
                    leading: Icon(Icons.credit_score, size: 40, color: Colors.purple),
                    title: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Add Credits',
                            style: TextStyle(fontSize: 18),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            // Card for Viewing Report
            Card(
              margin: EdgeInsets.only(bottom: 16,left: 16,right: 16), // Space between cards
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: InkWell(
                onTap: () {
                  // Navigate to ReportScreen
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ReportScreen()),
                  );
                },
                child: Container(
                  height: 100,
                  width: double.infinity, // Full width of the parent
                  child: const ListTile(
                    leading: Icon(Icons.list, size: 40, color: Colors.green),
                    title: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'View Report',
                            style: TextStyle(fontSize: 18),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),

         /*   Card(
              margin: EdgeInsets.only(bottom: 16,left: 16,right: 16), // Space between cards
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: InkWell(
                onTap: () {
                  // Navigate to ReportScreen
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => UserListScreen()),
                  );
                },
                child: Container(
                  height: 100,
                  width: double.infinity, // Full width of the parent
                  child: ListTile(
                    leading: Icon(Icons.verified_user, size: 40, color: Colors.red),
                    title: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Get Data',
                            style: TextStyle(fontSize: 18),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),*/
          ],
        ),
      ),
    );
  }
}
