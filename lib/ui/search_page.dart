// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  var inputText = '';
  // final Stream<QuerySnapshot> _searchProduct = FirebaseFirestore.instance
  //     .collection('products')
  //     .where('product-name', isEqualTo: inputText)
  //     .snapshots();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'E-Commerce',
            style: TextStyle(color: Colors.white),
          ),
          actions: [
            TextButton(
                onPressed: () {},
                child: Icon(
                  Icons.shopping_cart,
                  color: Colors.white,
                ))
          ],
          backgroundColor: Colors.lightBlue,
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Column(
            // ignore: prefer_const_literals_to_create_immutables
            children: [
              SizedBox(
                height: 10,
              ),
              TextFormField(
                autofocus: true,
                onChanged: (val) {
                  setState(() {
                    inputText = val;
                    print(inputText);
                  });
                },
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.lightBlue),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.amber),
                  ),
                ),
              ),
              SizedBox(
                height: 12,
              ),
              Expanded(
                child: Container(
                  child: StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('products')
                        .where('product-name', isEqualTo: inputText)
                        .snapshots(),
                    builder: (context, snapshot) {
                      final List searchList = [];
                      snapshot.data?.docs.map((DocumentSnapshot document) {
                        Map<String, dynamic> a =
                            document.data() as Map<String, dynamic>;
                        searchList.add(a);
                        print(a);
                        a['id'] = document.id;
                      }).toList();

                      if (snapshot.data == null) {
                        return Center(
                          child: CircularProgressIndicator(
                            color: Colors.amber,
                          ),
                        );
                      }

                      return ListView(
                        children: [
                          for (int i = 0; i < searchList.length; i++) ...[
                            Card(
                              elevation: 2,
                              child: ListTile(
                                title: Text(searchList[i]['product-name']),
                                leading: Image.network(
                                  searchList[i]['product-img'][0],
                                  fit: BoxFit.fill,
                                  width: 80,
                                ),
                              ),
                            ),
                          ],
                          // ElevatedButton(onPressed: () => print(a), child: Text('data'))
                        ],
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
