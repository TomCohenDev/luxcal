import 'package:flutter/material.dart';
import 'package:LuxCal/pages/login/login_page.dart';


void navigateToLoginWidget(context) {
  Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => const LoginWidget(),
      ),
      (route) => false);
}
