import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'todo.dart';

class TodoList extends StatefulWidget {
  TodoList({Key? key, this.title}) : super(key: key);

  String? title;

  @override
  State<TodoList> createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {

  List<Todo> _todos = [];

  @override
  void initState(){
    super.initState();
    loadTodos();

  }

  Future loadTodos() async{
    var response = await
        http.get(Uri.parse('https://jsonplaceholder.typicode.com/todos'));
    if (response.statusCode == 200){
      _todos = [];
      List todo_items = jsonDecode(response.body);
      for (var item in todo_items){
        _todos.add(Todo.fromMap(item)
        );
        print(item);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
