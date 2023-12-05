import 'package:bettingapp/event.dart';
import 'package:flutter/material.dart';

class EventAddPage extends StatelessWidget {
  final String name;
  final String id;

  const EventAddPage({
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
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddEventPage(
                      eventHubId: id,
                    ),
                  ),
                );
              },
              child: Text('Go to Event Page'),
            )
          ],
        ),
      ),
    );
  }
}
