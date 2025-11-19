import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  bool faceRecognitionEnabled = true;
  bool emailAlerts = true;
  bool smsAlerts = false;
  double alertSensitivity = 75;
  double motionSensitivity = 60;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Header
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('System Settings', style: TextStyle(color: Colors.white, fontSize: 28)),
              SizedBox(height: 4),
              Text('Configure cameras, users, and system parameters', style: TextStyle(color: Colors.grey)),
            ],
          ),
        ),

        // Tabs
        TabBar(
          controller: _tabController,
          labelColor: Colors.white,
          unselectedLabelColor: Colors.grey,
          indicatorColor: Colors.blue,
          tabs: [
            Tab(text: 'Cameras'),
            Tab(text: 'Users'),
            Tab(text: 'Detection'),
            Tab(text: 'Alerts'),
          ],
        ),

        Expanded(
          child: TabBarView(
            controller: _tabController,
            children: [
              // Cameras tab
              Center(child: Text('Camera management UI placeholder', style: TextStyle(color: Colors.grey))),
              // Users tab
              Center(child: Text('User management UI placeholder', style: TextStyle(color: Colors.grey))),
              // Detection tab
              Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  children: [
                    Text('AI Detection Settings', style: TextStyle(color: Colors.white, fontSize: 20)),
                    SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Alert Sensitivity', style: TextStyle(color: Colors.grey)),
                        Text('${alertSensitivity.toInt()}%', style: TextStyle(color: Colors.white)),
                      ],
                    ),
                    Slider(
                      value: alertSensitivity,
                      min: 0,
                      max: 100,
                      divisions: 100,
                      onChanged: (val) => setState(() => alertSensitivity = val),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Motion Detection Sensitivity', style: TextStyle(color: Colors.grey)),
                        Text('${motionSensitivity.toInt()}%', style: TextStyle(color: Colors.white)),
                      ],
                    ),
                    Slider(
                      value: motionSensitivity,
                      min: 0,
                      max: 100,
                      divisions: 100,
                      onChanged: (val) => setState(() => motionSensitivity = val),
                    ),
                    SwitchListTile(
                      value: faceRecognitionEnabled,
                      onChanged: (val) => setState(() => faceRecognitionEnabled = val),
                      title: Text('Face Recognition', style: TextStyle(color: Colors.white)),
                      subtitle: Text('Enable automatic face recognition', style: TextStyle(color: Colors.grey)),
                    ),
                    ElevatedButton.icon(
                      onPressed: () {},
                      icon: Icon(Icons.save),
                      label: Text('Save Detection Settings'),
                    ),
                  ],
                ),
              ),
              // Alerts tab
              Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  children: [
                    SwitchListTile(
                      value: emailAlerts,
                      onChanged: (val) => setState(() => emailAlerts = val),
                      title: Text('Email Alerts', style: TextStyle(color: Colors.white)),
                      subtitle: Text('Receive alerts via email', style: TextStyle(color: Colors.grey)),
                    ),
                    if (emailAlerts)
                      TextField(
                        decoration: InputDecoration(
                          labelText: 'Email Address',
                          labelStyle: TextStyle(color: Colors.grey),
                          filled: true,
                          fillColor: Color(0xFF2A2A2A),
                        ),
                        style: TextStyle(color: Colors.white),
                      ),
                    SwitchListTile(
                      value: smsAlerts,
                      onChanged: (val) => setState(() => smsAlerts = val),
                      title: Text('SMS Alerts', style: TextStyle(color: Colors.white)),
                      subtitle: Text('Receive alerts via SMS', style: TextStyle(color: Colors.grey)),
                    ),
                    if (smsAlerts)
                      TextField(
                        decoration: InputDecoration(
                          labelText: 'Phone Number',
                          labelStyle: TextStyle(color: Colors.grey),
                          filled: true,
                          fillColor: Color(0xFF2A2A2A),
                        ),
                        style: TextStyle(color: Colors.white),
                      ),
                    ElevatedButton.icon(
                      onPressed: () {},
                      icon: Icon(Icons.save),
                      label: Text('Save Alert Settings'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
