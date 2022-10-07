// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taza_khabar/google_sign/google_sign.dart';
// import 'package:taza_khabar/provider/category_provider.dart';
import 'package:taza_khabar/provider/user_provider.dart';
import 'package:taza_khabar/ui/login_screen.dart';
import 'package:taza_khabar/widget/custom_text_filed.dart';

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

  TextEditingController nameController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController quantityController = TextEditingController();
  TextEditingController imageController = TextEditingController();
  var key = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    UserProvider userProvider = Provider.of(context, listen: false);
    var userData = userProvider.currentData;
    // var userData2 = userProvider.currentData2;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          title: Text('Profile '),
          elevation: 0,
        ),
        body: ListView(
          children: [
            Container(
              alignment: Alignment.center,
              height: 160,
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
                      shape: BoxShape.circle,
                      border: Border.all(),
                    ),
                    child: Container(
                      height: 90,
                      width: 90,
                      decoration: BoxDecoration(
                        color: Theme.of(context).scaffoldBackgroundColor,
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(
                            userData.first.userImage,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 8),
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
                ],
              ),
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                key: key,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    customeTextField(
                      'Product name',
                      (value) {
                        if (value == null || value.isEmpty) {
                          return 'enter name';
                        }
                        return null;
                      },
                      nameController,
                      TextInputType.name,
                    ),
                    customeTextField(
                      'Product price',
                      (value) {
                        if (value == null || value.isEmpty) {
                          return 'enter price';
                        }
                        return null;
                      },
                      priceController,
                      TextInputType.number,
                    ),
                    customeTextField(
                      'Product quantity',
                      (value) {
                        if (value == null || value.isEmpty) {
                          return 'enter quantity';
                        }
                        return null;
                      },
                      quantityController,
                      TextInputType.number,
                    ),
                    Row(
                      children: [
                        Text('Select image'),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: InkWell(
                            onTap: () {},
                            child: Icon(
                              Icons.image,
                              size: 40,
                              color: Colors.cyan,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    Center(
                      child: ElevatedButton(
                        onPressed: () {
                          if (key.currentState!.validate()) {}
                        },
                        child: Text('submit'),
                        style: ElevatedButton.styleFrom(
                          primary: Colors.cyan,
                          padding: EdgeInsets.symmetric(
                            horizontal: 30,
                            vertical: 12,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Theme.of(context).primaryColor,
          onPressed: () {
            _authClass.logout();
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => LoginScreen(),
                ));
          },
          child: Icon(Icons.logout, color: Theme.of(context).hintColor),
        ),
      ),
    );
  }
}
