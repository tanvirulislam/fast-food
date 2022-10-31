// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taza_khabar/provider/cart_provider.dart';
import 'package:taza_khabar/provider/wishlist_provider.dart';

class WishList extends StatefulWidget {
  const WishList({Key? key}) : super(key: key);

  @override
  State<WishList> createState() => _WishList();
}

class _WishList extends State<WishList> {
  WishListProvider? wishlistProvider;
  CartProvider? cartProvider;
  @override
  void initState() {
    super.initState();
    WishListProvider wishlistProvider = Provider.of(context, listen: false);
    wishlistProvider.showWishlist();
  }

  @override
  Widget build(BuildContext context) {
    wishlistProvider = Provider.of<WishListProvider>(context);
    cartProvider = Provider.of<CartProvider>(context);
    return RefreshIndicator(
      onRefresh: () async {
        wishlistProvider!.showWishlist();
      },
      child: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              'Favorite items',
              style: TextStyle(fontFamily: 'Lato'),
            ),
            actions: [
              Center(child: Text('Pull down to refrash')),
              SizedBox(width: 4)
            ],
          ),
          body: wishlistProvider!.getWishlistData.isEmpty
              ? Center(
                  child: Text(
                    'NO ITEM',
                    textScaleFactor: 2,
                    style: TextStyle(
                      fontFamily: 'Lato',
                      shadows: [
                        Shadow(
                          color: Colors.grey,
                          blurRadius: 4,
                          offset: Offset(2, 2),
                        )
                      ],
                    ),
                  ),
                )
              : ListView(
                  children: wishlistProvider!.getWishlistData
                      .map((data) => Column(
                            children: [
                              Card(
                                elevation: 2,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    FancyShimmerImage(
                                      height: 100,
                                      width: 100,
                                      boxFit: BoxFit.cover,
                                      errorWidget: Center(
                                          child: Text('Image not Found')),
                                      imageUrl: data.wishListImage[0],
                                    ),
                                    SizedBox(
                                      height: 100,
                                      width: 100,
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 9),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              data.wishListName,
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            Text('Quantity ' +
                                                data.wishListQty.toString()),
                                            Text('TK ' +
                                                data.wishListPrice.toString()),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 4),
                                      child: Column(
                                        children: [
                                          ElevatedButton.icon(
                                            onPressed: () {
                                              setState(() {
                                                wishlistProvider!
                                                    .showWishlist();
                                              });
                                              cartProvider!.addToCart(
                                                cartId: data.wishListId,
                                                cartImage: data.wishListImage,
                                                cartName: data.wishListName,
                                                cartPrice: data.wishListPrice,
                                                cartQty: data.wishListQty,
                                                cartDescription:
                                                    data.wishListDecription,
                                              );
                                              wishlistProvider!
                                                  .deleteItem(data.wishListId);
                                            },
                                            icon: Icon(
                                                Icons.shopping_cart_outlined),
                                            label: Text('Cart'),
                                            style: ElevatedButton.styleFrom(
                                              padding: EdgeInsets.symmetric(
                                                horizontal: 20,
                                              ),
                                            ),
                                          ),
                                          ElevatedButton.icon(
                                            onPressed: () {
                                              wishlistProvider!
                                                  .deleteItem(data.wishListId);
                                              setState(() {
                                                wishlistProvider!
                                                    .showWishlist();
                                              });
                                            },
                                            icon: Icon(Icons.delete_outline),
                                            label: Text('Detele'),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              )
                            ],
                          ))
                      .toList(),
                ),
        ),
      ),
    );
  }
}
