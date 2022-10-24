import 'package:flutter/material.dart';
import 'package:flutter_todo_list/screens/login_screen.dart';

import 'package:flutter_todo_list/screens/splash_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'To-Do List',
      home: SplashScreen(),
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
    );
  }
}
