// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:taza_khabar/provider/user_provider.dart';
import 'package:taza_khabar/view/add_products.dart';
import 'package:taza_khabar/view/bottom_nav_pages/cart_screen.dart';
import 'package:taza_khabar/view/bottom_nav_pages/profile.dart';
import 'package:taza_khabar/view/bottom_nav_pages/wishlist_screen.dart';

Widget drawerCustom(context) {
  UserProvider userProvider = Provider.of(context, listen: false);
  userProvider.getUserData();
  return SafeArea(
    child: Container(
      width: MediaQuery.of(context).size.width / 1.3,
      color: Theme.of(context).scaffoldBackgroundColor,
      child: ListView(
        children: [
          DrawerHeader(
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: userProvider.currentUserData
                    .map((e) => Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              height: 91,
                              width: 91,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                // shape: BoxShape.circle,
                                border: Border.all(
                                    color: Theme.of(context).primaryColor),
                              ),
                              child: FancyShimmerImage(
                                height: 90,
                                width: 90,
                                boxFit: BoxFit.cover,
                                errorWidget:
                                    Center(child: Text('Image not Found')),
                                imageUrl: e.userImage,
                              ),
                            ),
                            SizedBox(height: 4),
                            Text(e.userName)
                          ],
                        ))
                    .toList()),
          ),
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                PageTransition(
                  type: PageTransitionType.fade,
                  child: NewProfile(),
                ),
              );
            },
            child: ListTile(
                leading: Icon(Icons.person, color: Theme.of(context).hintColor),
                title: Text('Profile')),
          ),
          InkWell(
              onTap: () => Navigator.push(
                    context,
                    PageTransition(
                      type: PageTransitionType.fade,
                      child: CartScreen(),
                    ),
                  ),
              child: ListTile(
                  leading: Icon(Icons.shopping_cart,
                      color: Theme.of(context).hintColor),
                  title: Text('Cart'))),
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                PageTransition(
                  type: PageTransitionType.fade,
                  child: WishList(),
                ),
              );
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
          // InkWell(
          //   onTap: () {
          //     Navigator.push(
          //       context,
          //       PageTransition(
          //         type: PageTransitionType.fade,
          //         child: AddProducts(),
          //       ),
          //     );
          //   },
          //   child: ListTile(
          //       leading:
          //           Icon(Icons.food_bank, color: Theme.of(context).hintColor),
          //       title: Text('Add Products')),
          // ),
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
    ),
  );
}
