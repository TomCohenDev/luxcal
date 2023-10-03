import 'dart:io';

import 'package:email_validator/email_validator.dart';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:LuxCal/widgets/custom/model.dart';
import 'package:provider/provider.dart';
import 'package:email_validator/email_validator.dart';

class AddEventModel extends CustomModel {
  late DateTime startDate;
  late DateTime endDate;
  DateTime? startTime;
  DateTime? endTime;
  String title = "";
  String description = "";
  Color color = Colors.green;
  late FocusNode titleNode;
  late FocusNode descriptionNode;
  late FocusNode dateNode;
  final GlobalKey<FormState> formKey = GlobalKey();
  late TextEditingController startDateController;
  late TextEditingController startTimeController;
  late TextEditingController endTimeController;
  late TextEditingController endDateController;

  String imageUrl = ""; // To store the URL after uploading to Firebase Storage
  File? selectedImage; // To store the selected image

  void initState(BuildContext context) {
    titleNode = FocusNode();
    descriptionNode = FocusNode();
    dateNode = FocusNode();

    startDateController = TextEditingController();
    endDateController = TextEditingController();
    startTimeController = TextEditingController();
    endTimeController = TextEditingController();
  }

  void dispose() {
    titleNode.dispose();
    descriptionNode.dispose();
    dateNode.dispose();

    startDateController.dispose();
    endDateController.dispose();
    startTimeController.dispose();
    endTimeController.dispose();
  }

  /// Additional helper methods are added here.
}
