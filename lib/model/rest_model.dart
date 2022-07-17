import 'package:cloud_firestore/cloud_firestore.dart';

class Rest {
  String? id;
  String? name;
  String? location;
  String? description;

  Rest(
      {this.id,
      required this.name,
      required this.location,
      required this.description});

  Rest.fromMap(DocumentSnapshot data) {
    id = data.id;
    name = data["name"];
    location = data["location"];
    description = data["description"];
  }
}
