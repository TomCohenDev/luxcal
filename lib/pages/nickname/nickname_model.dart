import 'package:email_validator/email_validator.dart';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:LuxCal/widgets/custom/model.dart';
import 'package:provider/provider.dart';
import 'package:email_validator/email_validator.dart';

class NicknameModel extends CustomModel {
  ///  State fields for stateful widgets in this page.

  // State field(s) for TextField widget.
  final formKey = GlobalKey<FormState>();

  late TextEditingController nicknameTextController;
  
  // State field(s) for TextField widget.
  Color? currentColor;
  String? currentColorText;

  /// Initialization and disposal methods.
  ///
  ///

  void initState(BuildContext context) {
    nicknameTextController = TextEditingController();
  }

  void dispose() {
    nicknameTextController.dispose();
  }

  /// Additional helper methods are added here.
}
