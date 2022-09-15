// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_print

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taza_khabar/provuder/cart_provider.dart';
import 'package:taza_khabar/ui/bottomNavController.dart';

class PaymentScreeen extends StatefulWidget {
  String fName;
  String lName;
  String mobile;
  String area;
  String city;

  PaymentScreeen({
    Key? key,
    required this.fName,
    required this.lName,
    required this.mobile,
    required this.city,
    required this.area,
  }) : super(key: key);

  @override
  State<PaymentScreeen> createState() => _PaymentScreeenState();
}

class _PaymentScreeenState extends State<PaymentScreeen> {
  randomNumber() {
    var rnd = Random();
    var next = rnd.nextDouble() * 1000000;
    while (next < 100000) {
      next *= 10;
    }
    return next;
  }

  @override
  Widget build(BuildContext context) {
    CartProvider cartProvidersss = Provider.of<CartProvider>(context);

    double discount = 10;
    double subtotalPrice = cartProvidersss.getTotalPrice();

    double discountPrice = 0;
    if (subtotalPrice > 300) {
      double savings = subtotalPrice * (10 / 100);
      discountPrice = subtotalPrice - savings;
    }

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Payment summary'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            children: [
              Card(
                elevation: 5,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('First Name :'),
                              Text('Last Name :'),
                              Text('Mobile No :'),
                              Text('City :'),
                              Text('Area :'),
                            ],
                          ),
                          SizedBox(width: 8),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(widget.fName),
                              Text(widget.lName),
                              Text(widget.mobile),
                              Text(widget.city),
                              Text(widget.area),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              ExpansionTile(
                title: Text(
                    'Total order items  ${cartProvidersss.getCartDataList.length}'),
                children: cartProvidersss.getCartDataList
                    .map((e) => ListTile(
                          leading: Image.network(
                            e.cartImage[0],
                            width: 70,
                            height: 70,
                            fit: BoxFit.cover,
                          ),
                          title: Text(e.cartName),
                          subtitle: Text('Quantity ${e.cartQty}'),
                          trailing: Text('TK ${e.cartPrice * e.cartQty}'),
                        ))
                    .toList(),
              ),
              Divider(),
              ListTile(
                title: Text('Subtottal'),
                trailing:
                    Text('TK ${cartProvidersss.getTotalPrice().toString()}'),
              ),
              ListTile(
                title: Text('Shipping charge'),
                trailing: Text('TK 20'),
              ),
              ListTile(
                title: Text('Compen discount'),
                subtitle: Text('Discounts will apply only to above TK 300'),
                trailing: Text('10%'),
              ),
            ],
          ),
        ),
        bottomNavigationBar: Card(
          // color: Colors.grey[200],
          elevation: 7,
          child: ListTile(
            title: Text('Total Amount'),
            subtitle: Text(
                'TK ${discountPrice == 0 ? subtotalPrice + 20 : discountPrice + 20}'),
            trailing: ElevatedButton(
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                        builder: (context) => BottomNavController()),
                    (Route<dynamic> route) => false,
                  );
                  showDialog<String>(
                    context: context,
                    builder: (BuildContext context) => AlertDialog(
                      title: const Text(
                          'You have successfully ordered your item.'),
                      content: Text(
                          'Your order id : ${randomNumber().toInt().toString()}'),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () => Navigator.pop(context, 'OK'),
                          child: const Text('OK'),
                        ),
                      ],
                    ),
                  );
                },
                child: Text('Place order')),
          ),
        ),
      ),
    );
  }
}
