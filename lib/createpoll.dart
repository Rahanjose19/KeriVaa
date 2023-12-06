import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CreatePollPage extends StatefulWidget {
  final int eventId;

  CreatePollPage({required this.eventId});

  @override
  _CreatePollPageState createState() => _CreatePollPageState();
}

class _CreatePollPageState extends State<CreatePollPage> {
  TextEditingController questionController = TextEditingController();
  List<TextEditingController> optionControllers =
      List.generate(3, (index) => TextEditingController());

  void _createPoll() async {
    // Fetch the question and options from controllers
    String question = questionController.text;
    List<String> options =
        optionControllers.map((controller) => controller.text).toList();

    // Send data to the Express endpoint with the eventId
    await http.post(
      Uri.parse(
          'https://382e-2409-4073-2e9a-c499-5c74-813-7dba-3f1a.ngrok-free.app/poll/create'),
      body: {
        'eventId': widget.eventId.toString(),
        'question': question,
        'options': options.join(','),
      },
    );
    // Optionally, handle the response or navigate to another page
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Poll'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: questionController,
              decoration: InputDecoration(labelText: 'Question'),
            ),
            SizedBox(height: 20),
            Text('Options:'),
            for (int i = 0; i < 3; i++)
              TextField(
                controller: optionControllers[i],
                decoration: InputDecoration(labelText: 'Option ${i + 1}'),
              ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _createPoll,
              child: Text('Create Poll'),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: CreatePollPage(eventId: 1), // Replace with the actual eventId
  ));
}
