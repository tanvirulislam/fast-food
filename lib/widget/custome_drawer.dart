// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:taza_khabar/ui/bottomNavController.dart';
import 'package:taza_khabar/ui/bottom_nav_pages/cart_screen.dart';
import 'package:taza_khabar/ui/bottom_nav_pages/favourite.dart';
import 'package:taza_khabar/ui/bottom_nav_pages/profile.dart';

Widget drawerCustom(context) {
  return Container(
    width: MediaQuery.of(context).size.width / 1.3,
    color: Colors.grey[200],
    child: ListView(
      children: [
        DrawerHeader(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CircleAvatar(
                backgroundColor: Colors.transparent,
                radius: 40,
                child: Image.asset('assets/slider2.jpg'),
              ),
              // Column(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: [
              //     Text('Welcome guest'),
              //     SizedBox(
              //       height: 10,
              //     ),
              //     ElevatedButton(
              //       onPressed: () {},
              //       child: Text('Logout'),
              //     )
              //   ],
              // )
            ],
          ),
        ),
        InkWell(
            onTap: () => Navigator.push(context,
                MaterialPageRoute(builder: (context) => BottomNavController())),
            child: ListTile(
                leading: Icon(Icons.home, color: Colors.lightBlue),
                title: Text('Home'))),
        InkWell(
            onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CartScreen(),
                  ),
                ),
            child: ListTile(
                leading: Icon(Icons.shopping_cart, color: Colors.lightBlue),
                title: Text('Cart'))),
        InkWell(
            onTap: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Profile()));
            },
            child: ListTile(
                leading: Icon(Icons.person, color: Colors.lightBlue),
                title: Text('Profile'))),
        InkWell(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => Favourite(),
                ));
          },
          child: ListTile(
            leading: Icon(Icons.favorite, color: Colors.lightBlue),
            title: Text('WishList'),
          ),
        ),
        ListTile(
            leading: Icon(Icons.star_outlined, color: Colors.lightBlue),
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
