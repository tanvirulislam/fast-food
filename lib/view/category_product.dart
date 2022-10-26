// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class CategoryProduct extends StatefulWidget {
  String name;
  String image;
  String id;
  CategoryProduct({
    Key? key,
    required this.id,
    required this.name,
    required this.image,
  }) : super(key: key);

  @override
  State<CategoryProduct> createState() => _CategoryProductState();
}

class _CategoryProductState extends State<CategoryProduct> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Category Product'),
        ),
        body: Column(
          children: [
            Text(widget.name),
            Image.network(widget.image),
          ],
        ),
      ),
    );
  }
}
