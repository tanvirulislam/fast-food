// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taza_khabar/provider/cart_provider.dart';

class Count extends StatefulWidget {
  String cartId;
  String cartName;
  List cartImage;
  int cartPrice;
  int cartQty;

  Count({
    Key? key,
    required this.cartId,
    required this.cartName,
    required this.cartImage,
    required this.cartPrice,
    required this.cartQty,
  }) : super(key: key);

  @override
  State<Count> createState() => _CountState();
}

class _CountState extends State<Count> {
  CartProvider? _cartProvider;
  bool isBool = false;
  int count = 0;

  getCartIsAddAndQty() {
    FirebaseFirestore.instance
        .collection("reviewCart")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("item")
        .doc(widget.cartId)
        .get()
        .then(
          (value) => {
            // print(value.data()),
            if (mounted)
              {
                if (value.exists)
                  {
                    setState(() {
                      isBool = value.get("isAdd");
                      count = value.get('cartQty');
                    })
                  }
              }
          },
        );
  }

  @override
  void initState() {
    super.initState();
    getCartIsAddAndQty();
  }

  @override
  Widget build(BuildContext context) {
    _cartProvider = Provider.of<CartProvider>(context);
    return SizedBox(
      child: isBool == true
          ? Icon(Icons.shopping_cart)
          : InkWell(
              child: Icon(Icons.shopping_cart_outlined),
              onTap: () {
                setState(
                  () {
                    isBool = true;
                    // print(isBool);
                    if (isBool = true) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          duration: Duration(milliseconds: 500),
                          // backgroundColor: Colors.lightBlue,
                          backgroundColor: Theme.of(context).primaryColor,
                          content: Text(
                            'Item added',
                            style:
                                TextStyle(color: Theme.of(context).hintColor),
                          ),
                        ),
                      );
                    }
                    _cartProvider!.addToCart(
                      cartId: widget.cartId,
                      cartImage: widget.cartImage,
                      cartName: widget.cartName,
                      cartPrice: widget.cartPrice,
                      cartQty: widget.cartQty,
                    );
                    _cartProvider!.getCartItem();
                  },
                );
              },
            ),
    );
  }
}
