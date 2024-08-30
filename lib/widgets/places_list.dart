import 'package:fav_places/models/place_model.dart';
import 'package:fav_places/screens/place_details_screen.dart';
import 'package:flutter/material.dart';

class PlacesList extends StatelessWidget {
  const PlacesList({
    super.key,
    required this.places,
  });

  final List<PlaceModel> places;
  @override
  Widget build(BuildContext context) {
    if (places.isEmpty) {
      return Center(
        child: Text(
          "No places, trying adding a new one",
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
                color: Theme.of(context).colorScheme.onBackground,
              ),
        ),
      );
    } else {
      return ListView.builder(
        itemCount: places.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: CircleAvatar(
              radius: 26,
              backgroundImage: FileImage(
                places[index].image,
              ),
            ),
            title: Text(
              places[index].name,
              style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
            ),
            subtitle: Text(
              places[index].location.address,
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
            ),
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (conntext) => PlaceDetailsScreen(
                    place: places[index],
                  ),
                ),
              );
            },
          );
        },
      );
    }
  }
}
