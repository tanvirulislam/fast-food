// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taza_khabar/provuder/cart_provider.dart';

class ProductOverview extends StatefulWidget {
  String name;
  int price;
  List image;
  String productDescription;
  String productId;
  ProductOverview(
      {Key? key,
      required this.name,
      required this.price,
      required this.image,
      required this.productDescription,
      required this.productId})
      : super(key: key);

  @override
  State<ProductOverview> createState() => _ProductOverviewState();
}

class _ProductOverviewState extends State<ProductOverview> {
  CartProvider? cartProvider;

  bool isBoolFavorite = false;
  bool isBoolCart = false;
  int count = 1;
  getAddAndQty() {
    FirebaseFirestore.instance
        .collection("users-cart-item")
        .doc(FirebaseAuth.instance.currentUser!.email)
        .collection("item")
        .doc(widget.productId)
        .get()
        .then(
          (value) => {
            // print(value.data()),
            if (mounted)
              {
                if (value.exists)
                  {
                    setState(() {
                      isBoolCart = value.get("isAdd");
                      count = value.get('cartQty');
                    })
                  }
              }
          },
        );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAddAndQty();
  }

  @override
  Widget build(BuildContext context) {
    cartProvider = Provider.of(context);
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.grey.shade200,
        appBar: AppBar(
          backgroundColor: Colors.grey.shade200,
          title: Text('Product Details'),
          actions: [
            InkWell(
                onTap: () {
                  setState(() {
                    isBoolFavorite = !isBoolFavorite;
                    print(isBoolFavorite);
                  });
                },
                child: isBoolFavorite == false
                    ? Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(Icons.favorite_outline),
                      )
                    : Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(Icons.favorite),
                      )),
            SizedBox(width: 10),
          ],
        ),
        body: ListView(
          children: [
            CarouselSlider(
                items: widget.image
                    .map((e) => Column(
                          children: [
                            Image.network(
                              e,
                              height: 200,
                              fit: BoxFit.cover,
                              width: double.infinity,
                            )
                          ],
                        ))
                    .toList(),
                options: CarouselOptions(
                  viewportFraction: 1,
                  height: 200,
                  autoPlay: true,
                )),
            SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.productDescription),
                  SizedBox(height: 8),
                  Text(
                    widget.name,
                    textScaleFactor: 1.5,
                    style: TextStyle(
                      fontWeight: FontWeight.normal,
                      color: Colors.lightBlue,
                      shadows: [
                        Shadow(
                          color: Colors.grey,
                          offset: Offset(0.0, 2.0),
                          blurRadius: 3.0,
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: Row(
                          children: [
                            Text('Quantity: ', textScaleFactor: 1.2),
                            TextButton(
                                onPressed: () {
                                  if (count > 1) {
                                    setState(() {
                                      count--;
                                    });
                                    cartProvider!.updateCart(
                                      cartId: widget.productId,
                                      cartImage: widget.image[0],
                                      cartName: widget.name,
                                      cartPrice: widget.price,
                                      cartQty: count,
                                    );
                                  }
                                },
                                child: Text('-', textScaleFactor: 1.7)),
                            Text(count.toString()),
                            TextButton(
                                onPressed: () {
                                  if (count < 10) {
                                    setState(() {
                                      count++;
                                    });
                                    cartProvider!.updateCart(
                                      cartId: widget.productId,
                                      cartImage: widget.image[0],
                                      cartName: widget.name,
                                      cartPrice: widget.price,
                                      cartQty: count,
                                    );
                                  }
                                },
                                child: Text('+', textScaleFactor: 1.5)),
                          ],
                        ),
                      ),
                      ElevatedButton.icon(
                        onPressed: () {
                          setState(() {
                            isBoolCart = !isBoolCart;
                          });
                          if (isBoolCart = true) {
                            cartProvider!.addToCart(
                              cartId: widget.productId,
                              cartImage: widget.image[0],
                              cartName: widget.name,
                              cartPrice: widget.price,
                              cartQty: count,
                            );
                          }
                        },
                        icon: isBoolCart == true
                            ? Icon(Icons.shopping_cart)
                            : Icon(Icons.shopping_cart_outlined),
                        label: isBoolCart == true
                            ? Text('Item added')
                            : Text('Add to cart'),
                        style: ElevatedButton.styleFrom(
                          primary: isBoolCart == false
                              ? Colors.lightBlue
                              : Colors.white,
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
