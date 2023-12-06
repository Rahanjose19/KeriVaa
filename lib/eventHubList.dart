import 'dart:convert';
import 'package:bettingapp/event.dart';
import 'package:bettingapp/eventlist.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class EventListPage extends StatefulWidget {
  const EventListPage({Key? key}) : super(key: key);

  @override
  _EventListPageState createState() => _EventListPageState();
}

class _EventListPageState extends State<EventListPage> {
  List<EventHub> eventHubs = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    final response = await http.get(Uri.parse(
        'https://382e-2409-4073-2e9a-c499-5c74-813-7dba-3f1a.ngrok-free.app/eventhub'));

    if (response.statusCode == 200) {
      print(response.body);
      List<dynamic> data = jsonDecode(response.body);

      setState(() {
        eventHubs = data
            .map((eventHubJson) => EventHub.fromJson(eventHubJson))
            .toList();
      });
    } else {
      // Handle error cases
      print('Error: ${response.statusCode}');
      print('Response body: ${response.body}');
    }
  }

  Future<void> deleteEventHub(String eventHubId) async {
    final response = await http.delete(
      Uri.parse(
          'https://382e-2409-4073-2e9a-c499-5c74-813-7dba-3f1a.ngrok-free.app/eventhub/$eventHubId'),
    );

    if (response.statusCode == 200) {
      // EventHub deleted successfully, refresh the list
      fetchData();
    } else {
      // Handle error cases
      print('Error deleting EventHub: ${response.statusCode}');
      print('Response body: ${response.body}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Event Hubs'),
      ),
      body: ListView.builder(
        itemCount: eventHubs.length,
        itemBuilder: (context, index) {
          return ListTile(
              title: Text(
                eventHubs[index].name ?? '',
                style: TextStyle(
                  fontSize: 20, // Adjust the font size as needed
                ),
              ),
              subtitle: Text('Start Date: ${eventHubs[index].startDate}'),
              trailing: Row(mainAxisSize: MainAxisSize.min, children: [
                ElevatedButton(
                  onPressed: () {
                    // Redirect to the AddEventPage with the corresponding eventHubId
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AddEventPage(
                          eventHubId: eventHubs[index].id ?? '',
                        ),
                      ),
                    );
                  },
                  child: Icon(Icons.add),
                ),

                SizedBox(width: 8), // Add some space between buttons
                ElevatedButton(
                  onPressed: () {
                    // Redirect to the EventListPage passing the hub_id
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ListEventsPage(
                          hubId: eventHubs[index].id ?? '',
                        ),
                      ),
                    );
                  },
                  child: Icon(Icons.remove_red_eye),
                ),
                SizedBox(width: 8), // Add some space between buttons
                ElevatedButton(
                  onPressed: () {
                    // Delete the EventHub
                    deleteEventHub(eventHubs[index].id ?? '');
                  },
                  style: ElevatedButton.styleFrom(primary: Colors.red),
                  child: Icon(Icons.close, color: Colors.white),
                ),
              ]));
        },
      ),
    );
  }
}

class EventHub {
  final String? id;
  final String? name;
  final String? startDate;
  final String? endDate;

  EventHub({
    this.id,
    this.name,
    this.startDate,
    this.endDate,
  });

  factory EventHub.fromJson(Map<String, dynamic> json) {
    return EventHub(
      id: json['id'],
      name: json['name'],
      startDate: json['start_date'] ?? '',
      endDate: json['end_date'] ?? '',
    );
  }
}
