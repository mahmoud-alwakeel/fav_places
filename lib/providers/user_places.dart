import 'dart:io';

import 'package:fav_places/models/place_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserPlacesNotifier extends StateNotifier<List<PlaceModel>> {
  UserPlacesNotifier() : super(const []);

  void addPlace(String title, File image) {
    final newPlace = PlaceModel(name: title, image: image);
    state = [newPlace, ...state];
  }
}

final userPlacesProvider = StateNotifierProvider<UserPlacesNotifier, List<PlaceModel>>(
  (ref) => UserPlacesNotifier(),
);
