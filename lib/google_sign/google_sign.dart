// ignore_for_file: prefer_const_constructors, avoid_print

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:taza_khabar/provider/user_provider.dart';
import 'package:taza_khabar/view/bottomNavController.dart';

class AuthClass {
  final GoogleSignIn _googleSignIn = GoogleSignIn(
      scopes: ['email', 'https://www.googleapis.com/auth/contacts.readonly']);
  FirebaseAuth auth = FirebaseAuth.instance;
  final storage = FlutterSecureStorage();

  Future<void> handleSignIn(BuildContext context) async {
    try {
      GoogleSignInAccount? googleSignInAccount = await _googleSignIn.signIn();

      if (googleSignInAccount != null) {
        // print('handleSignIn----------------');

        GoogleSignInAuthentication googleSignInAuthentication =
            await googleSignInAccount.authentication;
        AuthCredential credential = GoogleAuthProvider.credential(
          idToken: googleSignInAuthentication.idToken,
          accessToken: googleSignInAuthentication.accessToken,
        );
        User? user = (await auth.signInWithCredential(credential)).user;
        print("signed in----------- " + user!.email.toString());
        UserProvider userProvider = Provider.of(context, listen: false);
        userProvider.addUserData(
          currentUser: user,
          userEmail: user.email.toString(),
          userImage: user.photoURL.toString(),
          userName: user.displayName.toString(),
        );

        try {
          UserCredential userCredential =
              await auth.signInWithCredential(credential);
          storeToken(userCredential);
          // print(userCredential);

          Navigator.pushAndRemoveUntil(
            context,
            PageTransition(
              type: PageTransitionType.fade,
              child: BottomNavController(),
            ),
            (Route<dynamic> route) => false,
          );

          // Navigator.pushAndRemoveUntil(
          //   context,
          //   MaterialPageRoute(
          //     builder: (context) => BottomNavController(),
          //   ),
          //   (Route<dynamic> route) => false,
          // );
        } catch (e) {
          print(e);
        }
      } else {
        print('Sign in with googleSignInAccount-----------');
      }
    } catch (error) {
      print(error);
    }
  }

  Future<void> storeToken(UserCredential userCredential) async {
    await storage.write(
        key: 'token', value: userCredential.credential!.token.toString());
    await storage.write(
        key: 'userCredential', value: userCredential.toString());
  }

  Future<String?> getToken() async {
    return await storage.read(key: 'token');
  }

  Future<void> logout() async {
    try {
      await _googleSignIn.signOut();
      await auth.signOut();
      await storage.delete(key: 'token');
    } catch (e) {
      print(e.toString());
    }
  }
}
