// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:taza_khabar/google_sign/google_sign.dart';
import 'package:taza_khabar/provuder/user_provider.dart';
import 'package:taza_khabar/ui/regi_screen.dart';
import 'package:taza_khabar/ui/user_form.dart';
import 'package:taza_khabar/widget/custom_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();

  signIn() async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passController.text,
      );
      var authCredential = userCredential.user;
      print(authCredential!.uid);
      if (authCredential.uid.isNotEmpty) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => UserForm(),
          ),
        );
      } else {
        Fluttertoast.showToast(msg: 'Something is wrong');
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
        Fluttertoast.showToast(msg: 'No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
        Fluttertoast.showToast(msg: 'Wrong password provided for that user.');
      }
    }
  }

  final AuthClass _authClass = AuthClass();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // backgroundColor: Colors.white.withOpacity(.2),
        body: Form(
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * .1,
                ),
                Container(
                  height: 100,
                  alignment: Alignment.center,
                  child: Text(
                    'Sign In',
                    style: TextStyle(fontSize: 34, shadows: [
                      Shadow(
                        color: Colors.grey,
                        blurRadius: 5,
                        offset: Offset(2, 2),
                      )
                    ]),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: TextFormField(
                      validator: (val) {
                        if (val == null || val.isEmpty) {
                          return 'please enter email';
                        } else if (!val.contains('@')) {
                          return 'please enter valid email';
                        }
                        return null;
                      },
                      controller: _emailController,
                      style: TextStyle(
                          // color: Colors.black,
                          ),
                      decoration: InputDecoration(
                        labelText: 'Email',
                        filled: true,
                        // fillColor: Colors.white,
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.orange),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.lightBlue),
                        ),
                        suffixIcon: Icon(Icons.email),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: TextFormField(
                      controller: _passController,
                      obscureText: true,
                      style: TextStyle(
                          // color: Colors.black,
                          ),
                      decoration: InputDecoration(
                        labelText: 'Password',
                        filled: true,
                        // fillColor: Colors.white,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8)),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.orange),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.lightBlue),
                        ),
                        suffixIcon: Icon(Icons.lock),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 8),
                ElevatedButton(
                  onPressed: () => signIn(),
                  child: Text(
                    'Submit',
                    style: TextStyle(color: Theme.of(context).hintColor),
                  ),
                  style: ElevatedButton.styleFrom(
                    primary: Theme.of(context).primaryColor,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Text(
                    'OR',
                    textScaleFactor: 2,
                  ),
                ),
                InkWell(
                  onTap: () async {
                    await _authClass.handleSignIn(context);
                  },
                  child: SizedBox(
                    height: 65,
                    width: MediaQuery.of(context).size.width,
                    child: Card(
                      shape: RoundedRectangleBorder(
                        side: BorderSide(color: Colors.blue),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      color: Colors.transparent,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Image.asset('assets/google.png'),
                          Text(
                            'Continue with google',
                            style: TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have an account? ",
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => RegiScreen(),
                          ),
                        );
                      },
                      child: Text('Sign Up'),
                      style: TextButton.styleFrom(
                          primary: Theme.of(context).hintColor),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
