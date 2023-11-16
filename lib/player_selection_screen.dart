import 'package:flutter/material.dart';
import 'player.dart';
import 'team_creation_screen.dart';

class PlayerSelectionScreen extends StatefulWidget {
  @override
  _PlayerSelectionScreenState createState() => _PlayerSelectionScreenState();
}

class _PlayerSelectionScreenState extends State<PlayerSelectionScreen> {
  List<Player> players = [
    Player(name: 'Player 1', position: 'Forward'),
    Player(name: 'Player 2', position: 'Midfielder'),
    Player(name: 'Player 3', position: 'Defender'),
    Player(name: 'Player 4', position: 'Goalkeeper'),
  ];

  List<Player> selectedPlayers = [];

  void _navigateToTeamCreation() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            TeamCreationScreen(selectedPlayers: selectedPlayers),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Player Selection'),
      ),
      body: ListView.builder(
        itemCount: players.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(players[index].name),
            subtitle: Text(players[index].position),
            trailing: IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                setState(() {
                  selectedPlayers.add(players[index]);
                });
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          TeamCreationScreen(
            selectedPlayers: [],
          );
        },
        child: Icon(Icons.arrow_forward),
      ),
    );
  }
}
