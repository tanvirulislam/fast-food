// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class ThemeProvider with ChangeNotifier {
  ThemeMode themeMode = ThemeMode.light;
  bool get value {
    return themeMode == ThemeMode.light;
  }

  void toggleTheme(bool isON) {
    themeMode = isON ? ThemeMode.light : ThemeMode.dark;
    notifyListeners();
  }
}

class Mythemes {
  static final darkTheme = ThemeData(
      scaffoldBackgroundColor: Colors.black87,
      colorScheme: ColorScheme.dark(primary: Colors.cyan),
      iconTheme: IconThemeData(color: Colors.white),
      primaryColor: Colors.cyan,
      brightness: Brightness.dark,
      highlightColor: Colors.white,
      backgroundColor: Colors.black54,
      textSelectionTheme: TextSelectionThemeData(selectionColor: Colors.grey),
      // bottomNavigationBarTheme: BottomNavigationBarThemeData(
      //   backgroundColor: Colors.grey,
      //   selectedItemColor: Colors.cyan,
      //   unselectedItemColor: Colors.white.withOpacity(0.6),
      //   showSelectedLabels: false,
      //   showUnselectedLabels: false,
      // ),
      appBarTheme: AppBarTheme(
        color: Color.fromARGB(255, 49, 49, 49),
        elevation: 0,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          primary: Colors.grey,
          // textStyle: TextStyle(color: Colors.white),
        ),
      ),
      dividerColor: Colors.grey.shade100);

  static final lightTheme = ThemeData(
    scaffoldBackgroundColor: Colors.white,
    iconTheme: IconThemeData(color: Colors.black),
    backgroundColor: Colors.white,
    appBarTheme: AppBarTheme(color: Colors.grey.shade100, elevation: 0),
    textSelectionTheme: TextSelectionThemeData(
      selectionColor: Colors.grey,
      cursorColor: Color(0xff171d49),
      selectionHandleColor: Color(0xff005e91),
    ),
    primaryColor: Colors.cyan,
    brightness: Brightness.light,
    highlightColor: Colors.white,
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: Colors.lightBlue,
      focusColor: Colors.blueAccent,
      splashColor: Colors.lightBlue,
    ),
    colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.cyan)
        .copyWith(secondary: Colors.white),
    // bottomNavigationBarTheme: BottomNavigationBarThemeData(
    //   backgroundColor: Colors.grey,
    //   selectedItemColor: Colors.cyan,
    //   unselectedItemColor: Colors.black.withOpacity(0.6),
    //   showSelectedLabels: false,
    //   showUnselectedLabels: false,
    // ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        primary: Colors.grey.shade100,
      ),
    ),
  );
}
