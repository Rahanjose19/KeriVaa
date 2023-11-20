import 'dart:convert';

import 'package:bettingapp/eventDetailsPage.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class EventHub extends StatefulWidget {
  const EventHub({Key? key}) : super(key: key);

  @override
  _EventHubState createState() => _EventHubState();
}

Future<Album> createAlbum(String text1, String text2, String text3) async {
  final result = await http.post(
    Uri.parse('https://4f22-103-163-113-106.ngrok-free.app/eventHub/add'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, String>{
      "name": text1,
      "start_date": text2,
      "end_date": text3,
    }),
  );

  if (result.statusCode == 200) {
    return Album.fromJson(jsonDecode(result.body));
  } else {
    throw Exception('Failed to create album');
  }
}

class Album {
  final String name;
  // final String date;
  final String hubId;
  final String id;

  const Album({
    required this.name,
    // required this.date,
    required this.hubId,
    required this.id,
  });

  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(
      name: json['name'],
      // date: json['date'],
      hubId: json['hub_id'],
      id: json['id'],
    );
  }
}

class _EventHubState extends State<EventHub> {
  TextEditingController _textFieldController1 = TextEditingController();
  TextEditingController _textFieldController2 = TextEditingController();
  TextEditingController _textFieldController3 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Event Hub Example'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _textFieldController1,
              decoration: InputDecoration(
                labelText: 'Enter event hub name',
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
                controller: _textFieldController2,
                decoration: InputDecoration(labelText: 'Enter start date')),
            SizedBox(height: 16.0),
            TextField(
                controller: _textFieldController3,
                decoration: InputDecoration(labelText: 'Enter end date')),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () async {
                // Access the text from the controllers
                String text1 = _textFieldController1.text;
                String text2 = _textFieldController2.text;
                String text3 = _textFieldController3.text;
                print("-----------------------------------yeeee");
                final result = await createAlbum(text1, text2, text3);
                print('API Response: ${result.id}');

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EventDetailsPage(
                        name: result.name, id: result.id, hubId: result.hubId),
                  ),
                );
// Do something with the text (e.g., print it)
              },
              child: Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: EventHub(),
  ));
}
