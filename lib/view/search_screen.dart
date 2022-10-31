// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_print

import 'package:cached_network_image/cached_network_image.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:taza_khabar/models/product_model.dart';
import 'package:taza_khabar/view/count.dart';
import 'package:taza_khabar/view/product_overview.dart';

// ignore: must_be_immutable
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
  // String? search;
  String query = '';
  searchItem(String query) {
    List<ProductModel> searchFood = widget.search.where((element) {
      return element.productName.toLowerCase().contains(query);
    }).toList();
    return searchFood;
  }

  @override
  Widget build(BuildContext context) {
    List<ProductModel> searchItems = searchItem(query);
    // Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            title: Text(
              'Search your Food',
              style: TextStyle(fontFamily: 'Lato'),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(3.0),
            child: Column(
              children: [
                SizedBox(height: 4),
                SizedBox(
                  height: 60,
                  child: TextFormField(
                    autofocus: true,
                    onChanged: (value) {
                      setState(() {
                        query = value;
                        // print('---------------' + query);
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
                      // filled: true,
                      // fillColor: Colors.white,
                    ),
                  ),
                ),
                SizedBox(height: 4),
                searchItems.isNotEmpty
                    ? Expanded(
                        child: ListView(
                          children: searchItems
                              .map(
                                (data) => Column(
                                  children: [
                                    Card(
                                      margin: EdgeInsets.symmetric(vertical: 4),
                                      elevation: 2,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          InkWell(
                                            onTap: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      ProductOverview(
                                                    name: data.productName,
                                                    price: data.productPrice,
                                                    image: data.productImage,
                                                    productDescription:
                                                        data.productDescription,
                                                    productId: data.productId,
                                                  ),
                                                ),
                                              );
                                            },
                                            child: CachedNetworkImage(
                                              imageUrl: data.productImage[0],
                                              height: 100,
                                              width: 100,
                                              fit: BoxFit.cover,
                                              progressIndicatorBuilder:
                                                  (context, url,
                                                          downloadProgress) =>
                                                      CircularProgressIndicator(
                                                          value:
                                                              downloadProgress
                                                                  .progress),
                                              errorWidget:
                                                  (context, url, error) =>
                                                      Icon(Icons.error),
                                            ),
                                          ),
                                          Text(
                                            data.productName,
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Text(
                                            'TK ${data.productPrice}',
                                          ),
                                          Text(
                                            'Quantity 1',
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(right: 4),
                                            child: Count(
                                              cartId: data.productId,
                                              cartName: data.productName,
                                              cartImage: data.productImage,
                                              cartPrice: data.productPrice,
                                              cartQty: 1,
                                              cartDescription:
                                                  data.productDescription,
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              )
                              .toList(),
                        ),
                      )
                    : Center(
                        child: Text(
                          'No item found',
                          style: TextStyle(
                            color: Colors.cyan,
                            fontSize: 34,
                            shadows: [
                              Shadow(
                                color: Colors.black.withOpacity(.4),
                                blurRadius: 4,
                                offset: Offset(3, 2),
                              ),
                            ],
                          ),
                        ),
                      ),
              ],
            ),
          )),
    );
  }
}
