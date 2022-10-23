// ignore_for_file: prefer_const_constructors

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:taza_khabar/provider/cart_provider.dart';
import 'package:taza_khabar/provider/category_provider.dart';
import 'package:taza_khabar/provider/product_provider.dart';
import 'package:taza_khabar/provider/wishlist_provider.dart';
import 'package:taza_khabar/ui/bottom_nav_pages/cart_screen.dart';
import 'package:taza_khabar/ui/bottom_nav_pages/wishlist_screen.dart';
import 'package:taza_khabar/ui/count.dart';
import 'package:taza_khabar/ui/product_overview.dart';
import 'package:taza_khabar/ui/search_screen.dart';
import 'package:taza_khabar/widget/custome_drawer.dart';
import 'package:badges/badges.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  ProdcutProvider? prodcutProvider;
  CategoryProvider? categoryProvider;

  bool isBoolCart = false;
  @override
  void initState() {
    super.initState();
    prodcutProvider = Provider.of(context, listen: false);
    prodcutProvider!.fatchProductData();
    prodcutProvider!.fatchCarouselImage();
    categoryProvider = Provider.of(context, listen: false);
    categoryProvider!.fatchCategoryData();
    categoryProvider!.fatchCategoryProductData();
    CartProvider _cartProvider = Provider.of(context, listen: false);
    _cartProvider.getCartItem();
    WishListProvider _wishList = Provider.of(context, listen: false);
    _wishList.showWishlist();
  }

  bool isBool = false;

  @override
  Widget build(BuildContext context) {
    prodcutProvider = Provider.of(context);
    categoryProvider = Provider.of(context);
    Size screenSize = MediaQuery.of(context).size;
    CartProvider _cartProvider = Provider.of(context);
    WishListProvider _wishList = Provider.of(context);

    return SafeArea(
      child: RefreshIndicator(
        onRefresh: () async {
          _cartProvider.getCartItem();
          _wishList.showWishlist();
        },
        child: Scaffold(
          appBar: AppBar(
            title: Text('Fast Food'),
            actions: [
              _cartProvider.getCartDataList.isNotEmpty
                  ? Badge(
                      position: BadgePosition(top: 1, end: 1),
                      animationType: BadgeAnimationType.scale,
                      badgeContent: Text(
                        _cartProvider.getCartDataList.length.toString(),
                        style: TextStyle(color: Colors.white),
                      ),
                      child: IconButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            PageTransition(
                              type: PageTransitionType.fade,
                              child: CartScreen(),
                            ),
                          );
                        },
                        icon: Icon(Icons.shopping_cart),
                      ),
                    )
                  : IconButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          PageTransition(
                            type: PageTransitionType.fade,
                            child: CartScreen(),
                          ),
                        );
                      },
                      icon: Icon(Icons.shopping_cart),
                    ),
              _wishList.getWishlistData.isNotEmpty
                  ? Badge(
                      position: BadgePosition(top: 1, end: 1),
                      animationType: BadgeAnimationType.scale,
                      badgeContent: Text(
                        _wishList.getWishlistData.length.toString(),
                        style: TextStyle(color: Colors.white),
                      ),
                      child: IconButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            PageTransition(
                              type: PageTransitionType.fade,
                              child: WishList(),
                            ),
                          );
                        },
                        icon: Icon(Icons.favorite),
                      ),
                    )
                  : IconButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          PageTransition(
                            type: PageTransitionType.fade,
                            child: WishList(),
                          ),
                        );
                      },
                      icon: Icon(Icons.favorite),
                    ),
              SizedBox(width: 8),
            ],
          ),
          drawer: drawerCustom(context),
          body: ListView(
            children: [
              SizedBox(height: 3),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    PageTransition(
                      type: PageTransitionType.fade,
                      child: SearchScreen(
                        search: prodcutProvider!.getSearchProductList,
                      ),
                    ),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.all(3),
                  child: Container(
                    height: 60,
                    width: double.infinity,
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text('Search...'),
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.lightBlue),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 5,
              ),
              AspectRatio(
                aspectRatio: screenSize.width < 400 ? 2.5 : 4.5,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 3),
                  child: CarouselSlider(
                    items: prodcutProvider!.getSliderImage.map<Widget>((item) {
                      return FancyShimmerImage(
                        width: double.infinity,
                        errorWidget: Center(child: Text('Image not Found')),
                        imageUrl: item,
                        boxFit: BoxFit.fill,
                      );
                    }).toList(),
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
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 3, vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  // ignore: prefer_const_literals_to_create_immutables
                  children: [
                    Text(
                      'Food Category',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    // TextButton.icon(
                    //   onPressed: () {},
                    //   icon: Icon(Icons.arrow_right),
                    //   label: Text('View all'),
                    //   style: TextButton.styleFrom(primary: Colors.black),
                    // ),
                  ],
                ),
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
                            FancyShimmerImage(
                              height: 130,
                              width: 160,
                              boxFit: BoxFit.fill,
                              errorWidget:
                                  Center(child: Text('Image not Found')),
                              imageUrl: categoryProvider!
                                  .getCategoryList[index].categoryImage,
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
                                      child: Text('view'),
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
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 3, vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  // ignore: prefer_const_literals_to_create_immutables
                  children: [
                    Text(
                      'Top Selling Food',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    // TextButton.icon(
                    //   onPressed: () {},
                    //   icon: Icon(Icons.arrow_right),
                    //   label: Text('View all'),
                    //   style: TextButton.styleFrom(primary: Colors.black),
                    // ),
                  ],
                ),
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
                              PageTransition(
                                type: PageTransitionType.fade,
                                child: ProductOverview(
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
                          child: FancyShimmerImage(
                            width: screenSize.width,
                            height: 140,
                            errorWidget: Center(child: Text('Image not Found')),
                            imageUrl: prodcutProvider!
                                .getProductList[index].productImage[0],
                            boxFit: BoxFit.fill,
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
