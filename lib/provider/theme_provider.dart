// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class Mythemes {
  static final darkTheme = ThemeData(
    scaffoldBackgroundColor: Colors.black,
    colorScheme: ColorScheme.dark(),
    iconTheme: IconThemeData(color: Colors.white),
  );

  static final lightTheme = ThemeData(
    scaffoldBackgroundColor: Colors.white,
    colorScheme: ColorScheme.light(),
    iconTheme: IconThemeData(color: Colors.black),
    backgroundColor: Colors.white,
    buttonTheme: ButtonThemeData(buttonColor: Colors.blue),
  );
}
