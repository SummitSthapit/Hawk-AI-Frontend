import 'package:flutter/material.dart';

class DashboardPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          Text('Dashboard', style: TextStyle(fontSize: 28, color: Colors.white)),
          SizedBox(height: 8),
          Text('Overview of system metrics', style: TextStyle(color: Colors.grey)),
          SizedBox(height: 24),
          // Add mock stats cards
          Row(
            children: [
              Expanded(child: InfoCard(title: 'Active Cameras', value: '4')),
              SizedBox(width: 16),
              Expanded(child: InfoCard(title: 'Detected Events', value: '5')),
            ],
          ),
          SizedBox(height: 16),
          Row(
            children: [
              Expanded(child: InfoCard(title: 'Users Online', value: '3')),
              SizedBox(width: 16),
              Expanded(child: InfoCard(title: 'Alerts', value: '2')),
            ],
          ),
        ],
      ),
    );
  }
}

class InfoCard extends StatelessWidget {
  final String title;
  final String value;

  InfoCard({required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Color(0xFF2A2A2A),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: TextStyle(color: Colors.grey)),
          SizedBox(height: 8),
          Text(value, style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }
}
