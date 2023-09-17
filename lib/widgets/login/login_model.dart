import 'package:email_validator/email_validator.dart';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:luxcal_app/widgets/custom/model.dart';
import 'package:provider/provider.dart';
import 'package:email_validator/email_validator.dart';

class LoginModel extends CustomModel {
  ///  State fields for stateful widgets in this page.

  // State field(s) for TextField widget.
  TextEditingController? emailTextController;
  String? Function(String?)? emailTextControllerValidator;
  // State field(s) for TextField widget.
  TextEditingController? passwordTextController;
  late bool passwordVisibility;
  String? Function(String?)? passwordTextControllerValidator;

  /// Initialization and disposal methods.
  ///
  ///

  bool isMediaUploading1 = false;

  void initState(BuildContext context) {
    passwordVisibility = false;
    emailTextControllerValidator = (email) =>
        email != null && !EmailValidator.validate(email)
            ? 'Enter a valid email'
            : null;
    passwordTextControllerValidator = (value) =>
        value != null && value.length < 6
            ? 'Password minimum length 6 charecters'
            : null;
  }

  void dispose() {
    emailTextController?.dispose();
    passwordTextController?.dispose();
  }

  /// Additional helper methods are added here.
}
