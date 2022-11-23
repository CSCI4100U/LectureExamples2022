import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'dart:io';
import 'dart:async';

Future<void> main() async{
  //Ensure plugin services are initialized
  //so you can make cameras available before running the app

  WidgetsFlutterBinding.ensureInitialized();

  //get a list of all cameras on the device
  final cameras = await availableCameras();

  runApp(MaterialApp(
      theme: ThemeData.dark(),
    home: TakePictureScreen(
      //pass the cameras list to the next widget
      cameras: cameras,
    ),
    )
  );
}