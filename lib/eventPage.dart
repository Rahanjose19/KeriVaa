import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class Event {
  final String eventId;
  final String name;
  final String venue;
  // final String time;
  final String date;
  final String hubName;
  // final String details;
  final String hubId;

  Event(
      {required this.eventId,
      required this.name,
      required this.venue,
      // required this.time,
      required this.date,
      required this.hubName,
      // required this.details,
      required this.hubId});

  factory Event.fromJson(Map<String, dynamic> json) {
    return Event(
      eventId: json['id'],
      name: json['name'],
      venue: json['venue'],
      // time: json['time'],
      date: json['date'],
      hubName: json['hub_name'],
      hubId: json['hub_id'],
      // details: json['details'],
    );
  }
}

class EventDetailsPage extends StatefulWidget {
  final String eventId;

  const EventDetailsPage({super.key, required this.eventId});

  @override
  _EventDetailsPageState createState() => _EventDetailsPageState();
}

class _EventDetailsPageState extends State<EventDetailsPage> {
  late Event _event;
  bool _isAdmin = false;

  @override
  void initState() {
    super.initState();
    fetchData(); // Fetch event details when the page is created
  }

  Future<void> fetchData() async {
    final response = await http.get(Uri.parse(
        'https://382e-2409-4073-2e9a-c499-5c74-813-7dba-3f1a.ngrok-free.app/event/${widget.eventId}'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      print(
          "\n\n${data} herererereeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee\n\n\n\n\n\n");
      setState(() {
        _event = Event.fromJson(data);
      });
    } else {
      throw Exception('Failed to load event details');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Event Details'),
      ),
      body: _event != null
          ? Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('venue: ${_event.venue}'),
                  // Text('Time: ${_event.time}'),
                  Text('Date: ${_event.date}'),
                  Text('Event Hub: ${_event.hubName}'),
                  // Text('Details: ${_event.details}'),
                  if (_isAdmin)
                    AddTeamsWidget(), // Display add teams widget for admin
                ],
              ),
            )
          : Center(child: CircularProgressIndicator()),
    );
  }
}

class AddTeamsWidget extends StatefulWidget {
  @override
  _AddTeamsWidgetState createState() => _AddTeamsWidgetState();
}

class _AddTeamsWidgetState extends State<AddTeamsWidget> {
  List<TextEditingController> participantControllers = [
    TextEditingController()
  ];
  TextEditingController teamNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 20),
        Text('Admin Section'),
        Text('Add Teams:'),
        TextFormField(
          controller: teamNameController,
          decoration: InputDecoration(labelText: 'Team Name'),
        ),
        Text('Participant Names:'),
        Column(
          children: List.generate(participantControllers.length, (index) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: participantControllers[index],
                      decoration: InputDecoration(
                          labelText: 'Participant ${index + 1}'),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.remove),
                    onPressed: () {
                      removeParticipant(index);
                    },
                  ),
                ],
              ),
            );
          }),
        ),
        ElevatedButton(
          onPressed: addParticipant,
          child: Text('Add Participant'),
        ),
      ],
    );
  }

  void addParticipant() {
    setState(() {
      participantControllers.add(TextEditingController());
    });
  }

  void removeParticipant(int index) {
    setState(() {
      participantControllers.removeAt(index);
    });
  }
}
