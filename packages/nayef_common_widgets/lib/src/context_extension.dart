import 'package:flutter/material.dart';

extension CommonContextExtension on BuildContext {
  ColorScheme get colorScheme => Theme.of(this).colorScheme;
  ThemeData get theme => Theme.of(this);
  Size get size => MediaQuery.of(this).size;
  double get deviceWidth => size.width;
  double get deviceHeight => size.height;
}
