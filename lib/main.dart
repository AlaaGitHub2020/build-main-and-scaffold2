import 'package:covid19information/screens/main_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Student Database With GUI using SQLite',
      home: MainPage(),
      theme: ThemeData(
        backgroundColor: Colors.lightGreen,
        primarySwatch: Colors.green,
      ),
    );
  }
}
