import 'package:flutter/material.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Snackbars and Notifications',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Notification Home Page'),
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
  final _formKey = GlobalKey<FormState>();

  //final _notifications = Notifications();

  //Title: name of the notification (topmost part)
  //Body: full text of the notification
  //Payload: returned to your app upon someone tapping
  String? title;
  String? body;
  String? payload;

  @override
  Widget build(BuildContext context) {
    tz.initializeTimeZones();

    return Scaffold(
      appBar: AppBar(
       title: Text(widget.title),
        actions: [
          IconButton(
              onPressed: _notificationNow,
              icon: Icon(Icons.notifications),
          ),

          IconButton(
            onPressed: _notificationLater,
            icon: Icon(Icons.timer_3),
          ),

          IconButton(
            onPressed: _showPendingNotifications,
            icon: Icon(Icons.list),
          ),
        ],
      ),
    );
  }

  void _notificationNow() async{

  }

  Future _notificationLater() async{

  }

  Future _showPendingNotifications() async{

  }

}
