import 'package:flutter/material.dart';

class AddNewPlaceScreen extends StatelessWidget {
  const AddNewPlaceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Add new place",
        ),
      ),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: () {},
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.add),
                Text(
                  'Add Place',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
