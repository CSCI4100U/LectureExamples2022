import 'package:flutter/material.dart';

import 'TodoList.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HTTP Demo',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: TodoList(title: 'HTTP Home Page'),
    );
  }
}