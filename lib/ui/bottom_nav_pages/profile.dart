// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:taza_khabar/google_sign/google_sign.dart';
import 'package:taza_khabar/ui/splash_screen.dart';
import 'package:taza_khabar/widget/custom_button.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  TextEditingController? _nameController;
  TextEditingController? _phoneController;
  TextEditingController? _ageController;

  updateInfo() {
    CollectionReference _updateInfo =
        FirebaseFirestore.instance.collection('user-data');
    return _updateInfo
        .doc(FirebaseAuth.instance.currentUser!.email)
        .update({
          'name': _nameController!.text,
          'phone': _phoneController!.text,
          'age': _ageController!.text,
        })
        .then((value) => print("User Updated"))
        .catchError((error) => print("Failed to update user: $error"));
  }

  AuthClass authClass = AuthClass();
  final storage = const FlutterSecureStorage();

  setDataToTextField(data) {
    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 15),
          child: Text(
            'Update Your Profile',
            style: TextStyle(shadows: [
              Shadow(
                color: Colors.grey,
                offset: Offset(2, 2),
                blurRadius: 6,
              )
            ]),
            textScaleFactor: 2,
          ),
        ),
        TextFormField(
          controller: _nameController =
              TextEditingController(text: data?['name']),
          decoration: InputDecoration(
            labelText: 'Name',
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.amber),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.blue),
            ),
          ),
        ),
        SizedBox(height: 8),
        TextFormField(
          controller: _phoneController =
              TextEditingController(text: data?['phone']),
          decoration: InputDecoration(
            labelText: 'Phone',
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.amber),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.blue),
            ),
          ),
        ),
        SizedBox(height: 8),
        TextFormField(
          controller: _ageController =
              TextEditingController(text: data?['age']),
          decoration: InputDecoration(
            labelText: 'age',
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.amber),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.blue),
            ),
          ),
        ),
        SizedBox(height: 18),
        customButton('Update', () {
          updateInfo();
        }),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('user-data')
                .doc(FirebaseAuth.instance.currentUser!.email)
                .snapshots(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              var data = snapshot.data;
              return setDataToTextField(data);
            },
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            await authClass.logout();
          },
          child: Icon(Icons.logout_outlined),
          backgroundColor: Colors.lightBlue,
        ),
      ),
    );
  }
}
