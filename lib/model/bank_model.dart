import 'package:cloud_firestore/cloud_firestore.dart';

class Bank {
  String? id;
  String? name;
  String? location;
  String? image;
  String? about;

  Bank({
    required this.name,
    required this.location,
    required this.image,
    required this.about,
  });

  Bank.fromMap(DocumentSnapshot data) {
    id = data.id;
    name = data["name"];
    location = data["location"];
    image = data["image"];
    about = data["about"];
  }
}
