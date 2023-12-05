import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class SignUpPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign Up'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SignUpForm(),
      ),
    );
  }
}

class SignUpForm extends StatefulWidget {
  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  Future<void> _signUp() async {
    //paste signin apiurl here

    print(_usernameController.text + _passwordController.text);
    final String apiUrl =
        'https://d86f-2409-40f3-109f-d64f-68f6-4a8a-4302-3cdb.ngrok-free.app/user/signup';

    final response = await http.post(
      Uri.parse(apiUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'username': _usernameController.text,
        'password': _passwordController.text,
      }),
    );

    if (response.statusCode == 200) {
      Navigator.pop(context);
    } else {
      // Handle error
      print('Failed to sign in. Status code: ${response.statusCode}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          // Username TextField
          TextFormField(
            controller: _usernameController,
            decoration: InputDecoration(labelText: 'Username'),
          ),
          SizedBox(height: 16.0),

          // Password TextField
          TextFormField(
            controller: _passwordController,
            decoration: InputDecoration(labelText: 'Password'),
            obscureText: true,
          ),
          SizedBox(height: 16.0),

          // Add a clickable area for the back link

          SizedBox(height: 32.0),
          ElevatedButton(
            onPressed: _signUp,
            child: Text('Sign In'),
          ),
          SizedBox(height: 16.0),

          // Add a clickable area for the back link
          InkWell(
            onTap: () {
              // Navigate back to the sign-in page when the link is pressed
              Navigator.pop(context);
            },
            child: Text(
              'Already have an account? Sign in here!',
              style: TextStyle(
                color: Colors.blue,
                decoration: TextDecoration.underline,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
