import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AdminPollPage extends StatefulWidget {
  final String eventId;

  AdminPollPage({required this.eventId});

  @override
  _AdminPollPageState createState() => _AdminPollPageState();
}

class _AdminPollPageState extends State<AdminPollPage> {
  List<Poll> polls = [];

  @override
  void initState() {
    super.initState();
    // Fetch polls data based on event_id
    fetchData();
  }

  Future<void> fetchData() async {
    final response = await http.get(
      Uri.parse(
          'https://382e-2409-4073-2e9a-c499-5c74-813-7dba-3f1a.ngrok-free.app/poll/${widget.eventId}'),
    );

    if (response.statusCode == 200) {
      // Assume the response body is a Map
      Map<String, dynamic> responseBody = jsonDecode(response.body);

      setState(() {
        polls = responseBody.entries.map((entry) {
          Map<String, dynamic> pollData = entry.value;
          return Poll(
            questionId: pollData['questionId'] ?? '',
            question: pollData['question'] ?? '',
            options: (pollData['options'] as List<dynamic>)
                .map((optionData) => PollOption(
                      id: optionData['id'] ?? '',
                      value: optionData['value'] ?? '',
                    ))
                .toList(),
            correctAnswerId: pollData['correctAnswerId'] ?? '',
          );
        }).toList();
      });
    } else {
      // If the server did not return a 200 OK response,
      // throw an exception.
      throw Exception('Failed to load polls');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin Polls for Event ${widget.eventId}'),
      ),
      body: polls.isNotEmpty
          ? ListView.builder(
              itemCount: polls.length,
              itemBuilder: (context, index) {
                return AdminPollCard(poll: polls[index]);
              },
            )
          : Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}

class Poll {
  final String questionId;
  final String question;
  final List<PollOption> options;
  final String correctAnswerId;

  Poll({
    required this.questionId,
    required this.question,
    required this.options,
    required this.correctAnswerId,
  });
}

class PollOption {
  final String id;
  final String value;

  PollOption({required this.id, required this.value});
}

class AdminPollCard extends StatefulWidget {
  final Poll poll;

  AdminPollCard({required this.poll});

  @override
  _AdminPollCardState createState() => _AdminPollCardState();
}

class _AdminPollCardState extends State<AdminPollCard> {
  String selectedOption = ''; // State to keep track of the selected option

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(16),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.poll.question,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 12),
            Column(
              children: widget.poll.options.map((option) {
                return ListTile(
                  title: Text(option.value),
                  subtitle: Text('Option ID: ${option.id}'),
                  leading: Radio<String>(
                    value: option.id,
                    groupValue: selectedOption,
                    onChanged: (value) {
                      setState(() {
                        selectedOption = value!;
                      });
                    },
                  ),
                );
              }).toList(),
            ),
            SizedBox(height: 12),
            Text('Selected Option: $selectedOption'),
            SizedBox(height: 12),
            ElevatedButton(
              onPressed: () {
                if (selectedOption.isNotEmpty) {
                  // Option selected, proceed to set correct answer
                  setCorrectAnswer(widget.poll.questionId, selectedOption);
                } else {
                  // No option selected, show a message or take appropriate action
                  print(
                      'Please select an option before setting correct answer');
                }
              },
              child: Text('Set Correct Answer'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> setCorrectAnswer(
      String questionId, String correctAnswerId) async {
    // Replace this with your actual API endpoint for setting correct answers
    final response = await http.post(
      Uri.parse(
          'https://382e-2409-4073-2e9a-c499-5c74-813-7dba-3f1a.ngrok-free.app/result/add'),
      body: {
        'pollId': questionId,
        'optionId': correctAnswerId,
      },
    );

    if (response.statusCode == 200) {
      // Successfully set correct answer
      print('Correct answer set successfully');
    } else {
      // If the server did not return a 200 OK response,
      // handle the error accordingly.
      print('Failed to set correct answer');
    }
  }
}

class SetAnswersPage extends StatefulWidget {
  final Poll poll;

  SetAnswersPage({required this.poll});

  @override
  _SetAnswersPageState createState() => _SetAnswersPageState();
}

class _SetAnswersPageState extends State<SetAnswersPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Set Answers for ${widget.poll.question}'),
      ),
      body: Column(
        children: [
          Text('Set Answers for ${widget.poll.question}'),
          // Add UI elements for setting answers here
        ],
      ),
    );
  }
}
