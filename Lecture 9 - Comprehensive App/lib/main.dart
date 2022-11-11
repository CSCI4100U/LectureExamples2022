import 'package:flutter/material.dart';
import 'package:lec9/persons/person_list.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Chorganizer',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: PersonList(title: "Person List",),
      //home: const MyHomePage(title: 'Chorganizer Home Page'),
    );
  }
}
