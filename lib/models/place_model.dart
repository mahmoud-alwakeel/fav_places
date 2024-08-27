import 'package:uuid/uuid.dart';

const uuid = Uuid();

class PlaceModel {
  final String id;
  final String name;

  PlaceModel({
    required this.name,
  }) : id = uuid.v4();
}
