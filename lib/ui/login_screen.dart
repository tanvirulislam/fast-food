// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:taza_khabar/google_sign/google_sign.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // final TextEditingController _emailController = TextEditingController();
  // final TextEditingController _passController = TextEditingController();
  // signIn() async {
  //   setState(() {
  //     isLoading = true;
  //   });
  //   try {
  //     UserCredential userCredential =
  //         await FirebaseAuth.instance.signInWithEmailAndPassword(
  //       email: _emailController.text,
  //       password: _passController.text,
  //     );
  //     var authCredential = userCredential.user;
  //     // print(authCredential!.uid);
  //     if (authCredential!.uid.isNotEmpty) {
  //       Navigator.push(
  //         context,
  //         MaterialPageRoute(
  //           builder: (_) => BottomNavController(),
  //         ),
  //       );
  //     } else {
  //       Fluttertoast.showToast(msg: 'Something is wrong');
  //     }
  //   } on FirebaseAuthException catch (e) {
  //     if (e.code == 'user-not-found') {
  //       // print('No user found for that email.');
  //       Fluttertoast.showToast(msg: 'No user found for that email.');
  //     } else if (e.code == 'wrong-password') {
  //       // print('Wrong password provided for that user.');
  //       Fluttertoast.showToast(msg: 'Wrong password provided for that user.');
  //     }
  //   }
  // }

  final AuthClass _authClass = AuthClass();
  bool isVisible = false;

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
          body: Form(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            // Padding(
            //   padding: const EdgeInsets.all(8.0),
            //   child: Center(
            //     child: TextFormField(
            //       validator: (val) {
            //         if (val == null || val.isEmpty) {
            //           return 'please enter email';
            //         } else if (!val.contains('@')) {
            //           return 'please enter valid email';
            //         }
            //         return null;
            //       },
            //       controller: _emailController,
            //       style: TextStyle(),
            //       decoration: InputDecoration(
            //         labelText: 'Email',
            //         filled: true,
            //         focusedBorder: OutlineInputBorder(
            //           borderSide: BorderSide(color: Colors.orange),
            //         ),
            //         enabledBorder: OutlineInputBorder(
            //           borderSide: BorderSide(color: Colors.lightBlue),
            //         ),
            //         suffixIcon: Icon(Icons.email),
            //       ),
            //     ),
            //   ),
            // ),
            // Padding(
            //   padding: const EdgeInsets.all(8.0),
            //   child: Center(
            //     child: TextFormField(
            //       controller: _passController,
            //       obscureText: isVisible ? false : true,
            //       style: TextStyle(),
            //       decoration: InputDecoration(
            //         labelText: 'Password',
            //         filled: true,
            //         border: OutlineInputBorder(
            //             borderRadius: BorderRadius.circular(8)),
            //         focusedBorder: OutlineInputBorder(
            //           borderSide: BorderSide(color: Colors.orange),
            //         ),
            //         enabledBorder: OutlineInputBorder(
            //           borderSide: BorderSide(color: Colors.lightBlue),
            //         ),
            //         suffixIcon: InkWell(
            //           onTap: () {
            //             setState(() {
            //               isVisible = !isVisible;
            //               print(isVisible);
            //             });
            //           },
            //           child: isVisible
            //               ? Icon(Icons.visibility_off)
            //               : Icon(Icons.visibility),
            //         ),
            //       ),
            //     ),
            //   ),
            // ),
            // SizedBox(height: 8),
            // ElevatedButton(
            //   onPressed: () => signIn(),
            //   child: Text(
            //     'Submit',
            //     style: TextStyle(color: Theme.of(context).hintColor),
            //   ),
            //   style: ElevatedButton.styleFrom(
            //     primary: Theme.of(context).primaryColor,
            //   ),
            // ),
            // Padding(
            //   padding: const EdgeInsets.symmetric(vertical: 10),
            //   child: Text(
            //     'OR',
            //     textScaleFactor: 2,
            //   ),
            // ),
            Text(
              'Fast Food',
              style: TextStyle(
                fontSize: 34,
                shadows: [
                  Shadow(
                    color: Colors.grey,
                    blurRadius: 4,
                    offset: Offset(2, 2),
                  ),
                ],
              ),
            ),
            Image.asset('assets/icon.png'),
            InkWell(
              onTap: () {
                _authClass.handleSignIn(context);
              },
              child: SizedBox(
                height: 65,
                width: MediaQuery.of(context).size.width,
                child: Card(
                  shape: RoundedRectangleBorder(
                    side: BorderSide(color: Colors.cyan),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Image.asset('assets/google.png'),
                      Text(
                        'Sign In with google',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.cyan,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // Row(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: [
            //     Text(
            //       "Don't have an account? ",
            //     ),
            //     TextButton(
            //       onPressed: () {
            //         Navigator.push(
            //           context,
            //           MaterialPageRoute(
            //             builder: (_) => RegiScreen(),
            //           ),
            //         );
            //       },
            //       child: Text('Sign Up'),
            //       style: TextButton.styleFrom(
            //           primary: Theme.of(context).hintColor),
            //     ),
            //   ],
            // ),
          ],
        ),
      )),
    );
  }
}
