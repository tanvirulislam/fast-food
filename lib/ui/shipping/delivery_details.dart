// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taza_khabar/provuder/checkout_provider.dart';
import 'package:taza_khabar/ui/shipping/payment_screen.dart';

class DeliveryDetails extends StatefulWidget {
  const DeliveryDetails({Key? key}) : super(key: key);

  @override
  State<DeliveryDetails> createState() => _DeliveryDetailsState();
}

class _DeliveryDetailsState extends State<DeliveryDetails> {
  // CheckoutProvider? checkoutProvider;
  var deliveryAddress;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    CheckoutProvider checkoutProvider = Provider.of(context, listen: false);
    checkoutProvider.getDeliveryAddress();
  }

  @override
  Widget build(BuildContext context) {
    CheckoutProvider checkoutProvider = Provider.of(context);
    // checkoutProvider.getDeliveryAddress();

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
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
              )
            ],
          ),
        ),
        bottomNavigationBar: Container(
          margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          width: double.infinity,
          height: 48,
          color: Colors.grey[200],
          child: ElevatedButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => PaymentScreeen(
                      fName: checkoutProvider.firstName.text,
                      lName: checkoutProvider.lastName.text,
                      mobile: checkoutProvider.mobile.text,
                      city: checkoutProvider.city.text,
                      area: checkoutProvider.area.text,
                    ),
                  ));
            },
            child: Text('Payment'),
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
