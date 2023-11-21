import 'package:bettingapp/eventHub.dart';
import 'package:flutter/material.dart';
import 'package:bettingapp/pollpage.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Dashboard',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: UserDashboardScreen(),
    );
  }
}

class UserDashboardScreen extends StatelessWidget {
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
            title: 'Event Hub',
            icon: Icons.leaderboard,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => EventHub()),
              );
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
          DashboardItem(
            title: 'Poll',
            icon: Icons.poll,
            onTap: () {
              // Handle poll item tap
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => PollPage()),
              );
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
