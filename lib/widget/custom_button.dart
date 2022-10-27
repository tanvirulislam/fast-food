// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class CustomeButton extends StatefulWidget {
  const CustomeButton({Key? key}) : super(key: key);

  @override
  State<CustomeButton> createState() => _CustomeButtonState();
}

class _CustomeButtonState extends State<CustomeButton> {
  int quantity = 1;
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Container(
        width: 100,
        height: 36,
        decoration: BoxDecoration(
          color: Theme.of(context).primaryColor,
          borderRadius: BorderRadius.circular(4),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InkWell(
                  onTap: () {
                    if (quantity > 0) {
                      setState(() {
                        quantity--;
                      });
                    }
                  },
                  child: Icon(Icons.remove)),
              Text(quantity.toString()),
              InkWell(
                  onTap: () {
                    setState(() {
                      quantity++;
                    });
                  },
                  child: Icon(Icons.add)),
            ],
          ),
        ),
      ),
    );
  }
}
