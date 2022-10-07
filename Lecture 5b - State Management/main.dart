import 'package:flutter/material.dart';

import 'controller/add_friend.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'State Management',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'State Management Home Page'),
      routes: {
        '/addFriend' : (context) => AddFriendWidget(title: "Add Friend"),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);


  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        title: Text(widget.title),
      ),
      //body: FriendListWidget(),
      floatingActionButton: FloatingActionButton(
        onPressed: showAddFriendWidget,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Future<void> showAddFriendWidget() async{
    var friend = await Navigator.pushNamed(context, '/addFriend');
    print("New Friend: $friend");
  }

}
