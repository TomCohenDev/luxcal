import 'package:email_validator/email_validator.dart';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:LuxCal/widgets/custom/model.dart';
import 'package:provider/provider.dart';
import 'package:email_validator/email_validator.dart';

class RegisterModel extends CustomModel {
  ///  State fields for stateful widgets in this page.

  TextEditingController? nameTextController;
  String? Function(String?)? nameTextControllerValidator;
  // State field(s) for TextField widget.
  TextEditingController? emailTextController;
  String? Function(String?)? emailTextControllerValidator;

  //   TextEditingController? emailTextController;
  // String? Function(String?)? emailTextControllerValidator;
  // State field(s) for TextField widget.
  TextEditingController? passwordTextController;
  String? Function(String?)? passwordTextControllerValidator;

  TextEditingController? confirmPasswordController;
  String? Function(String?)? confirmPasswordControllerValidator;

  /// Initialization and disposal methods.
  ///
  ///

  bool isMediaUploading1 = false;

  void initState(BuildContext context) {
    nameTextController ??= TextEditingController();
    emailTextController ??= TextEditingController();
    passwordTextController ??= TextEditingController();
    confirmPasswordController ??= TextEditingController();

    nameTextControllerValidator = (name) =>
        name == null || nameTextController!.text == ""
            ? 'You must enter a name'
            : null;

    emailTextControllerValidator = (email) =>
        email != null && !EmailValidator.validate(email)
            ? 'Enter a valid email'
            : null;
    passwordTextControllerValidator = (value) =>
        value != null && value.length < 6
            ? 'Password minimum length 6 charecters'
            : null;

    confirmPasswordControllerValidator = (value) => value != null &&
            passwordTextController!.text != confirmPasswordController!.text
        ? 'Passwords do not match'
        : null;
  }

  void dispose() {
    nameTextController?.dispose();
    emailTextController?.dispose();
    passwordTextController?.dispose();
    confirmPasswordController?.dispose();
  }

  /// Additional helper methods are added here.
}
