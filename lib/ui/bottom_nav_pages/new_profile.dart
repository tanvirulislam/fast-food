// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taza_khabar/google_sign/google_sign.dart';
import 'package:taza_khabar/provuder/user_provider.dart';
import 'package:taza_khabar/ui/login_screen.dart';

class NewProfile extends StatefulWidget {
  const NewProfile({Key? key}) : super(key: key);

  @override
  State<NewProfile> createState() => _NewProfileState();
}

class _NewProfileState extends State<NewProfile> {
  final AuthClass _authClass = AuthClass();

  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = Provider.of(context, listen: false);
    var userData = userProvider.currentData;
    userProvider.getUserDataFirestore();
    // var userData2 = userProvider.currentData2;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Profile '),
          elevation: 0,
        ),
        body: ListView(
          children: [
            Container(
              alignment: Alignment.center,
              height: 150,
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                  colors: [
                    Colors.white,
                    Colors.lightBlue,
                  ],
                ),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(52),
                  bottomRight: Radius.circular(52),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade400,
                    spreadRadius: 1,
                    blurRadius: 5,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Column(
                children: [
                  Container(
                    height: 90,
                    width: 90,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(
                          userData.first.userImage,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(userData.first.userName, textScaleFactor: 1.3)
                ],
              ),
            ),
            Column(
              children: userProvider.currentData2
                  .map((e) => Column(
                        children: [
                          ListTile(
                            leading: Icon(Icons.home),
                            title: e.address.isNotEmpty
                                ? Text(e.address)
                                : Text('No data'),
                          ),
                          ListTile(
                            leading: Icon(Icons.email),
                            title: Text(userData.first.userEmail),
                          ),
                          ListTile(
                            leading: Icon(Icons.phone),
                            title: e.phone.isEmpty
                                ? Text('No data')
                                : Text(e.phone),
                          ),
                          ListTile(
                            leading: Icon(Icons.people),
                            title:
                                e.age.isEmpty ? Text('No data') : Text(e.age),
                          ),
                        ],
                      ))
                  .toList(),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            _authClass.logout();
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => LoginScreen(),
                ));
          },
          child: Icon(Icons.logout),
        ),
      ),
    );
  }
}
