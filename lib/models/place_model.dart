import 'dart:io';

import 'package:uuid/uuid.dart';

const uuid = Uuid();

class PLaceLocation {
  final double latitude;
  final double longitude;
  final String address;

  const PLaceLocation({
    required this.latitude,
    required this.longitude,
    required this.address,
  });
}

class PlaceModel {
  final String id;
  final String name;
  final File image;
  final PLaceLocation location;

  PlaceModel({
    required this.name,
    required this.image,
    required this.location,
    String? id
  }) : id = id ?? uuid.v4();
}
