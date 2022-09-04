// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

Widget customButton(buttonText, onPressed) {
  return InkWell(
    onTap: onPressed,
    child: Container(
      width: 120,
      height: 45,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        gradient: LinearGradient(
          // ignore: prefer_const_literals_to_create_immutables
          colors: [Colors.purple, Colors.pink, Colors.blue],
        ),
      ),
      child: Center(
        child: Text(
         buttonText,
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
          ),
        ),
      ),
    ),
  );
}
