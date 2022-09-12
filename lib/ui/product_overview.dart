// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class ProductOverview extends StatefulWidget {
  String name;
  String price;
  List image;
  String productDescription;
  ProductOverview({
    Key? key,
    required this.name,
    required this.price,
    required this.image,
    required this.productDescription,
  }) : super(key: key);

  @override
  State<ProductOverview> createState() => _ProductOverviewState();
}

class _ProductOverviewState extends State<ProductOverview> {
  bool isBoolFavorite = false;
  bool isBoolCart = false;
  @override
  Widget build(BuildContext context) {
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
                      ElevatedButton.icon(
                        onPressed: () {
                          setState(() {
                            isBoolCart = !isBoolCart;
                          });
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
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
