import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'db_utils.dart';
import 'person.dart';

class PersonModel{
  Future insertPerson(Database? db, Person? person) async{
    if (db == null) db = await DBUtils.init();
    print("Inserting Person $person");

    //returns id integer of the person
    await db!.insert('people',
        person!.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future updatePerson(Database? db, Person? person) async{
    if (db == null) db = await DBUtils.init();
    print("Updating Person $person");

    //returns id integer of the person
    await db!.update('people',
        person!.toMap(),
        where: 'id = ?',
        whereArgs: [person.id]);
  }

  Future deletePerson(Database? db, int id) async{
    if (db == null) db = await DBUtils.init();
    print("Deleting Person id $id");

    await db!.delete('people',
        where: 'id = ?',
        whereArgs: [id]);
  }

  Future getAllPersons (Database? db) async{
    if (db == null) db = await DBUtils.init();
    print("Getting all people");

    final List maps = await db!.query('people');
    //TYPING BELOW REQUIRED!!
    List<Person> persons = [];
    for (int i = 0; i < maps.length; i++){
      persons.add(Person.fromMap(maps[i]));
    }
    return persons;
  }

  Future getAllPersonNames (Database? db) async{
    if (db == null) db = await DBUtils.init();
    print("Getting all people");

    final List maps = await db!.query('people');
    //TYPING BELOW REQUIRED!!
    List<String> personNames = [];
    for (int i = 0; i < maps.length; i++){
      personNames.add(maps[i]['name']);
    }
    return personNames;
  }
}