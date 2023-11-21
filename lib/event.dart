import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AddEventPage extends StatefulWidget {
  final String eventHubId; // New parameter

  AddEventPage({required this.eventHubId}); // Constructor

  @override
  _AddEventPageState createState() => _AddEventPageState();
}

class _AddEventPageState extends State<AddEventPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  Future<void> _addEvent() async {
    final String apiUrl =
        'https://4f3f-111-92-126-211.ngrok-free.app/event/addToHub/${widget.eventHubId}';
// Replace with your actual API endpoint

    final response = await http.post(
      Uri.parse(apiUrl),
      body: jsonEncode({
        'name': _nameController.text,
        'date': _dateController.text,
      }),
      headers: {
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      // Successful request, you can handle the response here if needed
      print('Event added successfully');
    } else {
      // Handle the error
      print('Failed to add event. Status code: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Event'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _nameController,
              decoration: InputDecoration(labelText: 'Event Name'),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _dateController,
              decoration: InputDecoration(labelText: 'Event Date'),
            ),
            SizedBox(height: 16.0),
            Text('Event Hub ID: ${widget.eventHubId}'),
            SizedBox(height: 32.0),
            ElevatedButton(
              onPressed: _addEvent,
              child: Text('Add Event'),
            ),
          ],
        ),
      ),
    );
  }
}
