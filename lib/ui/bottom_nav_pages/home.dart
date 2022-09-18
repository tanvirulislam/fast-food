// ignore_for_file: prefer_const_constructors

import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taza_khabar/provider/category_provider.dart';
import 'package:taza_khabar/provider/product_provider.dart';
import 'package:taza_khabar/ui/bottom_nav_pages/cart_screen.dart';
import 'package:taza_khabar/ui/bottom_nav_pages/wishlist.dart';
import 'package:taza_khabar/ui/count.dart';
import 'package:taza_khabar/ui/product_overview.dart';
import 'package:taza_khabar/ui/search_screen.dart';
import 'package:taza_khabar/widget/custome_drawer.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  ProdcutProvider? prodcutProvider;
  CategoryProvider? categoryProvider;

  List<String> carouselImage = [];
  fatchCarouselImage() async {
    QuerySnapshot qn =
        await FirebaseFirestore.instance.collection('carousel-slider').get();
    setState(() {
      for (int i = 0; i < qn.docs.length; i++) {
        carouselImage.add(qn.docs[i]['img-path']);
        // print(qn.docs[i]['img-path']);
      }
    });
    return qn.docs;
  }

  bool isBoolCart = false;
  @override
  void initState() {
    fatchCarouselImage();
    super.initState();
    prodcutProvider = Provider.of(context, listen: false);
    prodcutProvider!.fatchProductData();
    categoryProvider = Provider.of(context, listen: false);
    categoryProvider!.fatchCategoryData();
  }

  bool isBool = false;

  @override
  Widget build(BuildContext context) {
    prodcutProvider = Provider.of(context);
    categoryProvider = Provider.of(context);
    Size screenSize = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          title: Text('Fast food'),
          actions: [
            IconButton(
              onPressed: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (_) => CartScreen()));
              },
              icon: Icon(Icons.shopping_cart_outlined),
            ),
            IconButton(
              onPressed: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (_) => WishList()));
              },
              icon: Icon(Icons.favorite_outline),
            ),
            SizedBox(width: 8)
          ],
          // backgroundColor: Colors.lightBlue,
        ),
        drawer: drawerCustom(context),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            children: [
              InkWell(
                onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SearchScreen(
                          search: prodcutProvider!.getSearchProductList),
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
                aspectRatio: screenSize.width < 400 ? 2.5 : 4.5,
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
                    // height: 400,
                    aspectRatio: 16 / 9,
                    viewportFraction: 1,
                    initialPage: 0,
                    enableInfiniteScroll: true,
                    reverse: false,
                    autoPlay: true,
                    autoPlayInterval: Duration(seconds: 3),
                    autoPlayAnimationDuration: Duration(milliseconds: 800),
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
                    'Food Category',
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
                height: 175,
                child: ListView.builder(
                  itemCount: categoryProvider!.getCategoryList.length,
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (BuildContext context, int index) {
                    return InkWell(
                      onTap: () {},
                      child: Card(
                        elevation: 3,
                        child: Column(
                          children: [
                            Image.network(
                              categoryProvider!
                                  .getCategoryList[index].categoryImage,
                              height: 130,
                              width: 160,
                              fit: BoxFit.cover,
                            ),
                            SizedBox(
                              width: 160,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      categoryProvider!
                                          .getCategoryList[index].categoryName,
                                    ),
                                    // SizedBox(width: 22),
                                    InkWell(
                                      onTap: () {
                                        // Navigator.push(
                                        //   context,
                                        //   MaterialPageRoute(
                                        //     builder: (context) => CategoryProduct(
                                        //       name: categoryProvider!
                                        //           .getCategoryList[index]
                                        //           .categoryName,
                                        //       image: categoryProvider!
                                        //           .getCategoryList[index]
                                        //           .categoryImage,
                                        //       id: categoryProvider!
                                        //           .getCategoryList[index]
                                        //           .categoryId,
                                        //     ),
                                        //   ),
                                        // );
                                      },
                                      child: Text(
                                        'view',
                                        // style: TextStyle(
                                        //     color: Theme.of(context).primaryColor),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  },
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
              GridView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: screenSize.width < 400 ? 2 : 4,
                ),
                itemCount: prodcutProvider!.getProductList.length,
                itemBuilder: (BuildContext context, int index) {
                  return Card(
                    elevation: 5,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ProductOverview(
                                  name: prodcutProvider!
                                      .getProductList[index].productName,
                                  price: prodcutProvider!
                                      .getProductList[index].productPrice,
                                  image: prodcutProvider!
                                      .getProductList[index].productImage,
                                  productDescription: prodcutProvider!
                                      .getProductList[index].productDescription,
                                  productId: prodcutProvider!
                                      .getProductList[index].productId,
                                ),
                              ),
                            );
                          },
                          child: Image.network(
                            prodcutProvider!
                                .getProductList[index].productImage[0],
                            width: screenSize.width,
                            height: 140,
                            fit: BoxFit.cover,
                          ),
                        ),
                        SizedBox(height: 5),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(prodcutProvider!
                                  .getProductList[index].productName),
                              Text(
                                'TK ' +
                                    prodcutProvider!
                                        .getProductList[index].productPrice
                                        .toString(),
                              ),
                              Count(
                                cartId: prodcutProvider!
                                    .getProductList[index].productId,
                                cartName: prodcutProvider!
                                    .getProductList[index].productName,
                                cartImage: prodcutProvider!
                                    .getProductList[index].productImage,
                                cartPrice: prodcutProvider!
                                    .getProductList[index].productPrice,
                                cartQty: 1,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
