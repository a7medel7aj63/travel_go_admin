import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:travel_go/widgets/custom_textfield.dart';

import '../model/tourist_model.dart';
import '../widgets/loading.dart';
import '../widgets/snackbar.dart';

class TouristController extends GetxController {
  RxList<Tourist> tourist = RxList<Tourist>([]);
  late CollectionReference collectionReference;
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  late TextEditingController name, location, about;
  final ValueNotifier<bool> _loading = ValueNotifier(false);

  ValueNotifier<bool> get loading => _loading;

  @override
  void onInit() {
    var user = FirebaseAuth.instance.currentUser;
    collectionReference = firebaseFirestore.collection("tourist");
    name = TextEditingController();
    location = TextEditingController();
    about = TextEditingController();
    tourist.bindStream(getAllBanks());
    loading.value = true;
    super.onInit();
  }

  Stream<List<Tourist>> getAllBanks() => collectionReference
      .snapshots()
      .map((query) => query.docs.map((item) => Tourist.fromMap(item)).toList());

  String? validate(String value) {
    if (value.isEmpty) {
      return "this field can't be empty";
    }
    return null;
  }

  final ImagePicker _picker = ImagePicker();
  List<FilePickerResult?> image = [];

  void imageSelect() async {
    final FilePickerResult? selectedImage =
        await FilePicker.platform.pickFiles();
    if (selectedImage!.files.isNotEmpty) {
      image.clear();
      image.add(selectedImage);
      showbar('select image', 'subtitle', 'image selected', true);
      update();
    }
  }

  // final _pickedImages = [];
  // Future<void> _pickImage() async {
  //   final fromPicker = await ImagePickerPlugin;
  //   if (fromPicker != null) {
  //       _pickedImages.clear();
  //       _pickedImages.add(fromPicker);
  //       await uploadImageToFirebase();
  //       update();
  //   }
  // }
  late String image_url;

  Future uploadImageToFirebase() async {
    String fileName = basename(image[0]!.files.single.name);
    var file = image[0]!.files.single.bytes;
    Reference firebaseStorageRef =
        FirebaseStorage.instance.ref().child('images/$fileName');
    UploadTask uploadTask = firebaseStorageRef.putData(
        file!,
        SettableMetadata(
            contentType: 'image/${image[0]!.files.single.extension}'));
    TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => null);

    await taskSnapshot.ref.getDownloadURL().then(
          (value) => image_url = value,
        );
  }

  void addTourist(BuildContext context) {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    final data = MediaQuery.of(context);
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
                imageSelect();
              },
              child: Container(
                height: data.size.height * 0.20,
                width: data.size.width * 0.05,
                decoration: BoxDecoration(
                  color: Colors.black38,
                  borderRadius: BorderRadius.circular(46),
                ),
                child: image.isEmpty
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
              lable: 'Tourist area name',
              icon: const Icon(Icons.tour),
              input: TextInputType.text,
              secure: false,
            ),
            CustomTextField(
              controller: location,
              validator: (value) {
                return validate(value!);
              },
              lable: 'Tourist area location',
              icon: const Icon(Icons.location_on),
              input: TextInputType.text,
              secure: false,
            ),
            CustomTextField(
              controller: about,
              validator: (value) {
                return validate(value!);
              },
              lable: 'about the Tourist area',
              icon: const Icon(Icons.description),
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
                  if (image.isNotEmpty) {
                    showdilog();
                    await uploadImageToFirebase();
                    try {
                      var data = <String, dynamic>{
                        "name": name.text,
                        "location": location.text,
                        "about": about.text,
                        "image": image_url,
                      };
                      await collectionReference
                          .doc()
                          .set(data)
                          .whenComplete(() async {
                        name.clear();
                        location.clear();
                        about.clear();
                        Get.back();
                        image.clear();
                        showbar(
                            'title', 'subtitle', 'Tourist area Added', true);
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
              child: const Text("Add Tourist area"),
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

  void editTourist(String id, BuildContext context, String name1,
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
              lable: 'Tourist area name',
              icon: const Icon(Icons.tour),
              input: TextInputType.text,
              secure: false,
            ),
            CustomTextField(
              controller: location,
              validator: (value) {
                return validate(value!);
              },
              lable: ' Tourist area location ',
              icon: const Icon(Icons.location_on),
              input: TextInputType.text,
              secure: false,
            ),
            CustomTextField(
              controller: about,
              validator: (value) {
                return validate(value!);
              },
              lable: 'about the Tourist area',
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
                    showbar('title', 'subtitle', 'Tourist area Edited', true);
                    update();
                  });
                } catch (e) {
                  Get.back();
                  showbar('title', 'subtitle', e.toString(), false);
                }
              },
              child: const Text("Edit Tourist area"),
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

  void deleteTourist(String id) {
    Get.dialog(AlertDialog(
      content: const Text('Tourist area delete'),
      actions: [
        TextButton(
            onPressed: () async {
              try {
                showdilog();
                await collectionReference.doc(id).delete();
                update();
                Get.back();
                Get.back();
                showbar(
                    'Delete Tourist area', '', 'Tourist area Deleted', true);
              } catch (e) {
                showbar('Delete Tourist area ', '', e.toString(), false);
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
