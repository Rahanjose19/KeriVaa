import 'package:flutter/material.dart';
import 'player.dart';

class TeamCreationScreen extends StatelessWidget {
  final List<Player> selectedPlayers;

  TeamCreationScreen({required this.selectedPlayers});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Team Creation'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Selected Players:'),
          for (var player in selectedPlayers)
            ListTile(
              title: Text(player.name),
              subtitle: Text(player.position),
            ),
          ElevatedButton(
            onPressed: () {
              // Implement team creation logic here
              _showDialog(context, 'Team Created');
            },
            child: Text('Create Team'),
          ),
        ],
      ),
    );
  }

  void _showDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Message'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
