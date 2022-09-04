// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

Widget customeTextField(hintText, validator, controller) {
  return TextFormField(
    validator: validator,
    controller: controller,
    decoration: InputDecoration(
      hintText: hintText,
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.amber),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.blue),
      ),
    ),
    keyboardType: TextInputType.name,
  );
}
