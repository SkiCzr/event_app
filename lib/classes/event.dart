import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
class Event {
  String name;
  String description;
  double price;
  LatLng location;
  String address;
  DateTime date;
  List<String> images;

  Event({
    required this.name,
    required this.description,
    required this.location,
    required this.address,
    required this.price,
    required this.date,
    required this.images,
  });
}