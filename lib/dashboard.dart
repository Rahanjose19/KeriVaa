import 'package:bettingapp/eventHub.dart';
import 'package:bettingapp/eventHubList.dart';
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
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.blue, Colors.indigo],
          ),
        ),
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
          children: [
            DashboardItem(
              title: 'Profile',
              icon: Icons.person,
              onTap: () {
                // Handle profile item tap
              },
            ),
            SizedBox(height: 16.0),
            DashboardItem(
              title: 'Event Hub',
              icon: Icons.leaderboard,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => EventHubPage()),
                );
              },
            ),
            SizedBox(height: 16.0),
            DashboardItem(
              title: 'Rewards',
              icon: Icons.card_giftcard,
              onTap: () {
                // Handle rewards item tap
              },
            ),
            SizedBox(height: 16.0),
            DashboardItem(
              title: 'Settings',
              icon: Icons.settings,
              onTap: () {
                // Handle settings item tap
              },
            ),
            SizedBox(height: 16.0),
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
            SizedBox(height: 16.0),
            DashboardItem(
              title: 'EventHubList',
              icon: Icons.panorama_rounded,
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => EventListPage()),
                );
              },
            ),
          ],
        ),
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
    return Card(
      color: Colors.white,
      elevation: 4.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: ListTile(
        title: Text(
          title,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        leading: Icon(
          icon,
          color: Colors.blue,
        ),
        onTap: onTap,
      ),
    );
  }
}
