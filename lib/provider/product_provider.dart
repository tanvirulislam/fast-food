// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:taza_khabar/models/product_model.dart';

class ProdcutProvider with ChangeNotifier {
  List<ProductModel> getProductList = [];
  List<ProductModel> search = [];
  fatchProductData() async {
    List<ProductModel> newList = [];

    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('products').get();

    for (var element in querySnapshot.docs) {
      print(element.data());
      ProductModel productModel = ProductModel(
        productName: element.get('product-name'),
        productImage: element.get('product-img'),
        productPrice: element.get('product-price'),
        productDescription: element.get('product-dsrp'),
        productId: element.get('productId'),
      );
      newList.add(productModel);
      search.add(productModel);
    }
    getProductList = newList;
    notifyListeners();
  }

  List<ProductModel> get getProductData {
    return getProductList;
  }

  // get search product
  List<ProductModel> get getSearchProductList {
    return search;
  }
}
