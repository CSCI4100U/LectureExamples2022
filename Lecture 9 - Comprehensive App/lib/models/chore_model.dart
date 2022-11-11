import 'dart:async';
import 'package:sqflite/sqflite.dart';
import 'package:lec9/utils.dart';
import 'db_utils.dart';
import 'chore.dart';

class ChoreModel{
  Future insertChore(Database? db, Chore? chore) async{
    if (db == null) db = await DBUtils.init();

    await db!.insert('chores', chore!.toMap(),conflictAlgorithm:
    ConflictAlgorithm.replace);
  }

  Future updateChore(Database? db, Chore? chore) async{
    if (db == null) db = await DBUtils.init();

    await db!.update('chores', chore!.toMap(),
      where: 'id = ?',
      whereArgs: [chore.id]
    );
  }

  Future deleteChore(Database? db, int id) async{
    if (db == null) db = await DBUtils.init();

    await db!.delete('chores',
    where: 'id = ?',
    whereArgs: [id]
    );
  }

  Future getAllChores(Database? db) async{
    if (db == null) db = await DBUtils.init();
    final List maps = await db!.query('chores');

    //TYPING REQUIRED
    List<Chore> persons = [];
    for (int i = 0; i < maps.length; i++){
      persons.add(Chore.fromMap(maps[i]));
    }
    return persons;
  }

  Future getChoresByDate(Database? db, DateTime date) async{
    if (db == null) db = await DBUtils.init();
    String weekday = getWeekDayNameByIndex(date.weekday);
    final List maps = await db!.query(
      'chores',
      columns: [
        'id', 'name', 'assignedTo', 'icon', 'repeat', 'date', 'time',
        'sunday', 'monday', 'tuesday', 'wednesday', 'thursday', 'friday',
        'saturday'
      ],
      where: "repeat = 'Daily' OR (repeat = 'None' AND date = ?) "
          "OR (repeat = Weekly AND $weekday = 1)",
      whereArgs: [toDateString(date.year, date.month, date.day)],
      orderBy: 'time',
    );

    //TYPING REQUIRED
    List<Chore> chores = [];
    for (int i = 0; i < maps.length; i++){
      chores.add(Chore.fromMap(maps[i]));
    }
    return chores;

  }

}