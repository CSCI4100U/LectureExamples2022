import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Geocoding and Geolocation',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Geolocation/Geocoding Home Page'),
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

  var _positionMessage = '';
  var _descriptionMessage = '';

  @override
  Widget build(BuildContext context) {

    Geolocator.isLocationServiceEnabled().then((value) => null);
    Geolocator.requestPermission().then((value) => null);
    Geolocator.checkPermission().then(
            (LocationPermission permission)
        {
          print("Check Location Permission: $permission");
        }
    );

    Geolocator.getPositionStream(
      locationSettings: LocationSettings(
        accuracy: LocationAccuracy.best
      ),
    ).listen(_updateLocationStream);


    return Scaffold(
      appBar: AppBar(

        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(

          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(_positionMessage,
              style: TextStyle(fontSize: 30),
            ),
            Text(
              _descriptionMessage,
              style: TextStyle(fontSize: 30),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: geocode,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  _updateLocationStream(Position userLocation) async{

      _positionMessage = userLocation.latitude.toString() + ','
          + userLocation.longitude.toString();
      final List<Placemark> places = await placemarkFromCoordinates(
          userLocation.latitude,
          userLocation.longitude
      );
      setState(() {
        _descriptionMessage = '${[places[0]]}';
    });
  }

  geocode() async{
    String address = '301 Front St W, Toronto, ON';
    final List<Location> locations = await locationFromAddress(address);
    setState(() {
      _positionMessage = locations[0].latitude.toString() + ','
          + locations[0].longitude.toString();
    });
  }

  _updateCurrentLocation() async{
    Position userLocation = await Geolocator.getCurrentPosition();
      _positionMessage = userLocation.latitude.toString() + ','
          + userLocation.longitude.toString();

    final List<Placemark> places = await placemarkFromCoordinates(
        userLocation.latitude,
        userLocation.longitude
    );
    setState(() {
      _descriptionMessage = '${[places[0]]}';
    });
  }
}
