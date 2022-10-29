// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_print

import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
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
        // appBar: AppBar(
        //   automaticallyImplyLeading: false,
        //   backgroundColor: Colors.black,
        //   title: Text(
        //     'Profile ',
        //     style: TextStyle(color: Colors.white),
        //     // textScaleFactor: 1.2,
        //   ),
        //   actions: [
        //     IconButton(
        //       onPressed: () => _dialogBuilder(context),
        //       icon: Icon(
        //         Icons.logout,
        //         color: Colors.white,
        //       ),
        //     ),
        //   ],
        // ),
        body: ListView(
          children: [
            Container(
              alignment: Alignment.center,
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black,
                    Colors.cyan,
                  ],
                ),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(35),
                  bottomRight: Radius.circular(35),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey,
                    spreadRadius: 1,
                    blurRadius: 1,
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Profile ',
                          style: TextStyle(color: Colors.white),
                          textScaleFactor: 1.2,
                        ),
                        IconButton(
                          onPressed: () => _dialogBuilder(context),
                          icon: Icon(
                            Icons.logout,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(45),
                      child: FancyShimmerImage(
                        height: 90,
                        width: 90,
                        boxFit: BoxFit.cover,
                        errorWidget: Center(
                          child: Image.network(
                              'https://i0.wp.com/www.dobitaobyte.com.br/wp-content/uploads/2016/02/no_image.png?ssl=1'),
                        ),
                        imageUrl: userData.first.userImage,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      userData.first.userName,
                      // textScaleFactor: 1.2,
                      style: TextStyle(
                        color: Colors.white,
                        shadows: [
                          Shadow(
                            color: Colors.grey,
                            blurRadius: 3,
                            offset: Offset(1, 1),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 4),
                  ],
                ),
              ),
            ),
            SizedBox(height: 10),
            ListTile(
              leading: Icon(Icons.email),
              title: Text('Email'),
              subtitle: Text(
                userData.first.userEmail,
              ),
            ),
            ListTile(
              leading: Icon(Icons.shopping_bag),
              title: Text('My Order'),
              trailing: IconButton(
                onPressed: () {},
                icon: Icon(Icons.arrow_forward),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _dialogBuilder(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Log Out'),
          content: Text('Are you sure want to log out?'),
          actions: <Widget>[
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('No'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              style: TextButton.styleFrom(
                textStyle: Theme.of(context).textTheme.labelLarge,
              ),
              child: const Text('Yes'),
              onPressed: () {
                _authClass.logout();
                Navigator.pushReplacement(
                  context,
                  PageTransition(
                    child: LoginScreen(),
                    type: PageTransitionType.fade,
                  ),
                );
              },
            ),
          ],
        );
      },
    );
  }
}
