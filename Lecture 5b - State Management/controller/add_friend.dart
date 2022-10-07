import 'package:flutter/material.dart';
import 'package:lec5b/model/friends.dart';

class AddFriendWidget extends StatefulWidget {
  AddFriendWidget({Key? key, this.title}) : super(key: key);

  String? title;

  @override
  State<AddFriendWidget> createState() => _AddFriendWidgetState();
}

class _AddFriendWidgetState extends State<AddFriendWidget> {
  var formKey = GlobalKey<FormState>();

  String? firstName;
  String? lastName;
  String? email;

  TextStyle style = TextStyle(fontSize: 30);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title!),
      ),
      body: Form(
        key: formKey,
        child: Column(
          children: [
            TextFormField(
              style: style,
              decoration: InputDecoration(
                labelText: "First Name",
              ),
              onChanged: (value){
                firstName = value;
              },
            ),

            TextFormField(
              style: style,
              decoration: InputDecoration(
                labelText: "Last Name",
              ),
              onChanged: (value){
                lastName = value;
              },
            ),

            TextFormField(
              style: style,
              decoration: InputDecoration(
                labelText: "Email",
                hintText: "someone@gmail.com"
              ),
              onChanged: (value){
                email = value;
              },
            ),
            ElevatedButton(
                onPressed: (){
                  Friend newFriend = Friend(
                    firstName: firstName,
                    lastName: lastName,
                    email: email,
                  );
                  Navigator.of(context).pop(newFriend);
                },
                child: Text("Save", style: style,)
            ),

          ],
        ),
      ),
    );
  }
}
