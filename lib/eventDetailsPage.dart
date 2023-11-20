import 'package:flutter/material.dart';

class EventDetailsPage extends StatelessWidget {
  final String name;
  final String id;
  final String hubId;

  const EventDetailsPage({
    required this.name,
    required this.id,
    required this.hubId,
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
            Text('Hub ID: ${hubId}'),
            SizedBox(height: 16.0),
            Text('Event ID: ${id}'),
          ],
        ),
      ),
    );
  }
}
