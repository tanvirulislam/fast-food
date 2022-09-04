// ignore_for_file: prefer_const_constructors

import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:taza_khabar/ui/bottom_nav_pages/cart.dart';
import 'package:taza_khabar/ui/product_details.dart';
import 'package:taza_khabar/ui/search_page.dart';
import 'package:taza_khabar/widget/custome_drawer.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final TextEditingController _searchController = TextEditingController();

  List<String> carouselImage = [];

  var firestoreInstance = FirebaseFirestore.instance;

  fatchCarouselImage() async {
    QuerySnapshot qn =
        await firestoreInstance.collection('carousel-slider').get();
    setState(() {
      for (int i = 0; i < qn.docs.length; i++) {
        carouselImage.add(qn.docs[i]['img-path']);
        print(qn.docs[i]['img-path']);
      }
    });
    return qn.docs;
  }

  @override
  void initState() {
    fatchCarouselImage();
    super.initState();
  }

  final Stream<QuerySnapshot> _usersStream =
      FirebaseFirestore.instance.collection('products').snapshots();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: _usersStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          final List storedocs = [];
          snapshot.data?.docs.map((DocumentSnapshot document) {
            Map a = document.data() as Map<String, dynamic>;
            storedocs.add(a);
            a['id'] = document.id;
          }).toList();

          if (snapshot.data == null) {
            return Center(
              child: CircularProgressIndicator(
                backgroundColor: Colors.white,
              ),
            );
          }

          return SafeArea(
            child: Scaffold(
              appBar: AppBar(
                title: Text(
                  'Fast food',
                  style: TextStyle(color: Colors.white),
                ),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.push(
                            context, MaterialPageRoute(builder: (_) => Cart()));
                      },
                      child: Icon(
                        Icons.shopping_cart,
                        color: Colors.white,
                      ))
                ],
                backgroundColor: Colors.lightBlue,
              ),
              // bottomNavigationBar: BottomMenu(),
              drawer: drawerCustom(context),
              body: Container(
                width: MediaQuery.of(context).size.width,
                height: 600,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      InkWell(
                        onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SearchPage(),
                            )),
                        child: Container(
                          height: 60,
                          width: double.infinity,
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text('Search...'),
                          ),
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.lightBlue)),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      AspectRatio(
                        aspectRatio: 3.5,
                        child: CarouselSlider(
                          items: carouselImage
                              .map(
                                (item) => Container(
                                  decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: NetworkImage(item),
                                          fit: BoxFit.fitWidth)),
                                ),
                              )
                              .toList(),
                          options: CarouselOptions(
                            height: 400,
                            aspectRatio: 16 / 9,
                            viewportFraction: 1,
                            initialPage: 0,
                            enableInfiniteScroll: true,
                            reverse: false,
                            autoPlay: true,
                            autoPlayInterval: Duration(seconds: 3),
                            autoPlayAnimationDuration:
                                Duration(milliseconds: 800),
                            autoPlayCurve: Curves.fastOutSlowIn,
                            enlargeCenterPage: true,
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        // ignore: prefer_const_literals_to_create_immutables
                        children: [
                          Text(
                            'Top sells food',
                          ),
                          TextButton.icon(
                            onPressed: () {},
                            icon: Icon(Icons.arrow_right),
                            label: Text('View all'),
                            style: TextButton.styleFrom(primary: Colors.black),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 125,
                        child: GridView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: storedocs.length,
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 1),
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          ProductDetails(storedocs[index]),
                                    )),
                                child: Card(
                                  color: Colors.grey[300],
                                  elevation: 5,
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: 80,
                                        child: Image.network(
                                          storedocs[index]['product-img'][0],
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(storedocs[index]
                                                    ['product-name']
                                                .toString()),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(storedocs[index]
                                                    ['product-price']
                                                .toString()),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            }),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }
}
