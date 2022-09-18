// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taza_khabar/provider/cart_provider.dart';
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
    // TODO: implement initState
    super.initState();
    CartProvider cartProvider =
        Provider.of<CartProvider>(context, listen: false);
    cartProvider.getCartItem();
    cartProvider.getTotalPrice();
  }

  @override
  Widget build(BuildContext context) {
    cartProvider = Provider.of(context);
    // cartProvider!.getCartItem();

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
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
                              elevation: 3,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Image.network(
                                    data.cartImage[0],
                                    height: 100,
                                    width: 100,
                                    fit: BoxFit.cover,
                                  ),
                                  Text(data.cartName,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold)),
                                  Text('Quantity ' + data.cartQty.toString()),
                                  Text('TK ${data.cartPrice * data.cartQty}'),
                                  IconButton(
                                    icon: Icon(Icons.delete),
                                    onPressed: () async {
                                      cartProvider!.deleteCart(data.cartId);
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
            elevation: 5,
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
                              MaterialPageRoute(
                                builder: (context) => AddDeliveryAddress(),
                              ),
                            );
                          },
                          child: Text(
                            'Checkout',
                            style:
                                TextStyle(color: Theme.of(context).hintColor),
                          ),
                          style: ElevatedButton.styleFrom(
                            primary: Theme.of(context).primaryColor,
                          ),
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
