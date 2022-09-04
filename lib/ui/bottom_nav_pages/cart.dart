// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Cart extends StatefulWidget {
  const Cart({Key? key}) : super(key: key);

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Text(
                'Your cart items ',
                style: TextStyle(shadows: [
                  Shadow(
                    color: Colors.grey,
                    offset: Offset(2, 2),
                    blurRadius: 6,
                  )
                ]),
                textScaleFactor: 2,
              ),
            ),
            StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('users-cart-item')
                    .doc(FirebaseAuth.instance.currentUser!.email)
                    .collection('item')
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasError) {
                    print('somthing is wrong');
                  }
                  if (snapshot.data == null) {
                    return Center(
                      child: CircularProgressIndicator(
                        backgroundColor: Colors.white,
                      ),
                    );
                  }

                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      height: 500,
                      child: ListView.builder(
                        itemCount: snapshot.data?.docs.length,
                        itemBuilder: (context, index) {
                          DocumentSnapshot _doc = snapshot.data!.docs[index];
                          return Card(
                            elevation: 3,
                            child: ListTile(
                              leading: Text(_doc['name']),
                              title: Text("TK ${_doc['price']}"),
                              trailing: GestureDetector(
                                child: CircleAvatar(
                                  child: Icon(Icons.remove),
                                ),
                                onTap: () {
                                  FirebaseFirestore.instance
                                      .collection('users-cart-item')
                                      .doc(FirebaseAuth
                                          .instance.currentUser!.email)
                                      .collection('item')
                                      .doc(_doc.id)
                                      .delete();
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      backgroundColor: Colors.lightBlue,
                                      content: Text('Item deleted'),
                                    ),
                                  );
                                },
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  );
                }),
          ],
        ),
      ),
    );
  }
}
