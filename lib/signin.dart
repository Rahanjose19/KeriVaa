import 'dart:convert';
import 'package:bettingapp/signup.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:bettingapp/userdashboard.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login App',
      home: SignInPage(),
    );
  }
}

class SignInPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<SignInPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Future<void> _login() async {
    final String apiUrl =
        'https://382e-2409-4073-2e9a-c499-5c74-813-7dba-3f1a.ngrok-free.app/signin';

    final response = await http.post(
      Uri.parse(apiUrl),
      body: {
        'username': _usernameController.text,
        'password': _passwordController.text,
      },
    );

    if (response.statusCode == 200) {
      // Login successful, handle the response as needed
      print('Login successful');
      print('Response body: ${response.body}');

      //add line to get userid  from response.body
      var responseBody = jsonDecode(response.body);
      var userId = int.parse(responseBody['id']);
      var username = responseBody['username'];

      // Navigate to the user dashboard page
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                UserDashboardPage(username: username, userId: userId)),
      );
    } else {
      // Login failed, handle the error response
      print('Login failed. Status code: ${response.statusCode}');
      print('Response body: ${response.body}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _usernameController,
              decoration: InputDecoration(labelText: 'Username'),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: _passwordController,
              obscureText: true,
              decoration: InputDecoration(labelText: 'Password'),
            ),
            SizedBox(height: 24.0),
            ElevatedButton(
              onPressed: _login,
              child: Text('Login'),
            ),
            InkWell(
              onTap: () {
                // Navigate to the signup page when the link is pressed
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SignUpPage()),
                );
              },
              child: Text(
                'Don\'t have an account? Sign up here!',
                style: TextStyle(
                  color: Colors.blue,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
