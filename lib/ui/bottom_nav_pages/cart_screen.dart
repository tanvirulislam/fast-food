// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cached_network_image/cached_network_image.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:taza_khabar/provider/cart_provider.dart';
import 'package:taza_khabar/ui/product_overview.dart';
import 'package:taza_khabar/ui/shipping/add_delivery_address.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  CartProvider? cartProvider;

  @override
  void initState() {
    super.initState();
    CartProvider cartProvider =
        Provider.of<CartProvider>(context, listen: false);
    cartProvider.getCartItem();
    cartProvider.getTotalPrice();
  }

  @override
  Widget build(BuildContext context) {
    cartProvider = Provider.of(context);

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Your cart items'),
          actions: [
            Center(child: Text('Pull down to refrash')),
            SizedBox(width: 4)
          ],
        ),
        body: cartProvider!.getCartDataList.isEmpty
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
            : RefreshIndicator(
                color: Theme.of(context).primaryColor,
                onRefresh: () async {
                  cartProvider!.getCartItem();
                },
                child: ListView(
                  children: cartProvider!.getCartDataList
                      .map(
                        (data) => Column(
                          children: [
                            Card(
                              elevation: 2,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        PageTransition(
                                          type: PageTransitionType.fade,
                                          child: ProductOverview(
                                            name: data.cartName,
                                            price: data.cartPrice,
                                            image: data.cartImage,
                                            productDescription: '',
                                            productId: data.cartId,
                                          ),
                                        ),
                                      );
                                    },
                                    child: FancyShimmerImage(
                                      height: 100,
                                      width: 100,
                                      boxFit: BoxFit.cover,
                                      errorWidget: Center(
                                          child: Text('Image not Found')),
                                      imageUrl: data.cartImage[0],
                                    ),
                                  ),
                                  Text(
                                    data.cartName,
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    'Quantity ' + data.cartQty.toString(),
                                  ),
                                  Text('TK ${data.cartPrice * data.cartQty}'),
                                  IconButton(
                                    icon: Icon(Icons.delete),
                                    onPressed: () async {
                                      cartProvider!.deleteCart(data.cartId);
                                      setState(() {
                                        cartProvider!.getCartItem();
                                      });
                                    },
                                  )
                                ],
                              ),
                            )
                          ],
                        ),
                      )
                      .toList(),
                ),
              ),
        bottomNavigationBar: Container(
          margin: EdgeInsets.symmetric(vertical: 8, horizontal: 0),
          height: 55,
          width: double.infinity,
          child: Card(
            elevation: 2,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Total Amount: TK ' +
                      cartProvider!.getTotalPrice().toString()),
                  cartProvider!.getCartDataList.isNotEmpty
                      ? ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              PageTransition(
                                type: PageTransitionType.fade,
                                child: AddDeliveryAddress(),
                              ),
                            );
                          },
                          child: Text('Checkout'),
                        )
                      : Container()
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
