import 'package:flutter/material.dart';

import '../route/route_widget.dart';

void navigateToRouteWidget(context) {
  Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => RouteWidget(),
      ),
      (route) => false);
}
