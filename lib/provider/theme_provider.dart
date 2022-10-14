// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class Mythemes {
  static final darkTheme = ThemeData(
    scaffoldBackgroundColor: Colors.black,
    colorScheme: ColorScheme.dark(primary: Colors.cyan),
    iconTheme: IconThemeData(color: Colors.white),
    primaryColor: Color.fromARGB(255, 64, 228, 228),
    brightness: Brightness.dark,
    highlightColor: Colors.white,
    backgroundColor: Colors.black54,
    textSelectionTheme: TextSelectionThemeData(selectionColor: Colors.grey),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Colors.grey,
      selectedItemColor: Colors.cyan,
      unselectedItemColor: Colors.white.withOpacity(0.6),
      showSelectedLabels: false,
      showUnselectedLabels: false,
    ),
  );

  static final lightTheme = ThemeData(
    scaffoldBackgroundColor: Colors.white,
    iconTheme: IconThemeData(color: Colors.black),
    backgroundColor: Colors.white,
    appBarTheme: AppBarTheme(
      color: Colors.cyan,
    ),
    textSelectionTheme: TextSelectionThemeData(
      selectionColor: Colors.grey,
      cursorColor: Color(0xff171d49),
      selectionHandleColor: Color(0xff005e91),
    ),
    primaryColor: Colors.cyan,
    brightness: Brightness.light,
    highlightColor: Colors.white,
    floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: Colors.blue,
        focusColor: Colors.blueAccent,
        splashColor: Colors.lightBlue),
    colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.cyan)
        .copyWith(secondary: Colors.white),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Colors.grey,
      selectedItemColor: Colors.cyan,
      unselectedItemColor: Colors.black.withOpacity(0.6),
      showSelectedLabels: false,
      showUnselectedLabels: false,
    ),
  );
}
