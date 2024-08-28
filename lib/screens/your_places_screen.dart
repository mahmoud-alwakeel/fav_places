import 'package:fav_places/providers/user_places.dart';
import 'package:fav_places/screens/add_new_place_screen.dart';
import 'package:fav_places/widgets/places_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class YourPlacesScreen extends ConsumerWidget {
  const YourPlacesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userPLaces = ref.watch(userPlacesProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Your places",
        ),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const AddNewPlaceScreen(),
                ),
              );
            },
            icon: const Icon(
              Icons.add,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: PlacesList(places: userPLaces),
      ),
    );
  }
}
