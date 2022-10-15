import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:taza_khabar/models/wishlist_model.dart';

class WishListProvider with ChangeNotifier {
  void addToWishlist({
    required String wishListId,
    required List wishListImage,
    required String wishListName,
    required int wishListPrice,
    required int wishListQty,
  }) {
    FirebaseFirestore.instance
        .collection('reviewWishList')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('item')
        .doc(wishListId)
        .set({
      'id': wishListId,
      'image': wishListImage,
      'name': wishListName,
      'price': wishListPrice,
      'quantity': wishListQty,
      'isAdd': true,
    });
  }

  // show wishlist---
  List<WishlistModel> wishlistDataList = [];
  showWishlist() async {
    List<WishlistModel> newList = [];
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('reviewWishList')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('item')
        .orderBy('name')
        .get();

    for (var element in querySnapshot.docs) {
      // print(element.data());
      WishlistModel wishlistModel = WishlistModel(
        wishListId: element.get('id'),
        wishListImage: element.get('image'),
        wishListName: element.get('name'),
        wishListPrice: element.get('price'),
        wishListQty: element.get('quantity'),
      );
      newList.add(wishlistModel);
    }
    wishlistDataList = newList;
    notifyListeners();
  }

  List<WishlistModel> get getWishlistData {
    return wishlistDataList;
  }

  // delete item---
  deleteItem(productId) {
    FirebaseFirestore.instance
        .collection('reviewWishList')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('item')
        .doc(productId)
        .delete();
    notifyListeners();
  }
}
