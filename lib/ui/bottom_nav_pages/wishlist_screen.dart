// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

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
    // TODO: implement initState
    super.initState();
    WishListProvider wishlistProvider = Provider.of(context, listen: false);
    wishlistProvider.showWishlist();
  }

  @override
  Widget build(BuildContext context) {
    wishlistProvider = Provider.of<WishListProvider>(context);
    cartProvider = Provider.of<CartProvider>(context);
    return SafeArea(
      child: RefreshIndicator(
        onRefresh: () async {
          wishlistProvider!.showWishlist();
        },
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Theme.of(context).primaryColor,
            title: Text('Your wishlist items'),
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
                    shadows: [
                      Shadow(
                        color: Colors.grey,
                        blurRadius: 4,
                        offset: Offset(2, 2),
                      )
                    ],
                  ),
                ))
              : ListView(
                  children: wishlistProvider!.getWishlistData
                      .map((data) => Column(
                            children: [
                              Card(
                                elevation: 3,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Image.network(
                                      data.wishListImage[0],
                                      height: 100,
                                      width: 100,
                                      fit: BoxFit.cover,
                                    ),
                                    Text(data.wishListName),
                                    Text('Quantity ' +
                                        data.wishListQty.toString()),
                                    Text('TK ' + data.wishListPrice.toString()),
                                    Column(
                                      children: [
                                        IconButton(
                                          icon: Icon(Icons.delete),
                                          onPressed: () async {
                                            wishlistProvider!
                                                .deleteItem(data.wishListId);
                                            setState(() {
                                              wishlistProvider!.showWishlist();
                                            });
                                          },
                                        ),
                                        IconButton(
                                          icon: Icon(Icons.shopping_cart),
                                          onPressed: () async {
                                            setState(() {
                                              wishlistProvider!.showWishlist();
                                            });
                                            cartProvider!.addToCart(
                                              cartId: data.wishListId,
                                              cartImage: data.wishListImage,
                                              cartName: data.wishListName,
                                              cartPrice: data.wishListPrice,
                                              cartQty: data.wishListQty,
                                            );
                                            wishlistProvider!
                                                .deleteItem(data.wishListId);
                                          },
                                        ),
                                      ],
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
