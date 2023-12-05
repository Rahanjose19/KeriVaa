import 'package:bettingapp/userdashboard.dart';
import 'package:bettingapp/signup.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

//user object

class User {
  final int id;
  final String name;

  User({required this.id, required this.name});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(id: json['id'], name: json['name']);
  }
}

//save user info

class UserInfoStorage {
  static const String keyUsername = 'username';
  static const String keyUserId = 'userId';

  Future<void> saveUserInfo(String username, int userId) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(keyUsername, username);
    prefs.setInt(keyUserId, userId);
  }

  Future<Map<String, dynamic>> getUserInfo() async {
    final prefs = await SharedPreferences.getInstance();
    final String? username = prefs.getString(keyUsername);
    final int? userId = prefs.getInt(keyUserId);

    return {'username': username, 'userId': userId};
  }
}

class UserRepository {
  Future<User> authenticate(String username, String password) async {
    // Replace the URL with your actual authentication endpoint
    final response = await http.post(
      Uri.parse(
          'https://d86f-2409-40f3-109f-d64f-68f6-4a8a-4302-3cdb.ngrok-free.app/authenticate'),
      body: {'username': username, 'password': password},
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      return User.fromJson(data);
    } else {
      throw Exception('Failed to authenticate user');
    }
  }
}

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SignInPage(),
    );
  }
}

class SignInPage extends StatefulWidget {
  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final UserInfoStorage _userInfoStorage = UserInfoStorage();
  final UserRepository _userRepository = UserRepository();

  void _signIn() async {
    final String username = _usernameController.text;
    final String password = _passwordController.text;

    try {
      final User user = await _userRepository.authenticate(username, password);

      // Save user information to SharedPreferences
      await _userInfoStorage.saveUserInfo(user.name, user.id);
      print('User information saved.');

      // For now, just print the user information
      //final storedUser = await _userInfoStorage.getUserInfo();
      // if (storedUser != null) {
      //   print('Stored User ID: ${storedUser.userId}');
      //   print('Stored User Name: ${storedUser.username}');
      // }

      Navigator.push(context,
          MaterialPageRoute(builder: (context) => UserDashboardPage()));
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign In'),
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
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            SizedBox(height: 32.0),
            ElevatedButton(
              onPressed: _signIn,
              child: Text('Sign In'),
            ),
            SizedBox(height: 32.0),
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
