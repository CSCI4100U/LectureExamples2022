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
          Positioned(
              left: 0,
              right: 0,
              bottom: 2,
              height: MediaQuery.of(context).size.height*0.3,
              child: PageView.builder(
                  itemCount: mapMarkers.length,
                  itemBuilder: (context, index){
                    var item = mapMarkers[index];
                    return Padding(
                      padding: EdgeInsets.all(15.0),
                      child: Card(
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        color: const Color.fromARGB(255, 30, 29, 29),
                        child: Row(
                          children: [
                            const SizedBox(width:10),
                            Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Expanded( //Put in gold stars for restaurant
                                        child: ListView.builder(
                                          padding: EdgeInsets.zero,
                                          scrollDirection: Axis.horizontal,
                                          itemCount: item.rating,
                                          itemBuilder: (context, index){
                                            return Icon(Icons.star, color: Colors.yellow,);
                                          },
                                        ),
                                    ),
                                    Expanded(
                                      flex: 2,
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              item.title ?? '',
                                              style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white
                                              ),
                                            ),
                                          ],
                                        ),
                                    ),
                                  ],
                                ),
                            ),
                            const SizedBox(width: 10,),
                            Expanded(
                                child: Padding(
                                  padding: EdgeInsets.all(4.0),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image.network(mapMarkers[index].image),
                                  ),
                                ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }
              ),
          ),
        ],
      ),
    );
  }
}
