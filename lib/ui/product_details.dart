// ignore_for_file: prefer_const_constructors

import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:taza_khabar/widget/custom_button.dart';

class ProductDetails extends StatefulWidget {
  var _product;
  ProductDetails(this._product, {Key? key}) : super(key: key);

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  Future<void> addToCart() async {
    FirebaseAuth _auth = FirebaseAuth.instance;
    var currentuser = _auth.currentUser;
    CollectionReference collectionReference =
        FirebaseFirestore.instance.collection('users-cart-item');
    return collectionReference
        .doc(currentuser!.email)
        .collection('item')
        .doc()
        .set({
      'name': widget._product['product-name'],
      'price': widget._product['product-price'],
      'image': widget._product['product-img'],
    });
  }

  Future<void> addToFavorite() async {
    FirebaseAuth _auth = FirebaseAuth.instance;
    var currentuser = _auth.currentUser;
    CollectionReference collectionReference =
        FirebaseFirestore.instance.collection('users-favorite-item');
    return collectionReference
        .doc(currentuser!.email)
        .collection('item')
        .doc()
        .set({
      'name': widget._product['product-name'],
      'price': widget._product['product-price'],
      'image': widget._product['product-img'],
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.grey,
          title: Text('Product details'),
          actions: [
            StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('users-favorite-item')
                  .doc(FirebaseAuth.instance.currentUser!.email)
                  .collection('item')
                  .where('name', isEqualTo: widget._product['product-name'])
                  .snapshots(),
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                if (snapshot.hasData == null) {
                  return Text('');
                }

                return CircleAvatar(
                  backgroundColor: Colors.white,
                  child: IconButton(
                      onPressed: () {
                        addToFavorite();
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            backgroundColor: Colors.lightBlue,
                            content: Text('Added to favorite'),
                          ),
                        );
                      },
                      icon: Icon(
                        Icons.favorite_outline,
                        color: Colors.amber,
                      )),
                );
              },
            ),
            SizedBox(
              width: 8,
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              AspectRatio(
                aspectRatio: 3.5,
                child: CarouselSlider(
                  items: widget._product['product-img']
                      .map<Widget>((item) => Container(
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: NetworkImage(item),
                                    fit: BoxFit.fitWidth)),
                          ))
                      .toList(),
                  options: CarouselOptions(
                    height: 400,
                    aspectRatio: 16 / 9,
                    viewportFraction: 0.8,
                    initialPage: 0,
                    enableInfiniteScroll: true,
                    reverse: false,
                    autoPlay: true,
                    autoPlayInterval: Duration(seconds: 3),
                    autoPlayAnimationDuration: Duration(milliseconds: 800),
                    autoPlayCurve: Curves.fastOutSlowIn,
                    enlargeCenterPage: true,
                  ),
                ),
              ),
              Text(
                widget._product['product-name'],
                textScaleFactor: 2,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: Text(widget._product['product-dsrp']),
              ),
              Text(
                "TK ${widget._product['product-price']}",
                textScaleFactor: 2,
              ),
              SizedBox(height: 8,),
              customButton(
                'Add to cart',
                () {
                  addToCart();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      backgroundColor: Colors.lightBlue,
                      content: Text('Added to cart'),
                    ),
                  );
                },
              ),
             
            ],
          ),
        ),
      ),
    );
  }
}
