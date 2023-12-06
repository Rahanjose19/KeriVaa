import 'package:bettingapp/adminpollpage.dart';
import 'package:bettingapp/createpoll.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

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
        'https://382e-2409-4073-2e9a-c499-5c74-813-7dba-3f1a.ngrok-free.app/eventHub/${widget.hubId}/events'));

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
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          // Handle button press for the specific event
                          // You can navigate to another page or perform any other action
                          // based on the selected event.
                          // For example, you can show event details in a dialog.
                          showEventDetails(events[index]);
                        },
                        child: Text('View'),
                      ),
                      SizedBox(width: 8),
                      ElevatedButton(
                        onPressed: () {
                          // Navigate to the CreatePollPage when the button is pressed
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CreatePollPage(
                                  eventId: int.parse(events[index].id)),
                            ),
                          );
                        },
                        child: Text('Create Poll'),
                      ),

                      //elevated button for admin poll page
                      SizedBox(width: 8),
                      ElevatedButton(
                        onPressed: () {
                          // Navigate to the CreatePollPage when the button is pressed
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  AdminPollPage(eventId: events[index].id),
                            ),
                          );
                        },
                        child: Text('Admin Poll'),
                      ),
                    ],
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
