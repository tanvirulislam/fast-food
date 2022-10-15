// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taza_khabar/provider/user_provider.dart';
import 'package:taza_khabar/ui/add_products.dart';
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
                          // Container(
                          //   height: 100,
                          //   width: 100,
                          //   decoration: BoxDecoration(
                          //     shape: BoxShape.circle,
                          //     image: DecorationImage(
                          //       fit: BoxFit.cover,
                          //       image: NetworkImage(e.userImage),
                          //     ),
                          //   ),
                          // ),
                          CachedNetworkImage(
                            imageUrl: e.userImage,
                            progressIndicatorBuilder:
                                (context, url, downloadProgress) =>
                                    CircularProgressIndicator(
                                        value: downloadProgress.progress),
                            errorWidget: (context, url, error) =>
                                Icon(Icons.error),
                          ),
                          SizedBox(height: 4),
                          Text(e.userName)
                        ],
                      ))
                  .toList()),
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
        InkWell(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddProducts(),
                ));
          },
          child: ListTile(
              leading:
                  Icon(Icons.food_bank, color: Theme.of(context).hintColor),
              title: Text('Add Products')),
        ),
        SizedBox(
          height: 12,
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Contact support'),
              Divider(),
              Text('Contact us: 01756819542'),
              Text('Email us: tanvirul.cse.diu@gmail.com'),
            ],
          ),
        ),
      ],
    ),
  );
}
