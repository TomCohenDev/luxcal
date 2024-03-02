import 'dart:io';

import 'package:LuxCal/pages/add_event/add_event_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../../backend/auth/auth_util.dart';
import '../../backend/records/event_record.dart';
import '../../utils/utils.dart';

TimeOfDay addHours(TimeOfDay time, int hoursToAdd) {
  int newHour = time.hour + hoursToAdd;
  if (newHour >= 24) newHour -= 24;
  return TimeOfDay(hour: newHour, minute: time.minute);
}

Future<TimeOfDay> selectTime(BuildContext context) async {
  print("Entering _selectTime"); // Debug print
  final TimeOfDay? pickedTime = await showTimePicker(
    context: context,
    initialTime: addHours(TimeOfDay.now(), 3),
  );

  if (pickedTime != null) {
    return pickedTime;
    // Handle the time picked here.
  } else {
    return const TimeOfDay(hour: 0, minute: 0);
  }
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

createEvent(context, AddEventModel model, onAddEvet) async {
  if (!Utils.isFormValidated(model.formKey)) return;

  model.formKey.currentState?.save();



  Navigator.pop(context);


  Map<String, dynamic> eventData = createEventRecordData(
      title: model.title,
      startdate: model.startDate,
      // starttime: event.date,
      color: Utils.getColorString(model.color.toString()),
      created_date: DateTime.now(),
      enddate: model.endDate,
      // endtime: event.endDate,
      description: model.description,
      event_creator: currentUserDocument!.uid);

  DocumentReference eventRef = await EventRecord.collection.add(eventData);

  if (model.selectedImage != null) {
    model.imageUrl =
        await uploadImageToFirebase(model.selectedImage!, eventRef.id);
  }
  eventRef.update({"imageUrl": model.imageUrl});

  resetForm(model);
}

void resetForm(AddEventModel model) {
  model.formKey.currentState?.reset();
}
