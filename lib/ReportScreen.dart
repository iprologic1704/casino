import 'package:flutter/material.dart';

class ReportScreen extends StatelessWidget {
  // Static list of reports for demonstration
  final List<Map<String, dynamic>> reportData = [
    {"name": "Rahul", "debit": 0, "credit": 500},
    {"name": "Kalyan", "debit": 300, "credit": 0},
    {"name": "Srikanth", "debit": 100, "credit": 1000},
    {"name": "Neelima", "debit": 700, "credit": 0},
    {"name": "Sunil", "debit": 0, "credit": 150},
  ];

  // Method to calculate total credit
 /* int getTotalCredit() {
    return reportData.fold(0, (sum, item) => sum + (item['credit'] ?? 0));
  }

// Method to calculate total debit
  int getTotalDebit() {
    return reportData.fold(0, (sum, item) => sum + (item['debit'] ?? 0));
  }*/


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Report'),
      ),
      backgroundColor: Color(0xFF212B36), // Set background color
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Heading for Name and Opening Balance
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Name: Test', // Static or dynamic name value
                  style: TextStyle(
                      fontSize: 15, fontWeight: FontWeight.bold, color: Colors.white), // Styling for name
                ),
                Text(
                  'Balance: \$200', // Static or dynamic balance value
                  style: TextStyle(
                      fontSize: 15, fontWeight: FontWeight.bold, color: Colors.grey), // Styling for balance
                ),
              ],
            ),
            SizedBox(height: 20),

            // Data Table
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal, // Allows horizontal scrolling if needed
                child: DataTable(
                  columnSpacing: 50.0, // Spacing between columns
                  columns: const [
                    DataColumn(
                      label: Text(
                        'Player Name',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'Credit',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                    ),
                    DataColumn(
                      label: Text(
                        'Debit',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                    ),
                  ],
                  rows: reportData.map((report) {
                    return DataRow(cells: [
                      DataCell(
                        Text(
                          report['name'],
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      DataCell(
                        Text(
                          report['credit'].toString(),
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      DataCell(
                        Text(
                          report['debit'].toString(),
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ]);
                  }).toList(),
                ),
              ),
            ),

            // Total Credit and Debit Section
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // First Row for Total, Total Credit, and Total Debit
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Total',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                      Text(
                        'Total Credit: 1650',
                        style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.green),
                      ),
                      Text(
                        'Total Debit: 1100',
                        style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.red),
                      ),
                    ],
                  ),
                  SizedBox(height: 10), // Space between the two rows

                  // Second Row for Opening Balance and Current Balance
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Opening Balance: \$500',
                        style: TextStyle(
                            fontSize: 12, fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                      Text(
                        'Current Balance: \$600',
                        style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: Colors.blue),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
