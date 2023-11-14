import 'package:bettingapp/secondpage.dart';
import 'package:flutter/material.dart';

class bettingscreen extends StatefulWidget {
  const bettingscreen({super.key});

  @override
  State<bettingscreen> createState() => _bettingscreenState();
}

class _bettingscreenState extends State<bettingscreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Place Your Bets!',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SecondPage()),
                );
              },
              child: Text('Bet on Option 1'),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                // Add functionality for the second betting option
              },
              child: Text('Bet on Option 2'),
            ),
            // Add more betting options as needed
          ],
        ),
      ),
    );
  }
}
