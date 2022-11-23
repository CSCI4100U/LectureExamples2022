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
  void dispose(){
    //dispose of the controller when one disposes the widget
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Take a Picture"),
        actions: [
          IconButton(
              onPressed: (){
                //'hacky' way to toggle between exactly 2 cameras
                cameraNumber = 1-cameraNumber;
                onNewCameraSelected(widget.cameras[cameraNumber]);
              },
              icon: Icon(Icons.camera)
          ),
        ],
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
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.camera_alt),
        onPressed: () async {
          //try / catch taking the picture
          try{
            //check that the camera is initialized
            await _initializeControllerFuture;

            //take the picture and get an 'image'
            //of where it is saved on the device
            final image = await _controller.takePicture();

            if(!mounted) return;

            //if the picture was taken, display on a new screen
            await Navigator.of(context).push(
              MaterialPageRoute(
                  builder: (context) => DisplayPictureScreen(
                    imagePath: image.path
                  )
              ),
            );

          } catch(e){
            print(e);
          }
        },
      ),
    );
  }
  void onNewCameraSelected (CameraDescription cameraDescription) async {
    final previousCameraController = _controller;
    //instantiate a new camera controller
    final CameraController cameraController = CameraController(
        cameraDescription,
        ResolutionPreset.high,
        imageFormatGroup: ImageFormatGroup.jpeg
    );

    //dispose of the previous controller
    await previousCameraController.dispose();
    if (mounted) {
      setState(() {
        _controller = cameraController;
      });
    }

    //when the mounted state changes, update the UI
    cameraController.addListener(() {
      if (mounted) setState(() {

      });
    });

    try{
      await cameraController.initialize();
    } catch(e){
      print (e);
    }
  }
}



class DisplayPictureScreen extends StatelessWidget {
  const DisplayPictureScreen({Key? key, required this.imagePath}) : super(key: key);
  final String imagePath;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Display the Picture"),),
      body: Image.file(File(imagePath)),
    );
  }
}

