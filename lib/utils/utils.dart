import 'package:flutter/material.dart';

class Utils {
  static final messengerKey = GlobalKey<ScaffoldMessengerState>();

  static showSnackBar(String? text) {
    if (text == null) return;

    final snackBar = SnackBar(content: Text(text), backgroundColor: Colors.red);

    messengerKey.currentState!
      ..removeCurrentSnackBar()
      ..showSnackBar(snackBar);
  }

  static showSnackBarWithColor(String? text, Color? color) {
    if (text == null) return;

    final snackBar = SnackBar(content: Text(text), backgroundColor: color);

    messengerKey.currentState!
      ..removeCurrentSnackBar()
      ..showSnackBar(snackBar);
  }

  static String getColorString(String uncutString) {
    RegExp regExp = RegExp(r'Color\((0xff[0-9a-fA-F]{6})\)');
    Match? match = regExp.firstMatch(uncutString);

    if (match != null && match.groupCount > 0) {
      return match.group(1)!;
    } else {
      return '';
    }
  }

  static bool isFormValidated(formKey) {
    final isValid = formKey.currentState!.validate();
    if (!isValid) return false;
    return true;
  }
}
