import 'package:flutter/material.dart';

class FaceActivityLogsPage extends StatelessWidget {
  final List<Map<String, String>> mockLogs = [
    {'name': 'John Doe', 'event': 'Entered Main Gate', 'time': '10:23 AM'},
    {'name': 'Jane Smith', 'event': 'Exited Parking Lot', 'time': '11:00 AM'},
    {'name': 'Unknown', 'event': 'Suspicious Movement', 'time': '11:15 AM'},
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          Text('Face & Activity Logs', style: TextStyle(color: Colors.white, fontSize: 28)),
          SizedBox(height: 8),
          Text('Monitor face recognition and activity logs', style: TextStyle(color: Colors.grey)),
          SizedBox(height: 24),
          DataTable(
            columns: [
              DataColumn(label: Text('Name', style: TextStyle(color: Colors.grey))),
              DataColumn(label: Text('Event', style: TextStyle(color: Colors.grey))),
              DataColumn(label: Text('Time', style: TextStyle(color: Colors.grey))),
            ],
            rows: mockLogs.map((log) {
              return DataRow(cells: [
                DataCell(Text(log['name']!, style: TextStyle(color: Colors.white))),
                DataCell(Text(log['event']!, style: TextStyle(color: Colors.white))),
                DataCell(Text(log['time']!, style: TextStyle(color: Colors.white))),
              ]);
            }).toList(),
          ),
        ],
      ),
    );
  }
}
