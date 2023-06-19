import 'package:flutter/material.dart';

class Themes {
  static final secondaryColor = Colors.blue[800];

  static final light = ThemeData(
      useMaterial3: true,
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      scaffoldBackgroundColor: Colors.grey[50],
      primaryColor: Colors.orange.shade900,
      fontFamily: "Nunito");
}
