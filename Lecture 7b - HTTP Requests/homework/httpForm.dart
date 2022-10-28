import 'package:flutter/material.dart';
import 'todo.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HttpForm extends StatefulWidget {
  const HttpForm({Key? key}) : super(key: key);

  @override
  State<HttpForm> createState() => _HttpFormState();
}

class _HttpFormState extends State<HttpForm> {
  final formKey = GlobalKey<FormState>();

  String? title;
  int? userId;
  bool? completed;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          TextFormField(
            style: const TextStyle(fontSize: 30),
            decoration: const InputDecoration(
                label: Text("userId",),
            ),
            onSaved: (value){
              print("Saving userId $value");
            },
          ),

          TextFormField(
            obscureText: true,
            style: const TextStyle(fontSize: 30),
            decoration: const InputDecoration(
              label: Text("title",),
            ),

            onChanged: (value){
              print("Saving title $value");
              title = value;
            },
          ),

          DropdownButtonFormField(
              style: const TextStyle(fontSize: 30,
                color: Colors.black,
              ),
              items: <String>["True", "False"]
                  .map<DropdownMenuItem<String>>(
                      (String value){
                    return DropdownMenuItem<String>(value: value,
                        child: Text(value));
                  }).toList(),

              onSaved: (value){
                print("Saving completed $value");

              },
              onChanged: (value){
                print("User chose $value from the dropdown");
                if (value == "True"){
                  completed = true;
                } else{
                  completed = false;
                }
              }
          ),

          ElevatedButton(
            onPressed: () async {
              print("Pressed the button!");
                formKey.currentState!.save();
                Todo todo = Todo(
                    title: title,
                    completed: completed,
                    userId: userId,
                );

              var response = await http.post(
                Uri.parse('https://jsonplaceholder.typicode.com/todos'),
                headers: <String,String> {
                  'Content-Type': 'application/json; charset=UTF-8'
                },
                body: jsonEncode(<String,dynamic> {
                  'title': title,
                  'userId': userId,
                  'completed': completed
                }),
              );



                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                      content: Text("Http Posted!",
                        style: TextStyle(fontSize: 30),
                      )
                  ),
                );
              Navigator.pop(context);
            },
            child: const Text("Post",
              style: TextStyle(fontSize: 30),
            ),
          ),
        ],
      ),
    );
  }
}
