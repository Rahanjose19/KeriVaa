import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'userEventList.dart';

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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Welcome to the User Dashboard!'),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                // await _fetchUserEvents();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => UserEventListPage(_userEvents),
                  ),
                );
              },
              child: Text('View User Events'),
            ),
          ],
        ),
      ),
    );
  }
}
