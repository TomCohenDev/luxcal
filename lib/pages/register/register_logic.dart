import 'package:flutter/material.dart';

import '../../backend/auth/auth_util.dart';
import '../nickname/nickname_view.dart';

Future<void> signUp(context, String email, String password, String name) async {
  final user = await createAccountWithEmail(
    context,
    email,
    password,
  );
  if (user == null) {
    return;
  }
  currentUserReference!.update({"display_name": name});

  navigateToNicknameWidget(context);
}

bool isFormValidated(formKey) {
  final isValid = formKey.currentState!.validate();
  if (!isValid) return false;
  return true;
}

void navigateToNicknameWidget(context) {
  Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(
      builder: (context) => NicknameWidget(),
    ),
    (r) => false,
  );
}
