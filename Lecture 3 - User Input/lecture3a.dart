import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: const BasicLayout(title: 'Basic Layouts'),
    );
  }
}

class BasicLayout extends StatefulWidget {
  const BasicLayout({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<BasicLayout> createState() => _BasicLayoutState();
}

class _BasicLayoutState extends State<BasicLayout> {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: buildColumnWidget(),

    );
  }
}

Widget buildStackWidget(){
  return Stack(
    alignment: Alignment.center,
    children: [
      CircleAvatar(
        radius: 100,
        child: Text("MM", textScaleFactor: 7.0,),
      ),
      FlutterLogo(size: 250,),
      Container(
        decoration: BoxDecoration(
          color: Colors.grey
        ),
        child: Container(
          padding: EdgeInsets.all(50),
          child: Text("Michael",
            style: TextStyle(
              fontSize: 30
            ),
          ),
        ),
      ),
    ],
  );
}

Widget buildColumnWidget(){
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.end,
    children: [FlutterLogo(size: 200, style: FlutterLogoStyle.stacked,),
      FlutterLogo(size: 100, style: FlutterLogoStyle.horizontal,),
      buildStackWidget(),
    ],
  );
}

Widget buildRowWidget(){
  return Container(
    decoration: BoxDecoration(
      color: Colors.black,
    ),
    //padding: EdgeInsets.symmetric(horizontal: 30),
    // height: 400,
    //width: 400,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Container(
          width: 80,
          height: 300,
          color: Colors.red,
        ),
        Container(
          width: 80,
          height: 50,
          color: Colors.blue,
        ),
        Container(
          width: 80,
          height: 50,
          color: Colors.green,
        ),
        Container(
          width: 80,
          height: 50,
          color: Colors.amber,
        ),
      ],
    ),
  );
}