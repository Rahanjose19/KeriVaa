import 'package:bettingapp/bettingscreen.dart';
import 'package:flutter/material.dart';
import 'package:supabase/supabase.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

final supabase = SupabaseClient('https://hihegglqydomcspwqoqs.supabase.co',
    'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImhpaGVnZ2xxeWRvbWNzcHdxb3FzIiwicm9sZSI6ImFub24iLCJpYXQiOjE2OTk5NzAwODEsImV4cCI6MjAxNTU0NjA4MX0.VrFRYWP_wfk3v1pDqTFX_PDZD1a2nBbVIalCKNvIciI');

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
