// ignore_for_file: prefer_const_constructors

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:provider/provider.dart';
import 'package:taza_khabar/google_sign/google_sign.dart';
import 'package:taza_khabar/provider/cart_provider.dart';
import 'package:taza_khabar/provider/category_provider.dart';
import 'package:taza_khabar/provider/checkout_provider.dart';
import 'package:taza_khabar/provider/product_provider.dart';
import 'package:taza_khabar/provider/theme_provider.dart';
import 'package:taza_khabar/provider/user_provider.dart';
import 'package:taza_khabar/provider/wishlist_provider.dart';
import 'package:taza_khabar/test.dart';
import 'package:taza_khabar/view/bottomNavController.dart';
import 'package:taza_khabar/view/login_screen.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter_native_splash/flutter_native_splash.dart';

void main() async {
  // WidgetsFlutterBinding.ensureInitialized();
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  if (kIsWeb) {
    await Firebase.initializeApp(
      options: FirebaseOptions(
        apiKey: "AIzaSyDfubViNbn6hkRxHiETd3-5SS3e4E06B38",
        projectId: "taza-khabar-8666d",
        messagingSenderId: "711924074598",
        appId: "1:711924074598:android:676b2cd4f6a0f8338685a7",
      ),
    );
  } else {
    await Firebase.initializeApp();
  }
  // await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Widget currentPage = LoginScreen();
  AuthClass authClass = AuthClass();
  Future<void> checkLogin() async {
    String? token = await authClass.getToken();
    if (token != null) {
      setState(() {
        currentPage = BottomNavController();
      });
    }
  }

  void initialization() async {
    await Future.delayed(const Duration(seconds: 2));
    // print('go!');
    FlutterNativeSplash.remove();
  }

  @override
  void initState() {
    checkLogin();
    super.initState();
    initialization();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ProdcutProvider>(
          create: (context) => ProdcutProvider(),
        ),
        ChangeNotifierProvider<CartProvider>(
          create: (context) => CartProvider(),
        ),
        ChangeNotifierProvider<WishListProvider>(
          create: (context) => WishListProvider(),
        ),
        ChangeNotifierProvider<CheckoutProvider>(
          create: (context) => CheckoutProvider(),
        ),
        ChangeNotifierProvider<UserProvider>(
          create: (context) => UserProvider(),
        ),
        ChangeNotifierProvider<CategoryProvider>(
          create: (context) => CategoryProvider(),
        ),
        ChangeNotifierProvider<ThemeProvider>(
          create: (context) => ThemeProvider(),
        ),
      ],
      child: OverlaySupport.global(
        child: Builder(builder: (context) {
          ThemeProvider themeProvider = Provider.of<ThemeProvider>(context);
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Fast Food',
            // themeMode: ThemeMode.system,
            themeMode: themeProvider.themeMode,
            theme: Mythemes.lightTheme,
            darkTheme: Mythemes.darkTheme,
            home: currentPage,
          );
        }),
      ),
    );
  }
}
