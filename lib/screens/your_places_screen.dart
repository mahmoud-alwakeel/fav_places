import 'package:fav_places/screens/add_new_place_screen.dart';
import 'package:flutter/material.dart';

class YourPlacesScreen extends StatelessWidget {
  const YourPlacesScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
      body: ListView(),
    );
  }
}
