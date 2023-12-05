import 'package:flutter/material.dart';

class EnterEventCodePage extends StatefulWidget {
  @override
  _EnterEventCodePageState createState() => _EnterEventCodePageState();
}

class _EnterEventCodePageState extends State<EnterEventCodePage> {
  TextEditingController _codeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Enter Event Code'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _codeController,
              decoration: InputDecoration(
                labelText: 'Enter Code',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Handle the code submission logic here
                String enteredCode = _codeController.text;
                // You can add further logic to handle the entered code
                print('Entered Code: $enteredCode');
              },
              child: Text('Enter'),
            ),
          ],
        ),
      ),
    );
  }
}
