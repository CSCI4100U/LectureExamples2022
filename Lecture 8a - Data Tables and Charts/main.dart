import 'package:flutter/material.dart';
import 'package:lecture8a/paginated_grade_table.dart';

import 'grade_table.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Data Tables and Charts Demo',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: PaginatedGradeTable(),
    );
  }
}