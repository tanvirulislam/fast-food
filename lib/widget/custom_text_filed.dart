// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

Widget customeTextField(hintText, validator, controller, keyboardType) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 4),
    child: TextFormField(
      validator: validator,
      controller: controller,
      decoration: InputDecoration(
        hintText: hintText,
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.cyan),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.lightBlue),
        ),
      ),
      keyboardType: keyboardType,
    ),
  );
}
