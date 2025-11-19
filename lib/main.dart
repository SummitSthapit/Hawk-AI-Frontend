// lib/main.dart
import 'package:flutter/material.dart';

// Make sure these file names match exactly (case-sensitive)
import 'pages/login_page.dart';
import 'pages/dashboard.dart';
import 'pages/live_monitor.dart';
import 'pages/upload_analyzer.dart';
import 'pages/face_activity_logs.dart';
import 'pages/alerts.dart';
import 'pages/settings.dart';
import 'pages/side_bar.dart';

void main() {
  runApp(SecureWatchApp());
}

class SecureWatchApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SecureWatch AI',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: LoginWrapper(),
    );
  }
}

class LoginWrapper extends StatefulWidget {
  @override
  State<LoginWrapper> createState() => _LoginWrapperState();
}

class _LoginWrapperState extends State<LoginWrapper> {
  bool isLoggedIn = false;

  @override
  Widget build(BuildContext context) {
    if (!isLoggedIn) {
      return LoginPage(
        onLogin: () {
          setState(() {
            isLoggedIn = true;
          });
        },
      );
    }

    return MainLayout();
  }
}

class MainLayout extends StatefulWidget {
  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  String currentPage = "dashboard";

  Widget _getPage() {
    switch (currentPage) {
      case "dashboard":
        return DashboardPage();
      case "live-monitor":
        return LiveMonitorPage();           // <- ensure this class exists in live_monitor.dart
      case "upload-analyze":
        return UploadAnalyzePage();        // <- ensure this class exists in upload_analyzer.dart
      case "face-logs":
        return FaceActivityLogsPage();
      case "alerts":
        return AlertsPage();
    // <- ensure this class exists in alerts.dart
      case "settings":
        return SettingsPage();
      default:
        return DashboardPage();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          SizedBox(
            width: 260,
            child: Sidebar(
              currentPage: currentPage,
              onPageChange: (page) {
                setState(() {
                  currentPage = page;
                });
              },
              onLogout: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (_) => LoginWrapper()),
                      (route) => false,
                );
              },
            ),
          ),
          Expanded(
            child: Container(
              color: const Color(0xFF1F1F1F),
              child: _getPage(),
            ),
          ),
        ],
      ),
    );
  }
}
