// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:taza_khabar/const/app_colors.dart';
import 'package:taza_khabar/view/login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Timer(
      Duration(
        seconds: 2,
      ),
      () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => LoginScreen(),
        ),
      ),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.amber,
        body: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'E-commerce',
                  style: TextStyle(
                    fontSize: 38,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 3,
                    shadows: [
                      Shadow(
                        color: Colors.grey,
                        blurRadius: 3,
                        offset: Offset(1, 1),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                CircularProgressIndicator(
                  color: Colors.black,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
