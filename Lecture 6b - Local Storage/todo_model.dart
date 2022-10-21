import 'db_utils.dart';
import 'dart:async';
import 'package:lec6b/todo.dart';
import 'package:sqflite/sqflite.dart';

class TodoModel{
  Future<int> insertTodo(Todo todo) async{
    //This needs to be present in any queries, updates, etc.
    //you do with your database
    final db = await DBUtils.init();
    return db.insert(
      'todo_items',
      todo.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future getAllTodos() async{
    //This needs to be present in any queries, updates, etc.
    //you do with your database
    final db = await DBUtils.init();
    final List maps = await db.query('todo_items');
    List result = [];
    for (int i = 0; i < maps.length; i++){
      result.add(
        Todo.fromMap(maps[i])
      );
    }
    return result;
  }

}