import 'package:flutter/material.dart';

class AlertsPage extends StatelessWidget {
  final List<Map<String, String>> mockAlerts = [
    {'event': 'Unauthorized Entry', 'severity': 'High', 'time': '10:05 AM'},
    {'event': 'Camera Offline', 'severity': 'Medium', 'time': '11:12 AM'},
    {'event': 'Suspicious Activity', 'severity': 'Critical', 'time': '12:30 PM'},
  ];

  Color getSeverityColor(String severity) {
    switch (severity.toLowerCase()) {
      case 'critical':
        return Colors.red;
      case 'high':
        return Colors.orange;
      case 'medium':
        return Colors.yellow;
      case 'low':
        return Colors.blue;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          Text('Alerts', style: TextStyle(color: Colors.white, fontSize: 28)),
          SizedBox(height: 8),
          Text('Monitor recent alerts and notifications', style: TextStyle(color: Colors.grey)),
          SizedBox(height: 24),
          Column(
            children: mockAlerts.map((alert) {
              return Container(
                margin: EdgeInsets.symmetric(vertical: 8),
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Color(0xFF2A2A2A),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(alert['event']!, style: TextStyle(color: Colors.white)),
                    Row(
                      children: [
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                          decoration: BoxDecoration(
                            color: getSeverityColor(alert['severity']!),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(alert['severity']!, style: TextStyle(color: Colors.white)),
                        ),
                        SizedBox(width: 16),
                        Text(alert['time']!, style: TextStyle(color: Colors.grey)),
                      ],
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
