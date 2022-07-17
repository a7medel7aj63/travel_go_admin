import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:travel_go/screens/image_upload.dart';
import 'package:travel_go/widgets/custom_textfield.dart';

import '../model/rest_model.dart';
import '../widgets/loading.dart';
import '../widgets/snackbar.dart';

class RestController extends GetxController {
  RxList<Rest> rest = RxList<Rest>([]);
  late CollectionReference collectionReference;
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  late TextEditingController name, location, description;
  auth.User? user;
  final ValueNotifier<bool> _loading = ValueNotifier(false);

  ValueNotifier<bool> get loading => _loading;

  @override
  void onInit() {
    user = FirebaseAuth.instance.currentUser;
    collectionReference = firebaseFirestore.collection("restaurant");
    description = TextEditingController();
    name = TextEditingController();
    location = TextEditingController();
    rest.bindStream(getAllRest());
    loading.value = true;
    super.onInit();
  }

  Stream<List<Rest>> getAllRest() => collectionReference
      .snapshots()
      .map((query) => query.docs.map((item) => Rest.fromMap(item)).toList());

  String? validate(String value) {
    if (value.isEmpty) {
      return "this field can't be empty";
    }
    return null;
  }

  ImagePage imagePage = ImagePage();

  void addRestaurant(BuildContext context) {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    final data = MediaQuery.of(context);
    Get.defaultDialog(
        title: 'Add Restaurant',
        content: Form(
          key: formKey,
          child: Column(
            children: [
              GestureDetector(
                onTap: () async {
                  imagePage.imageSelect();
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
                lable: 'Restaurant name',
                icon: const Icon(Icons.bed),
                input: TextInputType.text,
                secure: false,
              ),
              CustomTextField(
                controller: location,
                validator: (value) {
                  return validate(value!);
                },
                lable: 'Restaurant location',
                icon: const Icon(Icons.money),
                input: TextInputType.text,
                secure: false,
              ),
              CustomTextField(
                controller: description,
                validator: (value) {
                  return validate(value!);
                },
                lable: 'Restaurant Description',
                icon: const Icon(Icons.money),
                input: TextInputType.number,
                secure: false,
              ),
              MaterialButton(
                onPressed: () async {
                  if (formKey.currentState!.validate()) {
                    try {
                      showdilog();
                      var data = <String, dynamic>{
                        "name": name.text,
                        "location": location.text,
                        "description": description.text,
                      };
                      await collectionReference
                          .doc()
                          .set(data)
                          .whenComplete(() async {
                        update();
                        name.clear();
                        location.clear();
                        description.clear();
                        Get.back();
                        showbar('title', 'subtitle', 'restaurant Added', true);
                      });
                    } catch (e) {
                      Get.back();
                      showbar('title', 'subtitle', e.toString(), false);
                    }
                  }
                },
                child: const Text("Add restaurant"),
                minWidth: double.infinity,
                // padding: EdgeInsets.only(left: data.size.width /2 ,right: data.size.width),
                height: 52,
                elevation: 24,
                color: Colors.amber.shade700,
                textColor: Colors.black,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(32)),
              ),
              const SizedBox(
                height: 15,
              ),
              MaterialButton(
                onPressed: () async {
                  Get.back();
                },
                child: const Text("close"),
                minWidth: double.infinity,
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
        ));
  }

  void editRestaurant(String id, BuildContext context, String name1,
      String location1, String description1) {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    final data = MediaQuery.of(context);
    name.text = name1;
    location.text = location1.toString();
    description.text = description1.toString();
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
              lable: 'restaurant name',
              icon: const Icon(Icons.bed),
              input: TextInputType.text,
              secure: false,
            ),
            CustomTextField(
              controller: location,
              validator: (value) {
                return validate(value!);
              },
              lable: 'restaurant location',
              icon: const Icon(Icons.location_on),
              input: TextInputType.text,
              secure: false,
            ),
            CustomTextField(
              controller: description,
              validator: (value) {
                return validate(value!);
              },
              lable: 'restaurant description',
              icon: const Icon(Icons.description),
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
                    "description": description.text,
                  };
                  await collectionReference
                      .doc(id)
                      .update(data)
                      .whenComplete(() async {
                    name.clear();
                    location.clear();
                    description.clear();
                    Get.back();
                    Get.back();
                    showbar('title', 'subtitle', 'Restaurant Edited', true);
                    update();
                  });
                } catch (e) {
                  Get.back();
                  showbar('title', 'subtitle', e.toString(), false);
                }
              },
              child: const Text("Edit Restaurant"),
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

  void deleteRestaurant(String id) {
    Get.dialog(AlertDialog(
      content: const Text('restaurant delete'),
      actions: [
        TextButton(
            onPressed: () async {
              try {
                showdilog();
                await collectionReference.doc(id).delete();
                update();
                Get.back();
                Get.back();
                showbar('Delete Restaurant', '', 'Restaurant Deleted', true);
              } catch (e) {
                showbar('Delete service ', '', e.toString(), false);
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
