// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_print

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taza_khabar/models/product_model.dart';
import 'package:taza_khabar/provider/cart_provider.dart';
import 'package:taza_khabar/provider/product_provider.dart';
import 'package:taza_khabar/ui/count.dart';
import 'package:taza_khabar/ui/product_overview.dart';

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
    ProdcutProvider _prodcutProvider = Provider.of(context, listen: false);
    _prodcutProvider.getSearchProductList;
    CartProvider _cartProvider = Provider.of(context, listen: false);
    _cartProvider.getCartItem();
  }

  @override
  Widget build(BuildContext context) {
    List<ProductModel> searchItems = searchItem(query);

    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: Theme.of(context).primaryColor,
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
                        print('---------------' + query);
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
                searchItems.isNotEmpty
                    ? Column(
                        children: searchItems
                            .map(
                              (data) => Column(
                                children: [
                                  Card(
                                    elevation: 3,
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
                                          child: Image.network(
                                            data.productImage[0],
                                            height: 100,
                                            width: 100,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        Text(data.productName),
                                        Text('1 Piece'),
                                        Text('TK ' +
                                            data.productPrice.toString()),
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            IconButton(
                                              icon:
                                                  Icon(Icons.favorite_outline),
                                              onPressed: () {},
                                            ),
                                            Count(
                                              cartId: data.productId,
                                              cartName: data.productName,
                                              cartImage: data.productImage,
                                              cartPrice: data.productPrice,
                                              cartQty: 1,
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            )
                            .toList(),
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
