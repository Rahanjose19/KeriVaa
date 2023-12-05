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
        'https://d86f-2409-40f3-109f-d64f-68f6-4a8a-4302-3cdb.ngrok-free.app/eventhub'));

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
              title: Text(eventHubs[index].name ?? ''),
              subtitle: Text('Start Date: ${eventHubs[index].startDate}'),
              trailing: Row(mainAxisSize: MainAxisSize.min, children: [
                ElevatedButton(
                  onPressed: () {
                    // Redirect to the AddEventPage with the corresponding eventHubId
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            AddEventPage(eventHubId: eventHubs[index].id ?? ''),
                      ),
                    );
                  },
                  child: Text('Add Event'),
                ),
                SizedBox(width: 8), // Add some space between buttons
                ElevatedButton(
                  onPressed: () {
                    // Redirect to the EventListPage passing the hub_id
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            ListEventsPage(hubId: eventHubs[index].id ?? ''),
                      ),
                    );
                  },
                  child: Text('View Events'),
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
