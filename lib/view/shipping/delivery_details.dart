// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:taza_khabar/provider/checkout_provider.dart';
import 'package:taza_khabar/view/shipping/payment_screen.dart';

class DeliveryDetails extends StatefulWidget {
  const DeliveryDetails({Key? key}) : super(key: key);

  @override
  State<DeliveryDetails> createState() => _DeliveryDetailsState();
}

class _DeliveryDetailsState extends State<DeliveryDetails> {
  @override
  void initState() {
    super.initState();
    CheckoutProvider checkoutProvider = Provider.of(context, listen: false);
    checkoutProvider.getDeliveryAddress();
  }

  bool cash = false;
  bool bkash = false;

  @override
  Widget build(BuildContext context) {
    CheckoutProvider checkoutProvider = Provider.of(context);
    // checkoutProvider.getDeliveryAddress();

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          title: Text('Delivery Details'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            children: [
              Row(
                children: [
                  Image.network(
                    'https://firebasestorage.googleapis.com/v0/b/fresh-vegetable-1918b.appspot.com/o/location.png?alt=media&token=cf38c87b-9c17-49d4-9041-4a1014210646',
                    height: 100,
                    width: 100,
                  ),
                  SizedBox(width: 22),
                  Text('Deliver to', textScaleFactor: 1.2),
                ],
              ),
              Divider(color: Colors.grey),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: checkoutProvider.getDeliveryAddressData
                    .map((data) => Card(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('First name: ${data.firstName}'),
                                Text('Last name: ${data.lastName}'),
                                Text('Mobile No: ${data.mobile}'),
                                Text('City: ${data.city}'),
                                Text('Area: ${data.area}'),
                              ],
                            ),
                          ),
                        ))
                    .toList(),
              ),
              Divider(color: Colors.grey),
              SizedBox(height: 20),
              Text('Payment By'),
              ListTile(
                title: Text('Cash on delivery'),
                leading: Checkbox(
                  activeColor: Colors.amber,
                  checkColor: Colors.blue,
                  side: BorderSide(color: Colors.lightBlue),
                  value: cash,
                  onChanged: (value) {
                    setState(() {
                      cash = value!;
                    });
                  },
                ),
              ),
              ListTile(
                title: Text('Bkash'),
                leading: Checkbox(
                  activeColor: Colors.amber,
                  checkColor: Colors.blue,
                  side: BorderSide(color: Colors.lightBlue),
                  value: bkash,
                  onChanged: (value) {
                    setState(() {
                      bkash = value!;
                    });
                  },
                ),
              ),
              SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
        bottomNavigationBar: Container(
          margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          width: double.infinity,
          height: 48,
          child: ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                PageTransition(
                  type: PageTransitionType.fade,
                  child: PaymentScreeen(
                    fName: checkoutProvider.firstName.text,
                    lName: checkoutProvider.lastName.text,
                    mobile: checkoutProvider.mobile.text,
                    city: checkoutProvider.city.text,
                    area: checkoutProvider.area.text,
                  ),
                ),
              );
            },
            child: Text(
              'Continue',
              style: TextStyle(color: Theme.of(context).hintColor),
            ),
            style: ElevatedButton.styleFrom(
                primary: Theme.of(context).primaryColor),
          ),
        ),
        floatingActionButton: TextButton.icon(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.edit),
          label: Text('Edit address'),
        ),
      ),
    );
  }
}
