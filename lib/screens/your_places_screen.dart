import 'package:fav_places/providers/user_places.dart';
import 'package:fav_places/screens/add_new_place_screen.dart';
import 'package:fav_places/widgets/places_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class YourPlacesScreen extends ConsumerStatefulWidget {
  const YourPlacesScreen({super.key});

  @override
  ConsumerState<YourPlacesScreen> createState() => _YourPlacesScreenState();
}

class _YourPlacesScreenState extends ConsumerState<YourPlacesScreen> {
  late Future<void> _placesFuture;
  @override
  void initState() {
    super.initState();
    _placesFuture = ref.read(userPlacesProvider.notifier).loadPlaces();
  }

  @override
  Widget build(BuildContext context) {
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
        child: FutureBuilder(
          future: _placesFuture,
          builder: (context, snapShot) {
            return snapShot.connectionState == ConnectionState.waiting
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : PlacesList(places: userPLaces);
          },
        ),
      ),
    );
  }
}
