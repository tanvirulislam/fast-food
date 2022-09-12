import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';

class CartProvider with ChangeNotifier {
  // add to cart------
  void addToCart({
    required String cartId,
    required String cartImage,
    required String cartName,
    required int cartPrice,
    required int cartQty,
  }) {
    FirebaseFirestore.instance
        .collection('users-cart-item')
        .doc(FirebaseAuth.instance.currentUser!.email)
        .collection('item')
        .doc(cartId)
        .set({
      'cartID': cartId,
      'image': cartImage,
      'name': cartName,
      'price': cartPrice,
      'cartQty': cartQty,
      'isAdd': true,
    });
  }

  // update cart
  void updateCart({
    required String cartId,
    required String cartImage,
    required String cartName,
    required int cartPrice,
    required int cartQty,
  }) {
    FirebaseFirestore.instance
        .collection('users-cart-item')
        .doc(FirebaseAuth.instance.currentUser!.email)
        .collection('item')
        .doc(cartId)
        .update({
      'cartID': cartId,
      'image': cartImage,
      'name': cartName,
      'price': cartPrice,
      'cartQty': cartQty,
      'isAdd': true,
    });
  }

  // delete cart-----
  deleteCart(productId) {
    FirebaseFirestore.instance
        .collection('users-cart-item')
        .doc(FirebaseAuth.instance.currentUser!.email)
        .collection('item')
        .doc(productId)
        .delete();
    notifyListeners();
  }
}
