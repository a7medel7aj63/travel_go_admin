import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travel_go/model/hotel_model.dart';
import 'package:travel_go/screens/image_upload.dart';
import 'package:travel_go/widgets/custom_textfield.dart';

import '../widgets/loading.dart';
import '../widgets/snackbar.dart';

class HotelController extends GetxController {
  RxList<Hotels> hotels = RxList<Hotels>([]);
  late CollectionReference collectionReference;
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  late TextEditingController name, location, about;
  final ValueNotifier<bool> _loading = ValueNotifier(false);

  ValueNotifier<bool> get loading => _loading;

  @override
  void onInit() {
    var user = FirebaseAuth.instance.currentUser;
    collectionReference = firebaseFirestore.collection("hotel");
    name = TextEditingController();
    location = TextEditingController();
    about = TextEditingController();
    hotels.bindStream(getAllhotels());
    loading.value = true;
    super.onInit();
  }

  Stream<List<Hotels>> getAllhotels() => collectionReference
      .snapshots()
      .map((query) => query.docs.map((item) => Hotels.fromMap(item)).toList());

  String? validate(String value) {
    if (value.isEmpty) {
      return "this field can't be empty";
    }
    return null;
  }

  ImagePage imagePage = ImagePage();

  void addHotel(BuildContext context) {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    final data = MediaQuery.of(context);
    var img;
    Get.defaultDialog(
        content: SizedBox(
      height: data.size.height / 2,
      width: data.size.width / 2,
      child: Form(
        key: formKey,
        child: ListView(
          children: [
            GestureDetector(
              onTap: () async {
                img = imagePage.imageSelect();
              },
              child: Container(
                height: data.size.height * 0.20,
                width: data.size.width * 0.05,
                decoration: BoxDecoration(
                  color: Colors.black38,
                  borderRadius: BorderRadius.circular(46),
                ),
                child: imagePage.image.isEmpty
                    ? const Center(child: Icon(Icons.add_a_photo_outlined))
                    : const Center(
                        child: Text(
                          'image Selected',
                          style: TextStyle(color: Colors.green),
                        ),
                      ),
              ),
            ),
            CustomTextField(
              controller: name,
              validator: (value) {
                return validate(value!);
              },
              lable: 'hotel name',
              icon: const Icon(Icons.hotel),
              input: TextInputType.text,
              secure: false,
            ),
            CustomTextField(
              controller: location,
              validator: (value) {
                return validate(value!);
              },
              lable: 'hotel location',
              icon: const Icon(Icons.location_on),
              input: TextInputType.text,
              secure: false,
            ),
            CustomTextField(
              controller: about,
              validator: (value) {
                return validate(value!);
              },
              lable: 'about the hotel',
              icon: const Icon(Icons.money),
              input: TextInputType.text,
              secure: false,
            ),
            // CustomTextField(
            //   controller: number,
            //   validator: (value) {
            //     return validate(value!);
            //   },
            //   lable: '',
            //   icon: const Icon(Icons.bed),
            //   input: TextInputType.number,
            //   secure: false,
            // ),
            MaterialButton(
              onPressed: () async {
                if (formKey.currentState!.validate()) {
                  if (imagePage.image.isNotEmpty) {
                    showdilog();
                    await imagePage.uploadImageToFirebase(img);
                    try {
                      var data = <String, dynamic>{
                        "name": name.text,
                        "location": location.text,
                        "about": about.text,
                        "image": imagePage.image_url,
                      };
                      await collectionReference
                          .doc()
                          .set(data)
                          .whenComplete(() async {
                        name.clear();
                        location.clear();
                        about.clear();
                        Get.back();
                        imagePage.image.clear();
                        showbar('title', 'subtitle', 'hotel Added', true);
                        Get.back();
                        Get.back();
                        update();
                      });
                    } catch (e) {
                      Get.back();

                      showbar('title', 'subtitle', e.toString(), false);
                    }
                  } else {
                    showbar('title', 'subtitle', "please select image", false);
                  }
                }
              },
              child: const Text("Add hotel"),
              // minWidth: double.infinity,
              // padding: EdgeInsets.only(left: data.size.width /2 ,right: data.size.width),
              height: 52,
              elevation: 24,
              color: Colors.amber.shade700,
              textColor: Colors.black,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(32)),
            ),
            const SizedBox(
              height: 5,
            ),
            MaterialButton(
              onPressed: () async {
                Get.back();
              },
              child: const Text("close"),
              // minWidth: double.infinity,
              // padding: EdgeInsets.only(left: data.size.width /2 ,right: data.size.width),
              height: 52,
              elevation: 24,
              color: Colors.amber.shade700,
              textColor: Colors.black,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(32)),
            ),
          ],
        ),
      ),
    ));
  }

  void editHotel(String id, BuildContext context, String name1,
      String location1, String about1) {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    final data = MediaQuery.of(context);
    name.text = name1;
    location.text = location1;
    about.text = about1;
    Get.defaultDialog(
        content: SizedBox(
      height: data.size.height / 2,
      width: data.size.width / 2,
      child: Form(
        key: formKey,
        child: ListView(
          children: [
            CustomTextField(
              controller: name,
              validator: (value) {
                return validate(value!);
              },
              lable: 'hotel name',
              icon: const Icon(Icons.hotel),
              input: TextInputType.text,
              secure: false,
            ),
            CustomTextField(
              controller: location,
              validator: (value) {
                return validate(value!);
              },
              lable: 'location ',
              icon: const Icon(Icons.location_on),
              input: TextInputType.text,
              secure: false,
            ),
            CustomTextField(
              controller: about,
              validator: (value) {
                return validate(value!);
              },
              lable: 'about the hotel',
              icon: const Icon(Icons.account_balance_outlined),
              input: TextInputType.text,
              secure: false,
            ),
            MaterialButton(
              onPressed: () async {
                try {
                  showdilog();
                  var data = <String, dynamic>{
                    "name": name.text,
                    "location": location.text,
                    "about": about.text
                  };
                  await collectionReference
                      .doc(id)
                      .update(data)
                      .whenComplete(() async {
                    name.clear();
                    location.clear();
                    about.clear();
                    Get.back();
                    Get.back();
                    showbar('title', 'subtitle', 'hotel Edited', true);
                    update();
                  });
                } catch (e) {
                  Get.back();
                  showbar('title', 'subtitle', e.toString(), false);
                }
              },
              child: const Text("Edit hotel"),
              // minWidth: double.infinity,
              // padding: EdgeInsets.only(left: data.size.width /2 ,right: data.size.width),
              height: 52,
              elevation: 24,
              color: Colors.amber.shade700,
              textColor: Colors.black,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(32)),
            ),
            const SizedBox(
              height: 5,
            ),
            MaterialButton(
              onPressed: () async {
                Get.back();
              },
              child: const Text("close"),
              // minWidth: double.infinity,
              // padding: EdgeInsets.only(left: data.size.width /2 ,right: data.size.width),
              height: 52,
              elevation: 24,
              color: Colors.amber.shade700,
              textColor: Colors.black,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(32)),
            ),
          ],
        ),
      ),
    ));
  }

  void deleteHotel(String id) {
    Get.dialog(AlertDialog(
      content: const Text('hotel delete'),
      actions: [
        TextButton(
            onPressed: () async {
              try {
                showdilog();
                await collectionReference.doc(id).delete();
                update();
                Get.back();
                Get.back();
                showbar('Delete hotel', '', 'hotel Deleted', true);
              } catch (e) {
                showbar('Delete hotel ', '', e.toString(), false);
                Get.back();
              }
            },
            child: const Text('delete')),
        TextButton(
            onPressed: () {
              Get.back();
            },
            child: const Text('back'))
      ],
    ));
  }
}
