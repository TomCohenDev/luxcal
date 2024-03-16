import 'package:LuxCal/pages/home/home_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../utils/utils.dart';
import '../register/register_page.dart';
import 'login_model.dart';

void navigateToRegisterWidget(context) {
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => const RegisterWidget(),
    ),
  );
}

void navigateToHomeWidget(context) {
  Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(
      builder: (context) => const HomeWidget(),
    ),
    (r) => false,
  );
}

Future<void> signIn(context, LoginModel model) async {
  if (!Utils.isFormValidated(model.formKey)) return;

  try {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: model.emailTextController.text.trim(),
      password: model.passwordTextController.text.trim(),
    );
  } on FirebaseAuthException catch (e) {
    print(e.code);
    switch (e.code) {
      case 'network-request-failed':
        Utils.showSnackBar('Error: No internet connection');

        return;

      case 'user-not-found':
        Utils.showSnackBar('Invalid credentials');

        return;

      case 'unknown':
        Utils.showSnackBar('Please enter your email and password');

        Navigator.pop(context);
        return;

      case 'invalid-email':
        Utils.showSnackBar('Please enter a valid email address');

        Navigator.pop(context);
        return;

      case 'wrong-password':
        Utils.showSnackBar('Incorrect password');

        Navigator.pop(context);
        return;

      default:
        Utils.showSnackBar(e.message);
    }
  }
}
