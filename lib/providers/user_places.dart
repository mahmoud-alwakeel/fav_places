import 'dart:io';

import 'package:fav_places/models/place_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart' as syspath;
import 'package:path/path.dart' as path;
import 'package:sqflite/sqflite.dart' as sql;
import 'package:sqflite/sqlite_api.dart';

Future<Database> _getDatabase() async {
  final dbPath = await sql.getDatabasesPath();
  final db = await sql.openDatabase(
    path.join(dbPath, 'places.db'),
    onCreate: (db, version) {
      return db.execute(
          'CREATE TABLE user_places(id TEXT PRIMARY KEY, name TEXT, image TEXT, lat REAL, lng REAL, address TEXT)');
    },
    version: 1,
  );
  return db;
}

class UserPlacesNotifier extends StateNotifier<List<PlaceModel>> {
  UserPlacesNotifier() : super(const []);

  Future<void> loadPlaces() async {
    final db = await _getDatabase();
    final data = await db.query('user_places');
    final places = data
        .map(
          (row) => PlaceModel(
            id: row['id'] as String,
            name: row['name'] as String,
            image: File(
              row['image'] as String,
            ),
            location: PLaceLocation(
              latitude: row['lat'] as double,
              longitude: row['lng'] as double,
              address: row['address'] as String,
            ),
          ),
        )
        .toList();
    state = places;
  }

  void addPlace(String title, File image, PLaceLocation location) async {
    // adding image to a perminant location
    // appDir is the path
    final appDir = await syspath.getApplicationDocumentsDirectory();
    final fileName = path.basename(image.path);
    final imageCopy = await image.copy('${appDir.path}/$fileName');

    final newPlace =
        PlaceModel(name: title, image: imageCopy, location: location);

    final db = await _getDatabase();

    db.insert('user_places', {
      'id': newPlace.id,
      'name': newPlace.name,
      'image': newPlace.image.path,
      'lat': newPlace.location.latitude,
      'lng': newPlace.location.longitude,
      'address': newPlace.location.address,
    });

    state = [newPlace, ...state];
  }
}

final userPlacesProvider =
    StateNotifierProvider<UserPlacesNotifier, List<PlaceModel>>(
  (ref) => UserPlacesNotifier(),
);
