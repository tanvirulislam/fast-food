// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:taza_khabar/models/product_model.dart';

class NewSearchScreen extends StatefulWidget {
  List<ProductModel> search;
  NewSearchScreen({Key? key, required this.search}) : super(key: key);

  @override
  State<NewSearchScreen> createState() => _NewSearchScreen();
}

class _NewSearchScreen extends State<NewSearchScreen> {
  String query = '';
  searchItem(String query) {
    List<ProductModel> searchProduct = widget.search.where((element) {
      return element.productName.toLowerCase().contains(query);
    }).toList();
    return searchProduct;
  }

  @override
  Widget build(BuildContext context) {
    List<ProductModel> searchItems = searchItem(query);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            children: [
              SizedBox(
                height: 60,
                child: TextFormField(
                  onChanged: (value) {
                    setState(() {
                      query = value;
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
                  ),
                ),
              ),
              SizedBox(height: 200),
              Column(
                children: searchItems.map((data) {
                  print('product name ' + data.productName);
                  return Text(data.productName);
                }).toList(),
              ),
              Text('ProductModel')
            ],
          ),
        ),
      ),
    );
  }
}
