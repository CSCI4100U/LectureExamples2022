import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:lec7bdemo/httpForm.dart';
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
      setState(() {
        _todos = [];
        List todo_items = jsonDecode(response.body);
        for (var item in todo_items){
          _todos.add(Todo.fromMap(item)
          );
          //print(item);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title!),
        actions: [
          IconButton(
          onPressed: (){
            List<Todo> newTodos = [];
            for (var todo in _todos){
              if (!todo.completed!){
                newTodos.add(todo);
              } else{
                http.delete(
                    Uri.parse(
                'https://jsonplaceholder.typicode.com/todos/${todo.id}'
                    )
                );
              }
              setState(() {
                _todos = newTodos;
              });
            }
          },
          icon: Icon(Icons.delete)
          ),
        ],
      ),
      body: _createTodosList(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: httppush,
      ),
    );
  }

  Future httppush() async{
    // var response = await http.post(
    //     Uri.parse('https://jsonplaceholder.typicode.com/todos'),
    //   headers: <String,String> {
    //       'Content-Type': 'application/json; charset=UTF-8'
    //   },
    //   body: jsonEncode(<String,dynamic> {
    //     'title': 'sample text',
    //     'userId': 420,
    //     'completed': true
    //   }),
    // );
    // setState(() {
    //   _todos.add(Todo.fromMap(jsonDecode(response.body)));
    // });

    Navigator.push(context,
        MaterialPageRoute(builder: (context){
          return HttpForm();
        })
    );

  }

  Widget _createTodosList(){
    if (_todos.length == 0){
      return CircularProgressIndicator();
    }
    return ListView.builder(
        itemCount: _todos.length,
        itemBuilder: (BuildContext context, int index){
          return ListTile(
            title: Text(_todos[index].title!),
            subtitle: Text(_todos[index].userId.toString()),
            leading: Checkbox(
              value: _todos[index].completed,
              onChanged: (value){
                setState(() {
                  _todos[index].completed = value;
                });
              },
            ),
          );
        }
    );
  }
}
