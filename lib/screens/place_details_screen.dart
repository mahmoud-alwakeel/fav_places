import 'package:fav_places/models/place_model.dart';
import 'package:fav_places/screens/maps_screen.dart';
import 'package:flutter/material.dart';

class PlaceDetailsScreen extends StatelessWidget {
  const PlaceDetailsScreen({super.key, required this.place});

  final PlaceModel place;

  String get locationImage {
    final lat = place.location.latitude;
    final lng = place.location.longitude;
    return 'https://maps.googleapis.com/maps/api/staticmap?center=$lat,$lng=&zoom=13&size=600x300&maptype=roadmap&markers=color:red%7Clabel:S%7C$lat,$lng&key=';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          place.name,
        ),
      ),
      body: Stack(
        children: [
          Image.file(
            place.image,
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Column(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => MapsScreen(
                          location: place.location,
                          isSelecting: false,
                        ),
                      ),
                    );
                  },
                  child: CircleAvatar(
                    radius: 70,
                    backgroundImage: NetworkImage(locationImage),
                  ),
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.transparent,
                        Colors.black,
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                  child: Text(
                    place.location.address,
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color: Theme.of(context).colorScheme.onBackground,
                        ),
                    textAlign: TextAlign.center,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
