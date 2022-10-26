// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_print

import 'package:animated_switcher_plus/animated_switcher_plus.dart';
import 'package:badges/badges.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:taza_khabar/provider/cart_provider.dart';
import 'package:taza_khabar/provider/wishlist_provider.dart';
import 'package:taza_khabar/view/bottom_nav_pages/cart_screen.dart';
import 'package:taza_khabar/view/bottom_nav_pages/wishlist_screen.dart';

// ignore: must_be_immutable
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
        .doc(FirebaseAuth.instance.currentUser!.uid)
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

  getWishlistIsAddAndQty() {
    FirebaseFirestore.instance
        .collection("reviewWishList")
        .doc(FirebaseAuth.instance.currentUser!.uid)
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

  bool _showFirstChild = true;
  @override
  Widget build(BuildContext context) {
    cartProvider = Provider.of<CartProvider>(context);
    wishlistProvider = Provider.of<WishListProvider>(context);
    Size size = MediaQuery.of(context).size;

    return RefreshIndicator(
      onRefresh: () async {
        getCartIsAddAndQty();
      },
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Text('Product Details'),
            actions: [
              cartProvider!.getCartDataList.isNotEmpty
                  ? Badge(
                      position: BadgePosition(top: 1, end: 1),
                      animationType: BadgeAnimationType.fade,
                      badgeContent: Text(
                        cartProvider!.getCartDataList.length.toString(),
                        style: TextStyle(color: Colors.white),
                      ),
                      child: IconButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            PageTransition(
                              type: PageTransitionType.fade,
                              child: CartScreen(),
                            ),
                          );
                        },
                        icon: Icon(Icons.shopping_cart_outlined),
                      ),
                    )
                  : IconButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          PageTransition(
                            type: PageTransitionType.fade,
                            child: CartScreen(),
                          ),
                        );
                      },
                      icon: Icon(Icons.shopping_cart_outlined),
                    ),
              wishlistProvider!.getWishlistData.isNotEmpty
                  ? Badge(
                      position: BadgePosition(top: 1, end: 1),
                      animationType: BadgeAnimationType.scale,
                      badgeContent: Text(
                        wishlistProvider!.getWishlistData.length.toString(),
                        style: TextStyle(color: Colors.white),
                      ),
                      child: IconButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            PageTransition(
                              type: PageTransitionType.fade,
                              child: WishList(),
                            ),
                          );
                        },
                        icon: Icon(Icons.favorite_outline),
                      ),
                    )
                  : IconButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          PageTransition(
                            type: PageTransitionType.fade,
                            child: WishList(),
                          ),
                        );
                      },
                      icon: Icon(Icons.favorite_outline),
                    ),
              SizedBox(width: 8),
            ],
          ),
          body: ListView(
            children: [
              CarouselSlider(
                items: widget.image
                    .map(
                      (e) => FancyShimmerImage(
                        // height: 600,
                        width: double.infinity,
                        errorWidget: Center(child: Text('Image not Found')),
                        imageUrl: e,
                        boxFit: BoxFit.cover,
                      ),
                    )
                    .toList(),
                options: CarouselOptions(
                  viewportFraction: 1,
                  height: size.width < 400 ? 400 : 200,
                  autoPlay: true,
                ),
              ),
              SizedBox(height: 4),
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
                            shadows: [
                              Shadow(
                                color: Colors.grey,
                                offset: Offset(0.0, 2.0),
                                blurRadius: 3.0,
                              ),
                            ],
                          ),
                        ),
                        AnimatedSwitcherFlip.flipY(
                          duration: const Duration(milliseconds: 500),
                          child: Container(
                            key: ValueKey(_showFirstChild),
                            padding: const EdgeInsets.all(5),
                            child: Text(
                              _showFirstChild
                                  ? 'TK ${widget.price * count}'
                                  : 'TK ${widget.price * count}',
                            ),
                          ),
                        ),
                        ElevatedButton.icon(
                          onPressed: () {
                            setState(() {
                              isBoolWishlist = true;
                              wishlistProvider!.showWishlist();
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
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Text('Quantity: ', textScaleFactor: 1.2),
                            isBoolCart == true
                                ? TextButton(
                                    onPressed: () {
                                      if (count > 1) {
                                        setState(() {
                                          count--;
                                          _showFirstChild = !_showFirstChild;
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
                                    child: Text('-', textScaleFactor: 1.7),
                                  )
                                : Container(),
                            Text(count.toString()),
                            isBoolCart == true
                                ? TextButton(
                                    onPressed: () {
                                      if (count < 10) {
                                        setState(() {
                                          count++;
                                          _showFirstChild = !_showFirstChild;
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
                                    child: Text('+', textScaleFactor: 1.5),
                                  )
                                : Container(),
                          ],
                        ),
                        ElevatedButton.icon(
                          onPressed: () {
                            setState(() {
                              isBoolCart = true;
                              cartProvider!.getCartItem();
                            });
                            if (isBoolCart == true) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  duration: Duration(milliseconds: 500),
                                  backgroundColor: Colors.cyan,
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
                              ? Text(
                                  'Item added',
                                  style: TextStyle(),
                                )
                              : Text('Add to cart'),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
          floatingActionButton: Text('Pull down to refresh'),
        ),
      ),
    );
  }
}
