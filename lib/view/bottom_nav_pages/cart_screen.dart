import 'package:animated_switcher_plus/animated_switcher_plus.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:taza_khabar/provider/cart_provider.dart';
import 'package:taza_khabar/view/product_overview.dart';
import 'package:taza_khabar/view/shipping/add_delivery_address.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  CartProvider? cartProvider;

  @override
  void initState() {
    super.initState();
    CartProvider cartProvider =
        Provider.of<CartProvider>(context, listen: false);
    cartProvider.getCartItem();
    cartProvider.getTotalPrice();
  }

  bool _showFirstChild = true;

  @override
  Widget build(BuildContext context) {
    cartProvider = Provider.of(context);

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Cart items'),
          actions: [
            Center(child: Text('Pull down to refrash')),
            SizedBox(width: 4)
          ],
        ),
        body: cartProvider!.getCartDataList.isEmpty
            ? Center(
                child: Text(
                'NO ITEM',
                textScaleFactor: 2,
                style: TextStyle(
                  shadows: [
                    Shadow(
                      color: Colors.grey,
                      blurRadius: 4,
                      offset: Offset(2, 2),
                    )
                  ],
                ),
              ))
            : RefreshIndicator(
                color: Theme.of(context).primaryColor,
                onRefresh: () async {
                  cartProvider!.getCartItem();
                },
                child: ListView(
                  children: cartProvider!.getCartDataList
                      .map(
                        (data) => Column(
                          children: [
                            Card(
                              elevation: 2,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        PageTransition(
                                          type: PageTransitionType.fade,
                                          child: ProductOverview(
                                            name: data.cartName,
                                            price: data.cartPrice,
                                            image: data.cartImage,
                                            productDescription:
                                                data.cartDescription,
                                            productId: data.cartId,
                                          ),
                                        ),
                                      );
                                    },
                                    child: FancyShimmerImage(
                                      height: 100,
                                      width: 100,
                                      boxFit: BoxFit.cover,
                                      errorWidget: Center(
                                          child: Text('Image not Found')),
                                      imageUrl: data.cartImage[0],
                                    ),
                                  ),
                                  Container(
                                    height: 100,
                                    width: 100,
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 9,
                                      ),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            data.cartName,
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          Text(
                                            'TK ${data.cartPrice * data.cartQty}',
                                          ),
                                          Text(
                                            'Quantity ' +
                                                data.cartQty.toString(),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  Column(
                                    children: [
                                      Card(
                                        elevation: 2,
                                        child: Container(
                                          width: 100,
                                          height: 36,
                                          decoration: BoxDecoration(
                                            color:
                                                Theme.of(context).primaryColor,
                                            borderRadius:
                                                BorderRadius.circular(4),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 4),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                InkWell(
                                                  onTap: () {
                                                    if (data.cartQty > 1) {
                                                      setState(() {
                                                        data.cartQty--;
                                                        _showFirstChild =
                                                            !_showFirstChild;
                                                      });
                                                      cartProvider!.updateCart(
                                                        cartId: data.cartId,
                                                        cartImage:
                                                            data.cartImage,
                                                        cartName: data.cartName,
                                                        cartPrice:
                                                            data.cartPrice,
                                                        cartQty: data.cartQty,
                                                      );
                                                    }
                                                  },
                                                  child: Icon(
                                                    Icons.remove,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                                Text(
                                                  data.cartQty.toString(),
                                                  style: TextStyle(
                                                      color: Colors.black),
                                                ),
                                                InkWell(
                                                  onTap: () async {
                                                    if (data.cartQty < 10) {
                                                      setState(() {
                                                        data.cartQty++;
                                                        _showFirstChild =
                                                            !_showFirstChild;
                                                      });
                                                    }
                                                    cartProvider!.updateCart(
                                                      cartId: data.cartId,
                                                      cartImage: data.cartImage,
                                                      cartName: data.cartName,
                                                      cartPrice: data.cartPrice,
                                                      cartQty: data.cartQty,
                                                    );
                                                  },
                                                  child: Icon(
                                                    Icons.add,
                                                    color: Colors.black,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      ElevatedButton.icon(
                                        onPressed: () async {
                                          cartProvider!.deleteCart(data.cartId);
                                          setState(() {
                                            cartProvider!.getCartItem();
                                          });
                                        },
                                        icon: Icon(Icons.delete),
                                        label: Text('Delete'),
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
                ),
              ),
        bottomNavigationBar: cartProvider!.getCartDataList.isEmpty
            ? SizedBox()
            : Container(
                margin: EdgeInsets.symmetric(vertical: 8, horizontal: 0),
                height: 55,
                width: double.infinity,
                child: Card(
                  elevation: 2,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        AnimatedSwitcherTranslation.top(
                          duration: const Duration(milliseconds: 500),
                          child: Container(
                            key: ValueKey(_showFirstChild),
                            padding: const EdgeInsets.all(5),
                            child: Text(_showFirstChild
                                ? 'Total Amount: TK ' +
                                    cartProvider!.getTotalPrice().toString()
                                : 'Total Amount: TK ' +
                                    cartProvider!.getTotalPrice().toString()),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              PageTransition(
                                type: PageTransitionType.fade,
                                child: AddDeliveryAddress(),
                              ),
                            );
                          },
                          child: Text('Checkout'),
                        )
                      ],
                    ),
                  ),
                ),
              ),
      ),
    );
  }
}
