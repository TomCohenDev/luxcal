import 'package:flutter/material.dart';

extension BuildContextX on BuildContext {

  Size get size => MediaQuery.of(this).size;

  ThemeData get theme => Theme.of(this);
  
  void pop<T>([T? result]) => Navigator.of(this).pop(result);
}