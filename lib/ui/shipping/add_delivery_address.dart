// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:taza_khabar/provider/checkout_provider.dart';
import 'package:taza_khabar/provider/user_provider.dart';
import 'package:taza_khabar/ui/shipping/delivery_details.dart';

class AddDeliveryAddress extends StatefulWidget {
  const AddDeliveryAddress({Key? key}) : super(key: key);

  @override
  State<AddDeliveryAddress> createState() => _AddDeliveryAddressState();
}

class _AddDeliveryAddressState extends State<AddDeliveryAddress> {
  CheckoutProvider? checkoutProvider;
  UserProvider? userProvider;
  @override
  void dispose() {
    super.dispose();
    checkoutProvider!.firstName.clear();
    checkoutProvider!.lastName.clear();
    checkoutProvider!.mobile.clear();
    checkoutProvider!.city.clear();
    checkoutProvider!.area.clear();
  }

  var userId;
  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    checkoutProvider = Provider.of(context);
    // var userId = userProvider!.currentData.first;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
          title: Text('Add delivery address'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: formKey,
            child: ListView(
              children: [
                TextFormField(
                  controller: checkoutProvider!.firstName,
                  decoration: InputDecoration(labelText: 'First Name'),
                  validator: (val) {
                    if (val == null || val.isEmpty) {
                      return 'please enter first name';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: checkoutProvider!.lastName,
                  decoration: InputDecoration(labelText: 'Last Name'),
                  // validator: (val) {
                  //   if (val == null || val.isEmpty) {
                  //     return 'please enter last name';
                  //   }
                  //   return null;
                  // },
                ),
                TextFormField(
                  controller: checkoutProvider!.mobile,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(labelText: 'Mobile No'),
                  // validator: (val) {
                  //   if (val == null || val.isEmpty) {
                  //     return 'please enter mobile no';
                  //   }
                  //   return null;
                  // },
                ),
                TextFormField(
                  controller: checkoutProvider!.city,
                  decoration: InputDecoration(labelText: 'City'),
                  // validator: (val) {
                  //   if (val == null || val.isEmpty) {
                  //     return 'please enter city';
                  //   }
                  //   return null;
                  // },
                ),
                TextFormField(
                  controller: checkoutProvider!.area,
                  decoration: InputDecoration(labelText: 'Area'),
                  // validator: (val) {
                  //   if (val == null || val.isEmpty) {
                  //     return 'please enter area';
                  //   }
                  //   return null;
                  // },
                ),
                SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: Container(
          margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          width: double.infinity,
          height: 48,
          child: ElevatedButton(
            onPressed: () {
              if (formKey.currentState!.validate()) {
                checkoutProvider!.addDeliveryAddress();
                Navigator.push(
                  context,
                  PageTransition(
                    type: PageTransitionType.fade,
                    child: DeliveryDetails(),
                  ),
                );
              }
            },
            child: Text(
              'Add address',
              style: TextStyle(color: Theme.of(context).hintColor),
            ),
            style: ElevatedButton.styleFrom(
                primary: Theme.of(context).primaryColor),
          ),
        ),
      ),
    );
  }
}
