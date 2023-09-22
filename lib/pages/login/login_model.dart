import 'package:email_validator/email_validator.dart';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:LuxCal/widgets/custom/model.dart';
import 'package:provider/provider.dart';
import 'package:email_validator/email_validator.dart';

class LoginModel extends CustomModel {
  ///  State fields for stateful widgets in this page.

  // State field(s) for TextField widget.
  late TextEditingController emailTextController;
  late String? Function(String?) emailTextControllerValidator;
  // State field(s) for TextField widget.
  late TextEditingController passwordTextController;
  late String? Function(String?) passwordTextControllerValidator;
  final formKey = GlobalKey<FormState>();

  /// Initialization and disposal methods.
  ///
  ///

  void initState(BuildContext context) {
    emailTextController = TextEditingController();
    passwordTextController = TextEditingController();
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
    emailTextController.dispose();
    passwordTextController.dispose();
  }

  /// Additional helper methods are added here.
}
