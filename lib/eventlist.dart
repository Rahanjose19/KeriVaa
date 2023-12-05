import 'package:bettingapp/eventPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Event {
  final String id;
  final String name;
  // Add other necessary event details

  Event({required this.id, required this.name});
}

class ListEventsPage extends StatefulWidget {
  final String hubId;
  ListEventsPage({required this.hubId});

  @override
  _EventPageState createState() => _EventPageState();
}

class _EventPageState extends State<ListEventsPage> {
  late List<Event> events = [];
  late String hubName;

  @override
  void initState() {
    super.initState();
    // Fetch events data based on hub_id
    fetchData();
  }

  Future<void> fetchData() async {
    final response = await http.get(Uri.parse(
        'https://d86f-2409-40f3-109f-d64f-68f6-4a8a-4302-3cdb.ngrok-free.app/eventHub/${widget.hubId}/events'));

    if (response.statusCode == 200) {
      // If server returns an OK response, parse the events
      List<dynamic> data = jsonDecode(response.body);
      print(data);
      setState(() {
        events = data
            .map((eventData) => Event(
                  id: eventData['id'] ?? '',
                  name: eventData['name'] ?? '',
                  // Add other necessary event details
                ))
            .toList();
        // hubName = data[0]['hub_name'];
      });
    } else {
      // If the server did not return a 200 OK response,
      // throw an exception.
      throw Exception('Failed to load events');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Events for Hub ${widget.hubId}'),
      ),
      body: events.isNotEmpty
          ? ListView.builder(
              itemCount: events.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(events[index].name),
                  subtitle: Text('Event ID: ${events[index].id}'),
                  // Add other widgets to display event details
                  trailing: ElevatedButton(
                    onPressed: () {
                      // Handle button press for the specific event
                      // You can navigate to another page or perform any other action
                      // based on the selected event.
                      // For example, you can show event details in a dialog.
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  EventDetailsPage(eventId: events[index].id)));
                    },
                    child: Text('View'),
                  ),
                );
              },
            )
          : Center(
              child: CircularProgressIndicator(),
            ),
    );
  }

  void showEventDetails(Event event) {
    // Implement the logic to show event details
    // This could be a dialog, navigation to another page, etc.
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Event Details'),
          content: Column(
            // Add widgets to display detailed event information
            children: [
              Text('Event ID: ${event.id}'),
              Text('Event Name: ${event.name}'),
              // Add other event details
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  }
}

