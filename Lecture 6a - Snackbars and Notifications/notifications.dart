
import 'dart:io';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart';

class Notifications{

  final channelId = "testNotif";
  final channelName = "Test Notification";
  final channelDescription = "Test Notification Description";

  //Configure plugin using platform specific details
  var _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  NotificationDetails? _platformChannelInfo;
  var _notificationID = 100;

  Future init() async{
    if(Platform.isIOS){
      _requestIOSPermission();
    }

    var initializationSettingsAndroid
    = AndroidInitializationSettings('mipmap/ic_launcher');

    var initializationSettingsIOS = DarwinInitializationSettings(
      onDidReceiveLocalNotification: (int id,
          String? title, String? body, String? payload){
        return null;
      },
    );

    var initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS
    );

    _flutterLocalNotificationsPlugin
        .initialize(initializationSettings,
    onDidReceiveNotificationResponse: onDidReceiveNotificationResponse,
    );

    var androidChannelInfo = AndroidNotificationDetails(channelId,
        channelName, channelDescription: channelDescription);

    var iosChannelInfo = DarwinNotificationDetails();

    _platformChannelInfo = NotificationDetails(
      android: androidChannelInfo,
      iOS: iosChannelInfo,
    );

  }

  void sendNotificationNow(String title, String body, String payload){
    print(_flutterLocalNotificationsPlugin.toString());
    _flutterLocalNotificationsPlugin.show(_notificationID++,
        title,
        body,
        _platformChannelInfo,
    payload: payload);
  }

  sendNotificationLater(String title,
      String body, String payload, TZDateTime when){
    return _flutterLocalNotificationsPlugin.zonedSchedule(
        _notificationID++,
        title,
        body,
        when,
        _platformChannelInfo!,
        uiLocalNotificationDateInterpretation:
        UILocalNotificationDateInterpretation.absoluteTime,
        androidAllowWhileIdle: true,
      payload: payload,
    );
  }

  Future<List<PendingNotificationRequest>>
  getPendingNotificationRequests() async{
    return _flutterLocalNotificationsPlugin.pendingNotificationRequests();
  }

  Future onDidReceiveNotificationResponse
      (NotificationResponse notificationResponse) async{
    if (notificationResponse != null){
      print("NotificationResponse::payload = "
          "${notificationResponse.payload}");
    }
  }

  _requestIOSPermission(){
    _flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation
    <IOSFlutterLocalNotificationsPlugin>()!.requestPermissions(
      sound: true,
      badge: true,
      alert: false,
    );
  }

}