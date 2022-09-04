// ignore_for_file: prefer_const_constructors

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:taza_khabar/google_sign/google_sign.dart';
import 'package:taza_khabar/ui/bottomNavController.dart';
import 'package:taza_khabar/ui/bottom_nav_pages/cart.dart';
import 'package:taza_khabar/ui/bottom_nav_pages/home.dart';
import 'package:taza_khabar/ui/bottom_nav_pages/profile.dart';
import 'package:taza_khabar/ui/login_screen.dart';
import 'package:taza_khabar/ui/splash_screen.dart';
import 'package:taza_khabar/ui/user_form.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // const MyApp({Key? key}) : super(key: key);
  Widget currentPage = SplashScreen();
  AuthClass authClass = AuthClass();

  @override
  void initState() {
    // TODO: implement initState
    checkLogin();
    super.initState();
  }

  Future<void> checkLogin() async {
    String? token = await authClass.getToken();
    if (token != null) {
      setState(() {
        currentPage = Cart();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // return ScreenUtilInit(
    //   designSize: ScreenUtil.defaultSize,
    //   builder: () {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Fast Food',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // home: BottomNavController(),
      // home: UserForm(),
      home: currentPage,
      // home: Home(),
      // home: Profile(),

      //   );
      // },
    );
  }
}
