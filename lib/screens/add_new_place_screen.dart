import 'package:flutter/material.dart';

class AddNewPlaceScreen extends StatefulWidget {
  const AddNewPlaceScreen({super.key});

  @override
  State<AddNewPlaceScreen> createState() => _AddNewPlaceScreenState();
}

class _AddNewPlaceScreenState extends State<AddNewPlaceScreen> {
  final TextEditingController _titleController = TextEditingController();

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Add new place",
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              TextField(
                decoration: const InputDecoration(
                  labelText: 'title',
                ),
                controller: _titleController,
                style: const TextStyle(color: Colors.white),
              ),
              const SizedBox(
                height: 16,
              ),
              ElevatedButton.icon(
                icon: const Icon(Icons.add),
                onPressed: () {},
                label: const Text(
                  'Add Place',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
