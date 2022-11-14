import 'dart:async';
import 'package:sqflite/sqflite.dart';
import '../utils.dart';
import 'db_utils.dart';
import 'chore.dart';

class ChoreModel{
  Future insertChore(Database? db, Chore? chore) async{
    if (db == null) db = await DBUtils.init();

    await db!.insert('chores', chore!.toMap(),conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future updateChore(Database db, Chore? chore) async {
    if (db == null) db = await DBUtils.init();
    await db.update('chores', chore!.toMap(), where: 'id = ?', whereArgs: [chore.id]);
  }

  Future deleteChore(Database? db, int id)async {
    if (db == null) db = await DBUtils.init();
    await db!.delete('chores', where: 'id = ?', whereArgs: [id]);
  }

  Future getAllChores(Database? db) async {
    if (db == null) db = await DBUtils.init();
    final List maps = await db!.query('chores');
    //TYPING BELOW REQUIRED
    List<Chore> people = [];
    for (int i =0;i<maps.length;i++){
      people.add(Chore.fromMap(maps[i]));
    }
    return people;
  }

  Future getChoresByDate(Database? db, DateTime date) async {
    String weekday = getWeekDayNameByIndex(date.weekday);
    if (db == null) db = await DBUtils.init();
    final List maps = await db!.query('chores',
      columns: ['id', 'name','assignedTo','icon','repeat','date','time','sunday','monday','tuesday','wednesday','thursday','friday','saturday'],
      where: "repeat = 'Daily' OR (repeat = 'None' AND date = ?) OR (repeat = 'Weekly' AND $weekday = 1)",
      whereArgs: [toDateString(date.year, date.month, date.day)],
      orderBy: 'time',
    );
    //TYPING BELOW REQUIRED
    List<Chore> chores = [];
    for (int i =0;i<maps.length;i++){
      chores.add(Chore.fromMap(maps[i]));
    }
    return chores;
  }

}