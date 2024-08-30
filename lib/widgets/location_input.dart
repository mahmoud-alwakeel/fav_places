import 'dart:convert';

import 'package:fav_places/models/place_model.dart';
import 'package:fav_places/screens/maps_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:http/http.dart' as http;

class LocationInput extends StatefulWidget {
  const LocationInput({
    super.key,
    required this.onPickLocation,
  });
  final void Function(PLaceLocation location) onPickLocation;

  @override
  State<LocationInput> createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  PLaceLocation? pickedLocation;
  bool isGettingLocation = false;

  String get locationImage {
    if (pickedLocation == null) {
      return '';
    }
    final lat = pickedLocation!.latitude;
    final lng = pickedLocation!.longitude;
    return 'https://maps.googleapis.com/maps/api/staticmap?center=$lat,$lng=&zoom=13&size=600x300&maptype=roadmap&markers=color:red%7Clabel:S%7C$lat,$lng&key=';
  }

  Future<void> _savePlace(double latitude, double longitude) async {
    final url = Uri.parse(
        'https://maps.googleapis.com/maps/api/geocode/json?latlng=$latitude,$longitude&key=');
    final response = await http.get(url);
    final resData = json.decode(response.body);
    if (resData['results'] != null && resData['results'].isNotEmpty) {
      final address = resData['results'][0]['formatted_address'];
      setState(() {
        pickedLocation = PLaceLocation(
          latitude: latitude,
          longitude: longitude,
          address: address,
        );
        isGettingLocation = false;
        widget.onPickLocation(pickedLocation!);
      });
    } else {
      // Handle the case where no address is found
      setState(() {
        pickedLocation = PLaceLocation(
          latitude: latitude,
          longitude: longitude,
          address: 'Address not found',
        );
        isGettingLocation = false;
      });
    }
  }

  void _getCurrentLocation() async {
    Location location = Location();

    bool serviceEnabled;
    PermissionStatus permissionGranted;
    LocationData locationData;

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return;
      }
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    setState(() {
      isGettingLocation = true;
    });
    locationData = await location.getLocation();
    final latitude = locationData.latitude;
    final longitude = locationData.longitude;

    if (latitude == null || longitude == null) {
      return;
    }
    _savePlace(latitude, longitude);
    print(locationData.latitude);
    print(locationData.longitude);
  }

  void _selectLocationOnMap() async {
    final pickedLocation = await Navigator.of(context).push<LatLng>(
      MaterialPageRoute(
        builder: (context) {
          return MapsScreen();
        },
      ),
    );
    if (pickedLocation == null) {
      return;
    }
    _savePlace(pickedLocation.latitude, pickedLocation.longitude);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 180,
          width: double.infinity,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border.all(
              width: 0.5,
              color: Colors.white,
            ),
          ),
          child: pickedLocation != null
              ? Image.network(
                  locationImage,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: double.infinity,
                )
              : isGettingLocation == false
                  ? Text(
                      'No place selected',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color: Theme.of(context).colorScheme.onBackground),
                    )
                  : const Center(
                      child: CircularProgressIndicator(),
                    ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextButton.icon(
              onPressed: _getCurrentLocation,
              label: const Text(
                'Get current location',
              ),
              icon: const Icon(
                Icons.location_on,
              ),
            ),
            TextButton.icon(
              onPressed: _selectLocationOnMap,
              label: const Text(
                'Select on map',
              ),
              icon: const Icon(
                Icons.map,
              ),
            ),
          ],
        )
      ],
    );
  }
}
