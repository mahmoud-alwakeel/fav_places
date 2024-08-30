import 'package:fav_places/models/place_model.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapsScreen extends StatefulWidget {
  const MapsScreen({
    super.key,
    this.location = const PLaceLocation(
      latitude: 31.2518083,
      longitude: 29.97893,
      address: '',
    ),
    this.isSelecting = true,
  });
  final PLaceLocation location;
  final bool isSelecting;

  @override
  State<MapsScreen> createState() => _MapsScreenState();
}

class _MapsScreenState extends State<MapsScreen> {
  LatLng? _pickedLocation;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.isSelecting ? "Select your location" : "Your location",
        ),
        actions: [
          if (widget.isSelecting)
            IconButton(
              onPressed: () {
                Navigator.of(context).pop(_pickedLocation);
              },
              icon: const Icon(
                Icons.save,
              ),
            ),
        ],
      ),
      body: GoogleMap(
        onTap: 
        !widget.isSelecting ? null : 
        (position) {
          setState(() {
            _pickedLocation = position;
          });
        },
        initialCameraPosition: CameraPosition(
          target: LatLng(
            widget.location.latitude,
            widget.location.longitude,
          ),
          zoom: 14,
        ),
        markers: (_pickedLocation == null && widget.isSelecting) ? {} : {
          Marker(
            markerId: const MarkerId('m1'),
            position: _pickedLocation ?? LatLng(
              widget.location.latitude,
              widget.location.longitude,
            ),
          ),
        },
      ),
    );
  }
}
