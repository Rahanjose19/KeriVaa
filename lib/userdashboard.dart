import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'userEventList.dart';
import 'enterEventPage.dart';

class User {
  final int id;
  final String name;

  User({required this.id, required this.name});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(id: json['id'], name: json['name']);
  }
}

class UserDashboardPage extends StatefulWidget {
  final String username;
  final int userId;

  UserDashboardPage({required this.username, required this.userId});

  @override
  _UserDashboardPageState createState() => _UserDashboardPageState();
}

class _UserDashboardPageState extends State<UserDashboardPage> {
  final List<String> _userEvents = []; // Placeholder for user-specific events

  Future<void> _fetchUserEvents() async {
    // Replace the URL with your actual API endpoint to fetch user events
    final response = await http.get(
      Uri.parse(
          'https://382e-2409-4073-2e9a-c499-5c74-813-7dba-3f1a.ngrok-free.app/${widget.userId}/events'),
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = jsonDecode(response.body);
      final List<String> userEvents = data.cast<String>().toList();

      setState(() {
        _userEvents.clear();
        _userEvents.addAll(userEvents);
      });
    } else {
      throw Exception('Failed to fetch user events');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Dashboard'),
      ),
      body: ListView(
        children: [ 
          DashboardItem(
            title: 'Event Hub',
            icon: Icons.leaderboard,
            onTap: ()  async {
              await _fetchUserEvents();
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => UserEventListPage(_userEvents),
                ),
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
            title: 'Enter event ',
            icon: Icons.poll,
            onTap: () {
               Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => EnterEventCodePage()),
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
