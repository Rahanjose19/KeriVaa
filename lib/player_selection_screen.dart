import 'package:flutter/material.dart';
import 'player.dart';
import 'team_creation_screen.dart';

class PlayerSelectionScreen extends StatefulWidget {
  @override
  _PlayerSelectionScreenState createState() => _PlayerSelectionScreenState();
}

class _PlayerSelectionScreenState extends State<PlayerSelectionScreen> {
  List<Player> players = [];

  List<Player> selectedPlayers = [];

  TextEditingController playerNameController = TextEditingController();
  TextEditingController positionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Player Selection'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: players.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(players[index].name),
                  subtitle: Text(players[index].position),
                  trailing: IconButton(
                    icon: Icon(Icons.add),
                    onPressed: () {
                      setState(() {
                        players[index].isSelected = true;
                        selectedPlayers.add(players[index]);
                      });
                    },
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                TextField(
                  controller: playerNameController,
                  decoration: InputDecoration(
                    labelText: 'Enter Player Name',
                  ),
                ),
                TextField(
                  controller: positionController,
                  decoration: InputDecoration(
                    labelText: 'Enter Custom Position',
                  ),
                ),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: () {
              _addPlayer();
            },
            child: Text('Add Player'),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _navigateToTeamCreation();
        },
        child: Icon(Icons.arrow_forward),
      ),
    );
  }

  void _addPlayer() {
    String playerName = playerNameController.text;
    String position = positionController.text;

    if (playerName.isNotEmpty) {
      setState(() {
        players.add(Player(
          name: playerName,
          position: position.isNotEmpty ? position : 'Custom Position',
        ));
        playerNameController.clear();
        positionController.clear();
      });
    }
  }

  void _navigateToTeamCreation() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>
            TeamCreationScreen(selectedPlayers: selectedPlayers),
      ),
    );
  }
}
