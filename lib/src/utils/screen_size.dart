import 'package:flutter/material.dart';

class ScreenInfo {
  final BuildContext context;

  ScreenInfo(this.context);

  double get height => MediaQuery.of(context).size.height;
  double get width => MediaQuery.of(context).size.width;
}

extension SizeGetter on BuildContext {
  MediaQueryData get _mediaQueryData => MediaQuery.of(this);

  double get height => _mediaQueryData.size.height;
  double get width => _mediaQueryData.size.width;
}
