import 'package:bettingapp/dashboard.dart';
import 'package:bettingapp/secondpage.dart';
import 'package:bettingapp/player_selection_screen.dart'; // Import the necessary file
import 'package:bettingapp/signin.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class bettingscreen extends StatefulWidget {
  const bettingscreen({Key? key}) : super(key: key);

  @override
  State<bettingscreen> createState() => _bettingscreenState();
}

class _bettingscreenState extends State<bettingscreen> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset('assets/video.mp4')
      ..initialize().then((_) {
        _controller.play();
        _controller.setLooping(true);
        setState(() {});
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Add a widget for the video
          _controller.value.isInitialized
              ? AspectRatio(
                  aspectRatio: _controller.value.aspectRatio,
                  child: VideoPlayer(_controller),
                )
              : Container(),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Place Your Bets!',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white, // Set the color to white
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SignInPage()),
                    );
                  },
                  child: Text('User'),
                ),
                SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => DashboardScreen()),
                    );
                  },
                  child: Text('Admin 1'),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => PlayerSelectionScreen()),
                    ); // Add missing closing parenthesis here
                  },
                  child: Text('Player Creation'),
                ),
                // Add more betting options as needed
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
