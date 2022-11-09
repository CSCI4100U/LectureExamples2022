import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:lecture8b/constants.dart';
import 'package:lecture8b/MapMarker.dart';
import 'package:latlong2/latlong.dart';

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

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {

  int selectedIndex = 0;
  final pageController = PageController();
  var currentLocation = AppConstants.myLocation;

  late MapController mapController;

  @override
  void initState(){
    super.initState();
    mapController = MapController();
  }

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
            mapController: mapController,
              options: MapOptions(
                minZoom: 5,
                maxZoom: 18,
                zoom: 13,
                center: currentLocation
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
                              onPressed: (){
                                setState(() {
                                pageController.animateToPage(
                                    i,
                                    duration: Duration(milliseconds: 500),
                                    curve: Curves.easeInOut
                                );
                                  selectedIndex = i;
                                  currentLocation = mapMarkers[i].location;
                                  _animatedMapMove(currentLocation, 11.5);
                                });
                              },
                              icon: Icon(Icons.location_on,
                              color: selectedIndex == i ?
                              Colors.blue : Colors.black),
                              iconSize: 45,
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
                controller: pageController,
                  itemCount: mapMarkers.length,
                  onPageChanged: (value){
                    setState(() {
                      selectedIndex = value;
                      currentLocation = mapMarkers[value].location;
                      _animatedMapMove(currentLocation, 11.5);
                    });
                  },
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


  void _animatedMapMove(LatLng destLocation, double destZoom) {
    // Create some tweens. These serve to split up the transition from one location to another.
    // In our case, we want to split the transition be<tween> our current map center and the destination.
    final latTween = Tween<double>(
        begin: mapController.center.latitude, end: destLocation.latitude);
    final lngTween = Tween<double>(
        begin: mapController.center.longitude, end: destLocation.longitude);
    final zoomTween = Tween<double>(begin: mapController.zoom, end: destZoom);

    // Create a animation controller that has a duration and a TickerProvider.
    var controller = AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this);
    // The animation determines what path the animation will take. You can try different Curves values, although I found
    // fastOutSlowIn to be my favorite.
    Animation<double> animation =
    CurvedAnimation(parent: controller, curve: Curves.fastOutSlowIn);

    controller.addListener(() {
      mapController.move(
        LatLng(latTween.evaluate(animation), lngTween.evaluate(animation)),
        zoomTween.evaluate(animation),
      );
    });

    animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        controller.dispose();
      } else if (status == AnimationStatus.dismissed) {
        controller.dispose();
      }
    });

    controller.forward();
  }
}
