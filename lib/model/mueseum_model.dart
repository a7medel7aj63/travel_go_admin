import 'package:cloud_firestore/cloud_firestore.dart';

class Mueseum {
  String? id;
  String? name;
  String? location;
  String? image;
  String? about;

  Mueseum({
    required this.name,
    required this.location,
    required this.image,
    required this.about,
  });

  Mueseum.fromMap(DocumentSnapshot data) {
    id = data.id;
    name = data["name"];
    location = data["location"];
    image = data["image"];
    about = data["about"];
  }
}
