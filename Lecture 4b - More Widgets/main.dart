import 'package:flutter/material.dart';

import 'MoreWidgets.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'More Widgets',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MoreWidgetsPage(title: 'More Widgets Page'),
    );
  }
}
