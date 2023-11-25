import 'dart:convert';
import 'package:bettingapp/event.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class UserEventListPage extends StatefulWidget {
  const UserEventListPage({Key? key}) : super(key: key);

  @override
  _EventListPageState createState() => _EventListPageState();
}

class _EventListPageState extends State<UserEventListPage> {
  List<EventHub> eventHubs = [];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    final response = await http
        .get(Uri.parse('https://4f3f-111-92-126-211.ngrok-free.app/eventhub'));

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

//we need to a local storage to store the eventHubId that the user hasn't joined yet

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
            trailing: ElevatedButton(
              onPressed: () {
                // Navigate to the AddEventPage with the corresponding eventHubId
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
          );
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
