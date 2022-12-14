import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:taza_khabar/models/cart_model.dart';

class CartProvider with ChangeNotifier {
  // add to cart------
  void addToCart({
    required String cartId,
    required List cartImage,
    required String cartName,
    required int cartPrice,
    required int cartQty,
    required String cartDescription,
  }) {
    FirebaseFirestore.instance
        .collection('reviewCart')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('item')
        .doc(cartId)
        .set({
      'cartId': cartId,
      'image': cartImage,
      'name': cartName,
      'price': cartPrice,
      'cartQty': cartQty,
      'isAdd': true,
      'cartDescription': cartDescription,
    });
  }

  // update cart
  void updateCart({
    required String cartId,
    required List cartImage,
    required String cartName,
    // required String cartDescription,
    required int cartPrice,
    required int cartQty,
  }) {
    FirebaseFirestore.instance
        .collection('reviewCart')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('item')
        .doc(cartId)
        .update({
      'cartId': cartId,
      'image': cartImage,
      'name': cartName,
      'price': cartPrice,
      'cartQty': cartQty,
      'isAdd': true,
      // 'cartDescription': cartDescription,
    });
  }

  // delete single cart-----
  deleteCart(productId) {
    FirebaseFirestore.instance
        .collection('reviewCart')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('item')
        .doc(productId)
        .delete();
    notifyListeners();
  }

// delete all cart item
  deleteAllCart() async {
    var collection = await FirebaseFirestore.instance
        .collection('reviewCart')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('item')
        .get();
    for (var doc in collection.docs) {
      doc.reference.delete();
    }
  }

  // show cart items
  List<CartModel> cartDataList = [];
  getCartItem() async {
    List<CartModel> newList = [];
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('reviewCart')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('item')
        .orderBy('name')
        .get();

    for (var element in snapshot.docs) {
      // print(element.data());
      CartModel cartModel = CartModel(
        cartId: element.get('cartId'),
        cartImage: element.get('image'),
        cartName: element.get('name'),
        cartPrice: element.get('price'),
        cartQty: element.get('cartQty'),
        cartDescription: element.get('cartDescription'),
      );
      newList.add(cartModel);
    }
    cartDataList = newList;
    notifyListeners();
  }

  List<CartModel> get getCartDataList {
    return cartDataList;
  }

  // get total price
  getTotalPrice() {
    double total = 0;
    for (var element in cartDataList) {
      // print(element.cartPrice);
      total += element.cartPrice * element.cartQty;
      // print('total price ------ ${total}');
    }
    return total;
  }

  int counter = 0;
  getCounter() {
    return counter;
  }

  void incrementCounter() {
    counter++;
    notifyListeners();
  }
}
