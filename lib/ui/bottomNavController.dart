// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:taza_khabar/ui/bottom_nav_pages/profile.dart';
import 'package:taza_khabar/ui/bottom_nav_pages/cart_screen.dart';
import 'package:taza_khabar/ui/bottom_nav_pages/home.dart';
import 'package:taza_khabar/ui/bottom_nav_pages/wishlist_screen.dart';

class BottomNavController extends StatefulWidget {
  const BottomNavController({Key? key}) : super(key: key);

  @override
  State<BottomNavController> createState() => _BottomNavControllerState();
}

class _BottomNavControllerState extends State<BottomNavController> {
  final _pages = [Home(), CartScreen(), WishList(), NewProfile()];
  // ignore: non_constant_identifier_names
  int bottom_index_num = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: _pages[bottom_index_num],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: bottom_index_num,
          onTap: (val) {
            setState(() {
              bottom_index_num = val;
            });
          },
          selectedIconTheme: IconThemeData(
            color: Color.fromARGB(255, 64, 228, 228),
            size: 28,
          ),
          showSelectedLabels: false,
          showUnselectedLabels: false,
          unselectedItemColor: Theme.of(context).hintColor,
          // ignore: prefer_const_literals_to_create_immutables
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
              // backgroundColor: Colors.white.withOpacity(.4),
              backgroundColor: Theme.of(context).bottomAppBarColor,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart),
              label: 'Cart',
              backgroundColor: Theme.of(context).bottomAppBarColor,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite),
              label: 'Favorite',
              backgroundColor: Theme.of(context).bottomAppBarColor,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile',
              backgroundColor: Theme.of(context).bottomAppBarColor,
            ),
          ],
        ),
      ),
    );
  }
}
