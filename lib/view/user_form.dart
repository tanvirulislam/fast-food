// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, prefer_typing_uninitialized_variables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:taza_khabar/view/bottomNavController.dart';
import 'package:taza_khabar/widget/custom_button.dart';
import 'package:taza_khabar/widget/custom_text_filed.dart';

class UserForm extends StatefulWidget {
  const UserForm({Key? key}) : super(key: key);

  @override
  State<UserForm> createState() => _UserFormState();
}

class _UserFormState extends State<UserForm> {
  final _formKey = GlobalKey<FormState>();
  var address;
  var phone;
  var userGender;
  var age;
  var dob;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  final TextEditingController _genderController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  List<String> gender = ['Male', 'Female', 'Other'];

  Future _selectDate(context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime(DateTime.now().year - 20),
      firstDate: DateTime(DateTime.now().year - 30),
      lastDate: DateTime(DateTime.now().year),
    );
    if (picked == null) {
      print('error');
    } else {
      setState(() {
        _dobController.text = "${picked.day}/ ${picked.month}/ ${picked.year}";
      });
    }
  }

  Future addUser() async {
    CollectionReference users =
        FirebaseFirestore.instance.collection('userData');
    FirebaseAuth _auth = FirebaseAuth.instance;
    var currentuser = _auth.currentUser;
    return users
        .doc(currentuser!.uid)
        .set({
          'address': address,
          'phone': phone,
          // 'gender': userGender,
          'age': age,
          // 'date-of-birth': dob,
        })
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                Text(
                  'Submit the form to continue...',
                  style: TextStyle(
                    fontSize: 24,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        customeTextField(
                          "Enter your address",
                          (val) {
                            if (val == null || val.isEmpty) {
                              return 'please enter address';
                            }
                            return null;
                          },
                          _nameController,
                          TextInputType.name,
                        ),
                        SizedBox(height: 8),
                        customeTextField(
                          "Enter your phone number",
                          (val) {},
                          _phoneController,
                          TextInputType.phone,
                        ),
                        SizedBox(height: 8),
                        // TextFormField(
                        //   controller: _dobController,
                        //   readOnly: true,
                        //   decoration: InputDecoration(
                        //     enabledBorder: OutlineInputBorder(
                        //       borderSide: BorderSide(color: Colors.amber),
                        //     ),
                        //     focusedBorder: OutlineInputBorder(
                        //       borderSide: BorderSide(color: Colors.blue),
                        //     ),
                        //     hintText: 'Date of Birth',
                        //     suffixIcon: IconButton(
                        //       onPressed: () {
                        //         _selectDate(context);
                        //       },
                        //       icon: Icon(Icons.calendar_today),
                        //     ),
                        //   ),
                        // ),
                        // SizedBox(height: 8),
                        // TextFormField(
                        //   controller: _genderController,
                        //   readOnly: true,
                        //   decoration: InputDecoration(
                        //     enabledBorder: OutlineInputBorder(
                        //       borderSide: BorderSide(color: Colors.amber),
                        //     ),
                        //     focusedBorder: OutlineInputBorder(
                        //       borderSide: BorderSide(color: Colors.blue),
                        //     ),
                        //     hintText: 'choose your gender',
                        //     prefix: DropdownButton(
                        //       hint: Text('gender'),
                        //       items: gender.map((val) {
                        //         return DropdownMenuItem<String>(
                        //           value: val,
                        //           child: Text(val),
                        //           onTap: () {
                        //             setState(() {
                        //               _genderController.text = val;
                        //             });
                        //           },
                        //         );
                        //       }).toList(),
                        //       onChanged: (_) {},
                        //     ),
                        //   ),
                        // ),

                        SizedBox(height: 8),
                        // customeTextField(
                        //   "Enter your age",
                        //   (val) {},
                        //   _ageController,
                        //   TextInputType.number,
                        // ),
                        SizedBox(height: 8),
                        ElevatedButton.icon(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              setState(() {
                                address = _nameController.text;
                                phone = _phoneController.text;
                                userGender = _genderController.text;
                                age = _ageController.text;
                                dob = _dobController.text;
                                addUser();
                              });

                              Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        BottomNavController()),
                                (Route<dynamic> route) => false,
                              );
                            }
                          },
                          icon: Icon(
                            Icons.arrow_right_alt_outlined,
                            color: Theme.of(context).hintColor,
                          ),
                          label: Text(
                            'Continue',
                            style:
                                TextStyle(color: Theme.of(context).hintColor),
                          ),
                          style: ElevatedButton.styleFrom(
                            primary: Theme.of(context).primaryColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
