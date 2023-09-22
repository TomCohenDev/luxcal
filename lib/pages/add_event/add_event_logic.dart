import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

Widget imagePreview(File? selectedImage) {
  if (selectedImage == null) {
    return Text("No image selected.");
  }
  return Image.file(selectedImage);
}

Future<File?> pickImage() async {
  final picker = ImagePicker();
  final pickedFile = await picker.pickImage(source: ImageSource.gallery);
  if (pickedFile != null) {
    return File(pickedFile.path);
  }
  return null;
}

Future<String> uploadImageToFirebase(File imageFile, String eventID) async {
  FirebaseStorage storage = FirebaseStorage.instance;
  Reference ref = storage.ref().child('events/$eventID.png');
  UploadTask uploadTask = ref.putFile(imageFile);
  await uploadTask.whenComplete(() {});
  String downloadUrl = await ref.getDownloadURL();
  return downloadUrl;
}

bool isFormValidated(formKey) {
  final isValid = formKey.currentState!.validate();
  if (!isValid) return false;
  return true;
}
