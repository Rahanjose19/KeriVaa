import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:bettingapp/EventAddPage.dart';

class EventHubPage extends StatefulWidget {
  const EventHubPage({Key? key}) : super(key: key);

  @override
  _EventHubState createState() => _EventHubState();
}

Future<Album> createAlbum(String text1, String text2, String text3) async {
  print(text1 + text2 + text3);

  final result = await http.post(
    Uri.parse('https://382e-2409-4073-2e9a-c499-5c74-813-7dba-3f1a.ngrok-free.app/eventHub/add'), // Add your API URL here
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, dynamic>{
      "name": text1,
      "start_date": '2021-09-01',
      "end_date": '2021-09-01',
    }),
  );

  print('API Response Status Code: ${result.statusCode}');
  print('API Response Headers: ${result.headers}');
  print('API Response Body: ${result.body}');

  if (result.statusCode == 200) {
    if (result.body.isNotEmpty) {
      return Album.fromJson(jsonDecode(result.body));
    } else {
      throw Exception('Empty response from the API');
    }
  } else {
    throw Exception(
        'Failed to create album. Status code: ${result.statusCode}');
  }
}

class Album {
  final String name;
  final String id;

  const Album({
    required this.name,
    required this.id,
  });

  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(
      name: json['name'],
      id: json['id'],
    );
  }
}

class _EventHubState extends State<EventHubPage> {
  TextEditingController _textFieldController1 = TextEditingController();
  TextEditingController _textFieldController2 = TextEditingController();
  TextEditingController _textFieldController3 = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Event Hub Example'),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.blue, Colors.indigo],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              TextField(
                controller: _textFieldController1,
                decoration: InputDecoration(
                  labelText: 'Enter event hub name',
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16.0),
              TextField(
                controller: _textFieldController2,
                decoration: InputDecoration(
                  labelText: 'Enter start date',
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16.0),
              TextField(
                controller: _textFieldController3,
                decoration: InputDecoration(
                  labelText: 'Enter end date',
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () async {
                  String text1 = _textFieldController1.text;
                  String text2 = _textFieldController2.text;
                  String text3 = _textFieldController3.text;

                  final result = await createAlbum(text1, text2, text3);

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          EventAddPage(name: result.name, id: result.id),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.green, // Set your desired primary color
                ),
                child: Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: EventHubPage(),
  ));
}
