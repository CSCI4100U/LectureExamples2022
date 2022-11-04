import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:lecture8b/constants.dart';
import 'package:lecture8b/MapMarker.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Map Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Map Demo Home Page'),
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
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Stack(
        children: [
          FlutterMap(
              options: MapOptions(
                minZoom: 5,
                maxZoom: 18,
                zoom: 13,
                center: AppConstants.myLocation
              ),
            layers: [
              TileLayerOptions(
                urlTemplate: AppConstants.mapBoxStyleId,
              ),
              MarkerLayerOptions(
                markers: [
                  for (int i = 0; i < mapMarkers.length; i++)
                      Marker(
                        height: 80,
                        width: 80,
                        point: mapMarkers[i].location ?? AppConstants.myLocation,
                        builder: (context){
                          return Container(
                            child: IconButton(
                              onPressed: (){},
                              icon: Icon(Icons.location_on),
                            ),
                          );
                        }
                      ),

                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
