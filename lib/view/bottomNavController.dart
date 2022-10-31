// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:taza_khabar/view/bottom_nav_pages/profile.dart';
import 'package:taza_khabar/view/bottom_nav_pages/cart_screen.dart';
import 'package:taza_khabar/view/bottom_nav_pages/home.dart';
import 'package:taza_khabar/view/bottom_nav_pages/wishlist_screen.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:double_back_to_close_app/double_back_to_close_app.dart';

class BottomNavController extends StatefulWidget {
  const BottomNavController({Key? key}) : super(key: key);

  @override
  State<BottomNavController> createState() => _BottomNavControllerState();
}

class _BottomNavControllerState extends State<BottomNavController> {
  PageController? _pageController;
  int _selectedIndex = 0;
  final List<Widget> _pages = [
    Home(),
    CartScreen(),
    WishList(),
    NewProfile(),
  ];
  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    super.dispose();
    _pageController!.dispose();
  }

  _onTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    _pageController!.jumpToPage(index);
  }

  void onPageChanged(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: PageView(
          children: _pages,
          controller: _pageController,
          onPageChanged: onPageChanged,
        ),
        bottomNavigationBar: DoubleBackToCloseApp(
          snackBar: SnackBar(
            backgroundColor: Theme.of(context).primaryColor,
            content: Text('Tap back again to leave'),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 3),
            child: GNav(
                selectedIndex: _selectedIndex,
                onTabChange: _onTapped,
                rippleColor: Colors.cyan,
                curve: Curves.linear,
                duration: Duration(milliseconds: 500),
                gap: 8,
                color: Colors.grey[800],
                activeColor: Colors.cyan,
                iconSize: 24,
                tabBackgroundColor: Colors.grey.withOpacity(0.2),
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                tabs: [
                  GButton(
                    icon: LineIcons.home,
                    text: 'Home',
                    margin: EdgeInsets.symmetric(vertical: 5),
                  ),
                  GButton(
                    icon: LineIcons.shoppingCart,
                    text: 'Cart',
                    margin: EdgeInsets.symmetric(vertical: 5),
                  ),
                  GButton(
                    icon: LineIcons.heart,
                    text: 'Favorite',
                    margin: EdgeInsets.symmetric(vertical: 5),
                  ),
                  GButton(
                    icon: LineIcons.user,
                    text: 'Profile',
                    margin: EdgeInsets.symmetric(vertical: 5),
                  )
                ]),
          ),
        ),
      ),
    );
  }
}
