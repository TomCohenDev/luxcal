import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

class MediaUtils {
  static Future<String?> pickImageFromGallery() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      return pickedFile.path;
    }
    return null;
  }

  static Future<String?> takePicture() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      return pickedFile.path;
    }
    return null;
  }

  static Future<String> saveUserImageToDirectory(
      String imagePath, String uid) async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final file = File('${directory.path}/user_images/user_image_$uid.png');

      // Create the directory if it doesn't exist
      final imagesDirectory = Directory('${directory.path}/user_images');
      if (!await imagesDirectory.exists()) {
        await imagesDirectory.create(recursive: true);
      }

      // Copy the image to the specified directory with the desired filename
      await file.writeAsBytes(await File(imagePath).readAsBytes());
      print('Image saved successfully to: ${file.path}');
      return file.path; // Return the file path
    } catch (e) {
      print('Error saving image: $e');
      return Future.error('Error saving image: $e');
    }
  }

  static Future<String> saveUserFaceBase64ImageToDirectory(
      String base64imageString, String uid) async {
    try {
      final directory = await getApplicationDocumentsDirectory();
      final imagesDirectory = Directory('${directory.path}/user_images');

      // Create the directory if it doesn't exist
      if (!await imagesDirectory.exists()) {
        await imagesDirectory.create(recursive: true);
      }

      final file = File('${imagesDirectory.path}/user_face_base64_image_$uid.txt');

      // Write the base64 string to the file
      await file.writeAsString(base64imageString);
      print('Image base64 saved successfully to: ${file.path}');
      return file.path; // Return the file path
    } catch (e) {
      print('Error saving image base64: $e');
      return Future.error('Error saving image base64: $e');
    }
  }
}
