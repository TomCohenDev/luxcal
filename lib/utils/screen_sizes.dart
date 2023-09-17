import 'package:flutter/material.dart';

class ScreenInfo {
  final BuildContext context;

  ScreenInfo(this.context);

  double get screenHeight => MediaQuery.of(context).size.height;
  double get screenWidth => MediaQuery.of(context).size.width;
}
