import 'package:flutter/material.dart';

class Sidebar extends StatelessWidget {
  final String currentPage;
  final Function(String) onPageChange;
  final VoidCallback onLogout;

  Sidebar({
    required this.currentPage,
    required this.onPageChange,
    required this.onLogout,
  });

  final List<Map<String, dynamic>> menuItems = [
    {'id': 'dashboard', 'label': 'Dashboard', 'icon': Icons.home},
    {'id': 'live-monitor', 'label': 'Live Monitor', 'icon': Icons.monitor},
    {'id': 'upload-analyze', 'label': 'Video Upload & Review', 'icon': Icons.upload_file},
    {'id': 'face-logs', 'label': 'Face & Activity Logs', 'icon': Icons.person_search},
    {'id': 'alerts', 'label': 'Alerts', 'icon': Icons.notifications, 'badge': '3'},
    {'id': 'settings', 'label': 'Settings', 'icon': Icons.settings},
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      color: Color(0xFF1A1A1A),
      child: Column(
        children: [
          // Logo
          Container(
            padding: EdgeInsets.all(16),
            child: Row(
              children: [
                Container(
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [Colors.blue, Colors.purple]),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(Icons.shield, color: Colors.white),
                ),
                SizedBox(width: 8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('SecureWatch', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                    Text('AI Security System', style: TextStyle(color: Colors.grey, fontSize: 12)),
                  ],
                )
              ],
            ),
          ),
          Divider(color: Colors.grey[700]),
          // Menu
          Expanded(
            child: ListView(
              children: menuItems.map((item) {
                bool isActive = currentPage == item['id'];
                return ListTile(
                  leading: Icon(item['icon'], color: isActive ? Colors.white : Colors.grey),
                  title: Text(item['label'], style: TextStyle(color: isActive ? Colors.white : Colors.grey)),
                  trailing: item.containsKey('badge')
                      ? Container(
                    padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(color: Colors.red, borderRadius: BorderRadius.circular(12)),
                    child: Text(item['badge'], style: TextStyle(color: Colors.white, fontSize: 12)),
                  )
                      : null,
                  selected: isActive,
                  selectedTileColor: Colors.blueAccent,
                  onTap: () => onPageChange(item['id']),
                );
              }).toList(),
            ),
          ),
          Divider(color: Colors.grey[700]),
          // Logout
          ListTile(
            leading: Icon(Icons.logout, color: Colors.grey),
            title: Text('Logout', style: TextStyle(color: Colors.grey)),
            onTap: onLogout,
          ),
        ],
      ),
    );
  }
}
