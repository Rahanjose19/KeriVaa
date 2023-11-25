import 'package:bettingapp/event.dart';
import 'package:flutter/material.dart';
import 'package:bettingapp/eventHubList.dart';

class EventDetailsPage extends StatelessWidget {
  final String name;
  final String id;

  const EventDetailsPage({
    required this.name,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Event Hub Details'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Event Name: ${name}'),
            SizedBox(height: 16.0),
            Text('Event ID: ${id}'),
            ElevatedButton(
              onPressed: () {
                 Navigator.pop(context);
              },
              child: Text('Go to Event List Page'),
            )
          ],
        ),
      ),
    );
  }
}
