import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'db_utils.dart';
import 'person.dart';

class PersonModel{
  Future insertPerson(Database? db, Person? person) async{
    if (db == null) db = await DBUtils.init();
    print("Inserting Person $person");
    await db!.insert('people', person!.toMap(),conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future updatePerson(Database db, Person person) async {
    if (db == null) db = await DBUtils.init();
    await db.update('people', person.toMap(), where: 'id = ?', whereArgs: [person.id]);
  }

  Future deletePerson(Database? db, int id)async {
    if (db == null) db = await DBUtils.init();
    await db!.delete('people', where: 'id = ?', whereArgs: [id]);
  }

  Future getAllPeople(Database? db) async {
    if (db == null) db = await DBUtils.init();
    final List maps = await db!.query('people');
    //TYPING BELOW REQUIRED
    List<Person> people = [];
    for (int i =0;i<maps.length;i++){
      people.add(Person.fromMap(maps[i]));
    }
    return people;
  }

  //REQUIRED TYPING!!
  Future<List<String>> getAllPeopleNames(Database? db) async {
    if (db == null) db = await DBUtils.init();
    final List maps = await db!.query('people');
    List<String> peopleNames = [];
    for (int i =0;i<maps.length;i++){
      peopleNames.add(maps[i]['name']);
    }
    return peopleNames;
  }
}