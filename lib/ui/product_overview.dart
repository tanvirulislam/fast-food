// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taza_khabar/provuder/cart_provider.dart';
import 'package:taza_khabar/provuder/wishlist_provider.dart';
import 'package:taza_khabar/ui/bottom_nav_pages/cart_screen.dart';
import 'package:taza_khabar/ui/bottom_nav_pages/wishlist.dart';

class ProductOverview extends StatefulWidget {
  String name;
  int price;
  List image;
  String productDescription;
  String productId;
  ProductOverview({
    Key? key,
    required this.name,
    required this.price,
    required this.image,
    required this.productDescription,
    required this.productId,
  }) : super(key: key);

  @override
  State<ProductOverview> createState() => _ProductOverviewState();
}

class _ProductOverviewState extends State<ProductOverview> {
  CartProvider? cartProvider;
  WishListProvider? wishlistProvider;

  bool isBoolWishlist = false;
  bool isBoolCart = false;
  int count = 1;
  getCartIsAddAndQty() {
    FirebaseFirestore.instance
        .collection("reviewCart")
        .doc(FirebaseAuth.instance.currentUser!.email)
        .collection("item")
        .doc(widget.productId)
        .get()
        .then(
          (value) => {
            print(value.data()),
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

  getWishlistIsAddAndQty() {
    FirebaseFirestore.instance
        .collection("reviewWishList")
        .doc(FirebaseAuth.instance.currentUser!.email)
        .collection("item")
        .doc(widget.productId)
        .get()
        .then(
          (value) => {
            print(value.data()),
            if (mounted)
              {
                if (value.exists)
                  {
                    setState(() {
                      isBoolWishlist = value.get("isAdd");
                      count = value.get('quantity');
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
    getWishlistIsAddAndQty();
  }

  @override
  Widget build(BuildContext context) {
    cartProvider = Provider.of<CartProvider>(context);
    wishlistProvider = Provider.of<WishListProvider>(context);

    Size screenSize = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        // backgroundColor: Colors.grey.shade200,
        appBar: AppBar(
          title: Text('Product Details'),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => CartScreen(),
                  ),
                );
              },
              icon: Icon(
                Icons.shopping_cart_outlined,
                // color: Colors.white,
              ),
            ),
            IconButton(
              onPressed: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (_) => WishList()));
              },
              icon: Icon(
                Icons.favorite_outline,
                // color: Colors.white,
              ),
            ),
            SizedBox(width: 8)
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
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
                      Text('TK ${widget.price * count}'),
                      ElevatedButton.icon(
                        onPressed: () {
                          setState(() {
                            isBoolWishlist = !isBoolWishlist;
                          });
                          wishlistProvider!.addToWishlist(
                            wishListId: widget.productId,
                            wishListImage: widget.image,
                            wishListName: widget.name,
                            wishListPrice: widget.price,
                            wishListQty: count,
                          );
                        },
                        icon: isBoolWishlist == false
                            ? Icon(Icons.favorite_outline)
                            : Icon(Icons.favorite),
                        label: isBoolWishlist == false
                            ? Text('Add to favorite')
                            : Text('Item Added'),
                        style: ElevatedButton.styleFrom(
                          primary: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: Row(
                          children: [
                            Text('Quantity: ', textScaleFactor: 1.2),
                            isBoolCart == true
                                ? TextButton(
                                    onPressed: () {
                                      if (count > 1) {
                                        setState(() {
                                          count--;
                                        });
                                        cartProvider!.updateCart(
                                          cartId: widget.productId,
                                          cartImage: widget.image,
                                          cartName: widget.name,
                                          cartPrice: widget.price,
                                          cartQty: count,
                                        );
                                      }
                                    },
                                    child: Text('-', textScaleFactor: 1.7))
                                : Container(),
                            Text(count.toString()),
                            isBoolCart == true
                                ? TextButton(
                                    onPressed: () {
                                      if (count < 10) {
                                        setState(() {
                                          count++;
                                        });
                                        cartProvider!.updateCart(
                                          cartId: widget.productId,
                                          cartImage: widget.image,
                                          cartName: widget.name,
                                          cartPrice: widget.price,
                                          cartQty: count,
                                        );
                                      }
                                    },
                                    child: Text('+', textScaleFactor: 1.5))
                                : Container(),
                          ],
                        ),
                      ),
                      ElevatedButton.icon(
                        onPressed: () {
                          setState(() {
                            isBoolCart = !isBoolCart;
                          });
                          if (isBoolCart == true) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                duration: Duration(milliseconds: 500),
                                backgroundColor: Colors.lightBlue,
                                content: Text('Item Added'),
                              ),
                            );
                            cartProvider!.addToCart(
                              cartId: widget.productId,
                              cartImage: widget.image,
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
                          primary: Colors.white,
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
