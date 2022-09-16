import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:taza_khabar/models/checkout_model.dart';

class CheckoutProvider with ChangeNotifier {
  TextEditingController firstName = TextEditingController();
  TextEditingController lastName = TextEditingController();
  TextEditingController mobile = TextEditingController();
  TextEditingController city = TextEditingController();
  TextEditingController area = TextEditingController();
  TextEditingController uId = TextEditingController();

  void addDeliveryAddress(
      // {required User currentUser}
      ) async {
    await FirebaseFirestore.instance
        .collection('shipping')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .set({
      'firstName': firstName.text,
      'lastName': lastName.text,
      'mobile': mobile.text,
      'city': city.text,
      'area': city.text,
      'shippingId': FirebaseAuth.instance.currentUser!.uid,
      // 'shippingId' : FirebaseAuth.instance.
    });
    // notifyListeners();
  }

  List<CheckoutModel> deliveryAddressData = [];
  getDeliveryAddress() async {
    List<CheckoutModel> newList = [];

    DocumentSnapshot qn = await FirebaseFirestore.instance
        .collection('shipping')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();

    if (qn.exists) {
      // print(qn.data());
      CheckoutModel deliveryAddressModel = CheckoutModel(
        firstName: qn.get('firstName'),
        lastName: qn.get('lastName'),
        mobile: qn.get('mobile'),
        city: qn.get('city'),
        area: qn.get('area'),
      );
      newList.add(deliveryAddressModel);
    }
    deliveryAddressData = newList;
    notifyListeners();
  }

  List<CheckoutModel> get getDeliveryAddressData {
    return deliveryAddressData;
  }
}
