import 'package:cloud_firestore/cloud_firestore.dart';

class Hotels {
  String? id;
  String? name;
  String? location;
  String? about;

  Hotels({
    required this.name,
    required this.location,
    required this.about,
  });

  Hotels.fromMap(DocumentSnapshot data) {
    id = data.id;
    name = data["name"];
    location = data["location"];
    about = data["about"];
  }
}
