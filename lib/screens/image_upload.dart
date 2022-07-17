import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

import '../widgets/snackbar.dart';

class ImagePage {
  final ImagePicker _picker = ImagePicker();
  List<FilePickerResult?> image = [];

  dynamic imageSelect() async {
    final FilePickerResult? selectedImage =
        await FilePicker.platform.pickFiles();
    if (selectedImage!.files.isNotEmpty) {
      image.add(selectedImage);
      //image.clear();

      showbar('select image', 'subtitle', 'image selected', true);
    }
    return selectedImage as Future<dynamic>;
  }

  late String image_url;

  Future uploadImageToFirebase(FilePickerResult img) async {
    String fileName = basename(image[0]!.files.single.name);
    var file = image[0]!.files.single.bytes;
    Reference firebaseStorageRef =
        FirebaseStorage.instance.ref().child('images/$fileName');
    UploadTask uploadTask = firebaseStorageRef.putData(
        img!.files.single.bytes!,
        SettableMetadata(
            contentType: 'images/${image[0]!.files.single.extension}'));
    TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => null);

    await taskSnapshot.ref.getDownloadURL().then(
          (value) => image_url = value,
        );
  }
}
