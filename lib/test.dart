// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

class MyWidget extends StatelessWidget {
  const MyWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          ElevatedButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  content: Text('hey, you just clicked the button'),
                  actions: [
                    TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: Text('ok'))
                  ],
                ),
              );
            },
            child: Text('click'),
          ),
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: 3,
              itemBuilder: (context, index) => CircleAvatar(),
            ),
          ),
        ],
      ),
    );
  }
}
