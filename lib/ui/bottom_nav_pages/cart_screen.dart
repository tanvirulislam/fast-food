// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taza_khabar/provuder/cart_provider.dart';
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
    // cartProvider!.getCartItem();
    cartProvider.getTotalPrice();
  }

  @override
  Widget build(BuildContext context) {
    cartProvider = Provider.of(context);
    cartProvider!.getCartItem();

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Your cart items'),
        ),
        floatingActionButton: FloatingActionButton(onPressed: () async {
          cartProvider!.deleteAllCart();
        }),
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
            : ListView(
                children: cartProvider!.getCartDataList
                    .map((data) => Column(
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
                        ))
                    .toList(),
              ),
        bottomNavigationBar: Container(
          margin: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
          height: 55,
          width: double.infinity,
          decoration: BoxDecoration(color: Colors.grey.shade200),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Total Amount: TK ' +
                  cartProvider!.getTotalPrice().toString()),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AddDeliveryAddress(),
                    ),
                  );
                },
                child: Text('Checkout'),
                // style: ElevatedButton.styleFrom(primary: Colors.white),
              )
            ],
          ),
        ),
      ),
    );
  }
}
