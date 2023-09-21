import 'package:LuxCal/widgets/home/home_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:LuxCal/widgets/login/login_view.dart';

import '../../utils/utils.dart';
import '../register/register_view.dart';
import '../route/route_widget.dart';

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

bool isFormValidated(formKey) {
  final isValid = formKey.currentState!.validate();
  if (!isValid) return false;
  return true;
}

Future<void> signIn(context, String email, String password) async {
  try {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
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
