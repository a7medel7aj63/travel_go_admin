import 'package:bottom_picker/bottom_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travel_go/model/arch.dart';
import 'package:travel_go/model/bank_model.dart';
import 'package:travel_go/model/hotel_model.dart';
import 'package:travel_go/model/mueseum_model.dart';
import 'package:travel_go/model/rest_model.dart';
import 'package:travel_go/model/tourist_model.dart';

class AllData extends GetxController {
  RxList<Arch> archs = RxList<Arch>([]);
  RxList<Bank> banks = RxList<Bank>([]);
  RxList<Hotels> hotels = RxList<Hotels>([]);
  RxList<Mueseum> muse = RxList<Mueseum>([]);
  RxList<Rest> rest = RxList<Rest>([]);
  RxList<Tourist> tour = RxList<Tourist>([]);
  late TextEditingController title, subtitle, subject;
  late CollectionReference bankReference;
  late CollectionReference archReference;
  late CollectionReference museReference;
  late CollectionReference restReference;
  late CollectionReference hotelReference;
  late CollectionReference tourReference;
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  auth.User? user;

  @override
  void onInit() {
    user = FirebaseAuth.instance.currentUser;
    archReference = firebaseFirestore.collection("arch");
    bankReference = firebaseFirestore.collection("bank");
    museReference = firebaseFirestore.collection("muse");
    restReference = firebaseFirestore.collection("rest");
    hotelReference = firebaseFirestore.collection("hotel");
    tourReference = firebaseFirestore.collection("tourist");
    archs.bindStream(getAllArch());
    banks.bindStream(getAllBank());
    hotels.bindStream(getAllHotel());
    muse.bindStream(getAllMues());
    tour.bindStream(getAllTour());
    title = TextEditingController();
    subtitle = TextEditingController();
    subject = TextEditingController();
    super.onInit();
  }

  Stream<List<Arch>> getAllArch() => archReference
      .snapshots()
      .map((query) => query.docs.map((item) => Arch.fromMap(item)).toList());

  Stream<List<Bank>> getAllBank() => bankReference
      .snapshots()
      .map((query) => query.docs.map((item) => Bank.fromMap(item)).toList());

  Stream<List<Hotels>> getAllHotel() => hotelReference
      .snapshots()
      .map((query) => query.docs.map((item) => Hotels.fromMap(item)).toList());

  Stream<List<Mueseum>> getAllMues() => hotelReference
      .snapshots()
      .map((query) => query.docs.map((item) => Mueseum.fromMap(item)).toList());

  Stream<List<Rest>> getAllRest() => restReference
      .snapshots()
      .map((query) => query.docs.map((item) => Rest.fromMap(item)).toList());

  Stream<List<Tourist>> getAllTour() => restReference
      .snapshots()
      .map((query) => query.docs.map((item) => Tourist.fromMap(item)).toList());
}
