// ignore_for_file: constant_identifier_names

import 'dart:ui';

import 'package:flutter/material.dart';
import 'dart:math' as math;

abstract class AppPalette {
  static const white = Colors.white;
  static const ultramarine_blue = Color(0xff514DFF);
  static const android_green = Color(0xff8CC63F);
  static const pink_lemonade = Color(0xffED1E79);
  static const butterscotch = Color(0xffFBB03B);
  static const black = Colors.black;
  static const gradients = _Gradients();
  static const grey = Colors.grey;
}

class _Gradients {
  const _Gradients();

  final main = const LinearGradient(
    colors: [
      Color(0xFFCF5EAF),
      // Color(0xFFF660AB),
      // Color(0xFFFF9966),
      Color(0xFFE9D66B),
    ],
  );
  final white = const LinearGradient(
    colors: [
      Colors.white,
      Colors.white,
    ],
  );
  final dry = const LinearGradient(
    colors: [
      Color.fromARGB(125, 207, 94, 175),
      // Color(0xFFF660AB),
      // Color(0xFFFF9966),
      Color.fromARGB(125, 233, 214, 107),
    ],
  );
  final transparent = const LinearGradient(
    colors: [Colors.transparent, Colors.transparent],
  );
}
