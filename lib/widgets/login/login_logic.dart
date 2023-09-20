import 'package:flutter/material.dart';
import 'package:luxcal_app/widgets/login/login_view.dart';

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
