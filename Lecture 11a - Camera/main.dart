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

class TakePictureScreen extends StatefulWidget {
  const TakePictureScreen({Key? key, required this.cameras}) : super(key: key);

  final List<CameraDescription> cameras;

  @override
  State<TakePictureScreen> createState() => _TakePictureScreenState();
}

class _TakePictureScreenState extends State<TakePictureScreen> {

  late CameraController _controller;
  late Future<void> _initializeControllerFuture;
  int cameraNumber = 0;

  @override
  void initState(){
    super.initState();

    //To display the output from the camera,
    //create a camera controller
    _controller = CameraController(
        //a specific camera from the list of available ones
        widget.cameras[cameraNumber],
        ResolutionPreset.medium,
    );

    //initialize the controller, this returns a future
    _initializeControllerFuture = _controller.initialize();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Take a Picture"),
      ),
      //use a futurebuilder so that the screen doesnt show anything
      //until the camera is initialized
      body: FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot){
          if (snapshot.connectionState == ConnectionState.done){
            //if the future is complete, show the preview
            return CameraPreview(_controller);
          } else{
            return const Center(child: CircularProgressIndicator(),);
          }
        },
      ),
    );
  }
}
