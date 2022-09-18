import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:taza_khabar/models/category_model.dart';

class CategoryProvider with ChangeNotifier {
  List<CategoryModel> getCategoryList = [];
  fatchCategoryData() async {
    List<CategoryModel> newList = [];

    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('categories').get();

    for (var element in querySnapshot.docs) {
      // print(element.data());
      CategoryModel categoryModel = CategoryModel(
        categoryId: element.get('categoryId'),
        categoryName: element.get('categoryName'),
        categoryImage: element.get('categoryImage'),
      );

      newList.add(categoryModel);
    }
    getCategoryList = newList;
    notifyListeners();
  }

  List<CategoryModel> get getCategoryData {
    return getCategoryList;
  }

  List<CategoryModel> getCategoryProductList = [];
  fatchCategoryProductData(categoryId) async {
    List<CategoryModel> newList = [];
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('reviewCart')
        .doc(categoryId)
        .collection('sn1')
        .orderBy('name', descending: false)
        .get();

    for (var element in snapshot.docs) {
      print(element.data());
      CategoryModel categoryModel = CategoryModel(
        categoryId: element.get('categoryId'),
        categoryName: element.get('categoryName'),
        categoryImage: '',
      );

      newList.add(categoryModel);
    }
    getCategoryProductList = newList;
    notifyListeners();
  }

  List<CategoryModel> get getCategoryProductData {
    return getCategoryList;
  }
}
