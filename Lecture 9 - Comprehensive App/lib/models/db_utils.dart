import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as path;

class DBUtils{
  static Future init() async{
    return openDatabase(
      path.join(await getDatabasesPath(), 'chorganizer2.db'),
      onCreate: (db, version){
        db.execute('CREATE TABLE people(id INTEGER PRIMARY KEY, name TEXT)');
        db.execute('CREATE TABLE chores(id INTEGER PRIMARY KEY, name TEXT, assignedTo TEXT, icon TEXT, repeat TEXT, date TEXT NULL, time TEXT NULL, sunday INTEGER, monday INTEGER, tuesday INTEGER, wednesday INTEGER, thursday INTEGER, friday INTEGER, saturday INTEGER)');
      },
      version: 1,
    );
  }
}