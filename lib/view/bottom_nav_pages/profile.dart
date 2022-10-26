// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_print

import 'package:cached_network_image/cached_network_image.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taza_khabar/google_sign/google_sign.dart';
import 'package:taza_khabar/provider/user_provider.dart';
import 'package:taza_khabar/view/login_screen.dart';

class NewProfile extends StatefulWidget {
  const NewProfile({Key? key}) : super(key: key);

  @override
  State<NewProfile> createState() => _NewProfileState();
}

class _NewProfileState extends State<NewProfile> {
  final AuthClass _authClass = AuthClass();

  @override
  void initState() {
    super.initState();
    UserProvider userProvider = Provider.of(context, listen: false);
    userProvider.getUserDataFirestore();
  }

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = Provider.of(context, listen: false);
    var userData = userProvider.currentData;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          title: Text(
            'Profile ',
            style: TextStyle(color: Colors.cyan),
          ),
          actions: [
            IconButton(
                onPressed: () {
                  _authClass.logout();
                  Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LoginScreen(),
                      ));
                },
                icon: Icon(
                  Icons.logout,
                  color: Colors.cyan,
                ))
          ],
          elevation: 0,
        ),
        body: ListView(
          children: [
            Container(
              alignment: Alignment.center,
              height: 155,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Theme.of(context).scaffoldBackgroundColor,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(52),
                  bottomRight: Radius.circular(52),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.cyan,
                    spreadRadius: 1,
                    blurRadius: 1,
                  ),
                ],
              ),
              child: Column(
                children: [
                  Container(
                    height: 91,
                    width: 91,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      border: Border.all(color: Theme.of(context).primaryColor),
                    ),
                    child: FancyShimmerImage(
                      height: 90,
                      width: 90,
                      boxDecoration: BoxDecoration(
                        shape: BoxShape.circle,
                      ),
                      boxFit: BoxFit.cover,
                      errorWidget: Center(child: Text('Image not Found')),
                      imageUrl: userData.first.userImage,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    userData.first.userName,
                    textScaleFactor: 1.2,
                    style: TextStyle(shadows: [
                      Shadow(
                        color: Colors.grey,
                        blurRadius: 3,
                        offset: Offset(1, 1),
                      )
                    ]),
                  ),
                  Text(
                    userData.first.userEmail,
                    textScaleFactor: 1.2,
                    style: TextStyle(shadows: [
                      Shadow(
                        color: Colors.grey,
                        blurRadius: 3,
                        offset: Offset(1, 1),
                      )
                    ]),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
