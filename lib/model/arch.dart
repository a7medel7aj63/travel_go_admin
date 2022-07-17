import 'package:cloud_firestore/cloud_firestore.dart';

class Arch {
  String? id;
  String? name;
  String? location;
  String? image;
  String? about;

  Arch({
    required this.name,
    required this.location,
    required this.image,
    required this.about,
  });

  Arch.fromMap(DocumentSnapshot data) {
    id = data.id;
    name = data["name"];
    location = data["location"];
    image = data["image"];
    about = data["about"];
  }
}
