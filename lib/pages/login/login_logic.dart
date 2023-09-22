import 'package:LuxCal/pages/home/home_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:LuxCal/pages/login/login_page.dart';

import '../../utils/utils.dart';
import '../register/register_page.dart';
import '../../widgets/route/route_widget.dart';
import 'login_model.dart';

void navigateToRegisterWidget(context) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => RegisterWidget(),
    ),
  );
}

void navigateToHomeWidget(context) {
  Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(
      builder: (context) => HomeWidget(),
    ),
    (r) => false,
  );
}

Future<void> signIn(context, LoginModel _model) async {
  if (!Utils.isFormValidated(_model.formKey)) return;

  try {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: _model.emailTextController.text.trim(),
      password: _model.passwordTextController.text.trim(),
    );
  } on FirebaseAuthException catch (e) {
    print(e.code);
    switch (e.code) {
      case 'network-request-failed':
        Utils.showSnackBar('Error: No internet connection');

        return null;

      case 'user-not-found':
        Utils.showSnackBar('Invalid credentials');

        return null;

      case 'unknown':
        Utils.showSnackBar('Please enter your email and password');

        Navigator.pop(context);
        return null;

      case 'invalid-email':
        Utils.showSnackBar('Please enter a valid email address');

        Navigator.pop(context);
        return null;

      case 'wrong-password':
        Utils.showSnackBar('Incorrect password');

        Navigator.pop(context);
        return null;

      default:
        Utils.showSnackBar(e.message);
    }
  }
}
