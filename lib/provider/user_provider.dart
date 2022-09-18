import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:taza_khabar/models/user_model.dart';

class UserProvider with ChangeNotifier {
  void addUserData({
    required User currentUser,
    required String userName,
    required String userImage,
    required String userEmail,
  }) async {
    await FirebaseFirestore.instance
        .collection("usersGoogleInfo")
        .doc(currentUser.uid)
        .set(
      {
        "userName": userName,
        "userEmail": userEmail,
        "userImage": userImage,
        "userUid": currentUser.uid,
      },
    );
  }

  List<UserModel> currentData = [];
  Future getUserData() async {
    List<UserModel> newList = [];
    var value = await FirebaseFirestore.instance
        .collection("usersGoogleInfo")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();
    if (value.exists) {
      // print(value.data());
      UserModel userModel = UserModel(
        userEmail: value.get("userEmail"),
        userImage: value.get("userImage"),
        userName: value.get("userName"),
        userUid: value.get("userUid"),
      );
      newList.add(userModel);
    }
    currentData = newList;
    notifyListeners();
    // return currentData;
  }

  List<UserModel> get currentUserData {
    return currentData;
  }

  // get data from collection(userData)---------

  List<UserModelFirestore> currentData2 = [];
  Future getUserDataFirestore() async {
    List<UserModelFirestore> newList2 = [];
    var value = await FirebaseFirestore.instance
        .collection("userData")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();
    if (value.exists) {
      print(value.data());
      UserModelFirestore userModelFirestore = UserModelFirestore(
        address: value.get('address'),
        phone: value.get('phone'),
        age: value.get('age'),
      );
      newList2.add(userModelFirestore);
    }
    currentData2 = newList2;
    notifyListeners();
    // return currentData2;
  }

  List<UserModelFirestore> get currentUserData2 {
    return currentData2;
  }
}
