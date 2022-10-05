import 'package:flutter/material.dart';
import 'package:lec5a/schedule_event.dart';

import 'CustomDialog.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dialogs and Navigation',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Dialogs and Navigation Home Page'),
      routes: {
        '/scheduleEvent' : (context){
          return ScheduleEventPage(title: 'Schedule Event');
        }
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

  TextStyle style = TextStyle(fontSize: 30);
  bool vegan = false;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
         title: Text(widget.title),
      ),
      body: Center(

        child: Column(

          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              padding: EdgeInsets.symmetric(horizontal: 25, vertical: 15),
              child: ElevatedButton(
                onPressed: (){
                  showAlert(context);
                },
                child: Text("Alert!", style: style),
              ),
            ),

            Container(
              padding: EdgeInsets.symmetric(horizontal: 25, vertical: 15),
              child: ElevatedButton(
                onPressed: (){
                  showChoice(context).then((value) {
                    setState(() {
                      vegan = value;
                    });
                    }
                  );
                },
                child: Text(vegan ? "Vegan" : "Not Vegan", style: style),
              ),
            ),

            Container(
              padding: EdgeInsets.symmetric(horizontal: 25, vertical: 15),
              child: ElevatedButton(
                onPressed: (){
                  showAbout(context);
                },
                child: Text("About", style: style),
              ),
            ),

            Container(
              padding: EdgeInsets.symmetric(horizontal: 25, vertical: 15),
              child: ElevatedButton(
                onPressed: (){
                  showCustom(context);
                },
                child: Text("Custom", style: style),
              ),
            ),


          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showEventScheduler,
        tooltip: 'Schedule Event',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Future<void> _showEventScheduler() async{
    var event = await Navigator.pushNamed(context, '/scheduleEvent');
    print("New Event Created: $event");
  }

  showAlert(BuildContext context){
    showDialog(context: context,
        barrierDismissible: false,
        builder: (context){
          return AlertDialog(
            title: Text("Danger Will Robinson"),
            content: Text("Spooky Scary Skeletons"),
            actions: [
              TextButton(
                  onPressed: (){
                    Navigator.of(context).pop();
                  },
                  child: Text("I understand")
              ),
            ],
          );
        }
    );
  }

  showAbout(context){
    showAboutDialog(context: context,
    applicationName: "Dialogs and Navigation",
      applicationVersion: "2.0.1",
      children: [
        Text("Dialogs and Navigation right here!"),
        Text("Copyright 2022 Michael Miljanovic"),
      ]
    );
  }

  Future showChoice(BuildContext context) async {
    var veganRequired = await showDialog(
        context: context,
        builder: (context){
          return SimpleDialog(
            title: Text("Vegan?"),
            children: [
              SimpleDialogOption(
                child: Text("Yes, vegan"),
                onPressed: (){
                  Navigator.of(context).pop(true);
                },
              ),

              SimpleDialogOption(
                child: Text("Not vegan"),
                onPressed: (){
                  Navigator.of(context).pop(false);
                },
              ),
            ],
          );
        }
    );

    print("Choice Dialog Result: $veganRequired");
    return veganRequired;

  }

  showCustom(context){
    showDialog(context: context,
        builder: (context){
          return CustomDialog();
        }
    );
  }

}
