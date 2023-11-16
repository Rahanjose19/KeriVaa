import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Dashboard',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: DashboardScreen(),
    );
  }
}

class DashboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dashboard'),
      ),
      body: ListView(
        children: [
          DashboardItem(
            title: 'Profile',
            icon: Icons.person,
            onTap: () {
              // Handle profile item tap
            },
          ),
          DashboardItem(
            title: 'Leaderboard',
            icon: Icons.leaderboard,
            onTap: () {
              // Handle leaderboard item tap
            },
          ),
          DashboardItem(
            title: 'Rewards',
            icon: Icons.card_giftcard,
            onTap: () {
              // Handle rewards item tap
            },
          ),
          DashboardItem(
            title: 'Settings',
            icon: Icons.settings,
            onTap: () {
              // Handle settings item tap
            },
          ),
        ],
      ),
    );
  }
}

class DashboardItem extends StatelessWidget {
  final String title;
  final IconData icon;
  final VoidCallback onTap;

  DashboardItem({required this.title, required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(title),
      leading: Icon(icon),
      onTap: onTap,
    );
  }
}
