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
  @override
  _UserDashboardPageState createState() => _UserDashboardPageState();
}

class _UserDashboardPageState extends State<UserDashboardPage> {
  final List<String> _userEvents = []; // Placeholder for user-specific events

  Future<void> _fetchUserEvents() async {
    // Replace the URL with your actual API endpoint to fetch user events
    final response = await http.get(
      Uri.parse(
          'https://d86f-2409-40f3-109f-d64f-68f6-4a8a-4302-3cdb.ngrok-free.app/user/events'),
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
                await _fetchUserEvents();
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
