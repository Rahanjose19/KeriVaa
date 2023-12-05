import 'package:flutter/material.dart';

class UserEventListPage extends StatelessWidget {
  final List<String> userEvents;

  UserEventListPage(this.userEvents);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Event List'),
      ),
      body: ListView.builder(
        itemCount: userEvents.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(userEvents[index]),
          );
        },
      ),
    );
  }
}
