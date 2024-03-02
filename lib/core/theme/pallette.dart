// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';

abstract class AppPalette {
  static const white = Colors.white;
  static const tuna = Color(0xff38324E);
  static const gradients = _Gradients();
}

class _Gradients {
  const _Gradients();

  final main = const LinearGradient(
    colors: [
      Color(0xFFCF5EAF),
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
      Color.fromARGB(125, 233, 214, 107),
    ],
  );
}
