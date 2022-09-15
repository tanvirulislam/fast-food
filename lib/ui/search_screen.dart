// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:taza_khabar/models/product_model.dart';

class SearchScreen extends StatefulWidget {
  List<ProductModel> search;
  SearchScreen({
    Key? key,
    required this.search,
  }) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String query = '';
  searchItem(String query) {
    List<ProductModel> searchFood = widget.search.where((element) {
      return element.productName.toLowerCase().contains(query);
    }).toList();
    return searchFood;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<ProductModel> searchItems = searchItem(query);
    return SafeArea(
      child: Scaffold(
        // backgroundColor: Colors.grey.shade200,
        appBar: AppBar(
          title: Text('Search your products'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            children: [
              SizedBox(
                height: 60,
                child: TextFormField(
                  autofocus: true,
                  onChanged: (value) {
                    setState(() {
                      query = value;
                      // print(query);
                    });
                  },
                  decoration: InputDecoration(
                    hintText: 'Input search item',
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.lightBlue),
                    ),
                    suffixIcon: Icon(Icons.search),
                    filled: true,
                    // fillColor: Colors.white,
                  ),
                ),
              ),
              SizedBox(height: 10),
              Column(
                children: searchItems
                    .map((data) => Column(
                          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Card(
                              elevation: 3,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Image.network(
                                    data.productImage[0],
                                    height: 100,
                                    width: 100,
                                    fit: BoxFit.cover,
                                  ),
                                  Text(data.productName),
                                  Text('1 Piece'),
                                  Text('TK ' + data.productPrice.toString()),
                                  Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    mainAxisSize: MainAxisSize.max,
                                    children: [
                                      IconButton(
                                        icon: Icon(Icons.favorite_outline),
                                        onPressed: () {},
                                      ),
                                      IconButton(
                                        icon:
                                            Icon(Icons.shopping_cart_outlined),
                                        onPressed: () {},
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            )
                          ],
                        ))
                    .toList(),
              )
            ],
          ),
        ),
      ),
    );
  }
}
