import 'dart:io';
import 'package:image_picker/image_picker.dart';

class ImageHelper {
  static File? selectedImage;
  static Future<File?> pickImageFromCamera() async {
    final returnedImage =
        await ImagePicker().pickImage(source: ImageSource.camera);
    if (returnedImage != null) {
      selectedImage = File(returnedImage.path);
      return selectedImage;
    } else {
      return null;
    }
  }

  static Future<File?> pickImageFromGallery() async {
    final returnedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (returnedImage != null) {
      selectedImage = File(returnedImage.path);
      return selectedImage;
    } else {
      return null;
    }
  }
}
