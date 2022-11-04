import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class MapMarker{
  final String image;
  final String title;
  final String address;
  final LatLng location;
  final int rating;

  MapMarker({
    required this.image,
    required this.title,
    required this.address,
    required this.location,
    required this.rating,
});
}
  final mapMarkers = [
    MapMarker(
        image: 'https://images.otstatic.com/prod/23888275/1/huge.jpg',
        title: 'Alexander The Great Restaurant',
        address: '8 Plender St, London NW1 0JT, United Kingdom',
        location: LatLng(51.5382123, -0.1882464),
        rating: 4),
    MapMarker(
        image: 'https://media-cdn.tripadvisor.com/media/photo-s/11/5b/49/0a/mestizo-mexican-restaurant.jpg',
        title: 'Mestizo Mexican Restaurant',
        address: '103 Hampstead Rd, London NW1 3EL, United Kingdom',
        location: LatLng(51.5090229, -0.2886548),
        rating: 5),
    MapMarker(
        image: 'https://media-cdn.tripadvisor.com/media/photo-s/1a/ba/e9/f6/the-shed.jpg',
        title: 'The Shed',
        address: '122 Palace Gardens Terrace, London W8 4RT, United Kingdom',
        location: LatLng(51.5090215, -0.1959988),
        rating: 2),
    MapMarker(
        image: 'https://media-cdn.tripadvisor.com/media/photo-s/16/50/69/a4/gaucho-tower-bridge.jpg',
        title: 'Gaucho Tower Bridge',
        address: '2 More London Riverside, London SE1 2AP, United Kingdom',
        location: LatLng(51.5054563, -0.0798412),
        rating: 3),
    MapMarker(
      image: 'https://resizer.otstatic.com/v2/photos/wide-huge/2/29127125.jpg',
      title: 'Bill\'s Holborn Restaurant',
      address: '42 Kingsway, London WC2B 6EY, United Kingdom',
      location: LatLng(51.5077676, -0.2208447),
      rating: 4,
    ),
  ];


