// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taza_khabar/provider/user_provider.dart';
import 'package:taza_khabar/ui/bottomNavController.dart';
import 'package:taza_khabar/ui/bottom_nav_pages/cart_screen.dart';
import 'package:taza_khabar/ui/bottom_nav_pages/profile.dart';
import 'package:taza_khabar/ui/bottom_nav_pages/wishlist_screen.dart';

Widget drawerCustom(context) {
  UserProvider userProvider = Provider.of(context, listen: false);
  userProvider.getUserData();
  return Container(
    width: MediaQuery.of(context).size.width / 1.3,
    color: Theme.of(context).scaffoldBackgroundColor,
    child: ListView(
      children: [
        DrawerHeader(
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: userProvider.currentUserData
                  .map((e) => Column(
                        children: [
                          Container(
                            height: 100,
                            width: 100,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(e.userImage),
                              ),
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(e.userName)
                        ],
                      ))
                  .toList()
              // [

              // ],
              ),
        ),
        InkWell(
            onTap: () => Navigator.push(context,
                MaterialPageRoute(builder: (context) => BottomNavController())),
            child: ListTile(
                leading: Icon(Icons.home, color: Theme.of(context).hintColor),
                title: Text('Home'))),
        InkWell(
            onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CartScreen(),
                  ),
                ),
            child: ListTile(
                leading: Icon(Icons.shopping_cart,
                    color: Theme.of(context).hintColor),
                title: Text('Cart'))),
        InkWell(
            onTap: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => NewProfile()));
            },
            child: ListTile(
                leading: Icon(Icons.person, color: Theme.of(context).hintColor),
                title: Text('Profile'))),
        InkWell(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => WishList(),
                ));
          },
          child: ListTile(
            leading: Icon(Icons.favorite, color: Theme.of(context).hintColor),
            title: Text('WishList'),
          ),
        ),
        ListTile(
            leading:
                Icon(Icons.star_outlined, color: Theme.of(context).hintColor),
            title: Text('Rating')),
        SizedBox(
          height: 12,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text('Contact support'),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text('Contact us: 01756819542'),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text('Email us: tanvirul.cse.diu@gmail.com'),
        ),
      ],
    ),
  );
}
