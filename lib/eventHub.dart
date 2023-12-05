import 'dart:convert';
import 'package:bettingapp/EventAddPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class EventHubPage extends StatefulWidget {
  const EventHubPage({Key? key}) : super(key: key);

  @override
  _EventHubState createState() => _EventHubState();
}

Future<Album> createAlbum(String text1, String text2, String text3) async {
//print text1 text2 text3 in one line
  print(text1 + text2 + text3);

  final result = await http.post(
    Uri.parse(
        'https://ef86-2406-8800-9014-5b64-f56d-8079-b4ee-9ccc.ngrok-free.app/eventHub/add'),
    headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
    body: jsonEncode(<String, dynamic>{
      "name": text1,
      "start_date": '2021-09-01',
      "end_date": '2021-09-01',
    }),
  );

  // Log the full response for analysis
  print('API Response Status Code: ${result.statusCode}');
  print('API Response Headers: ${result.headers}');
  print('API Response Body: ${result.body}');

  if (result.statusCode == 200) {
    // Check if the response body is not empty
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
  // final String date;
  final String id;

  const Album({
    required this.name,
    // required this.date,
    required this.id,
  });

  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(
      name: json['name'],
      // date: json['date'],
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

                // ignore: use_build_context_synchronously
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        EventAddPage(name: result.name, id: result.id),
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
    home: EventHubPage(),
  ));
}
