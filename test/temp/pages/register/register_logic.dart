import 'package:flutter/material.dart';

import '../../backend/auth/auth_util.dart';
import '../../utils/utils.dart';
import '../nickname/nickname_page.dart';

Future<void> signUp(context, model) async {
  if (!Utils.isFormValidated(model.formKey)) return;

  final user = await createAccountWithEmail(
    context,
    model.emailTextController!.text,
    model.passwordTextController!.text,
  );
  if (user == null) {
    return;
  }
  currentUserReference!
      .update({"display_name": model.nameTextController!.text});

  navigateToNicknameWidget(context);
}

void navigateToNicknameWidget(context) {
  Navigator.pushAndRemoveUntil(
    context,
    MaterialPageRoute(
      builder: (context) => const NicknameWidget(),
    ),
    (r) => false,
  );
}
