import 'package:bettingapp/bettingscreen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(BettingApp());
}

class BettingApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Betting App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: bettingscreen(),
    );
  }
}
