// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taza_khabar/provuder/checkout_provider.dart';
import 'package:taza_khabar/ui/delivery_details.dart';

class AddDeliveryAddress extends StatefulWidget {
  const AddDeliveryAddress({Key? key}) : super(key: key);

  @override
  State<AddDeliveryAddress> createState() => _AddDeliveryAddressState();
}

class _AddDeliveryAddressState extends State<AddDeliveryAddress> {
  CheckoutProvider? checkoutProvider;
  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    checkoutProvider = Provider.of(context);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
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
                  validator: (val) {
                    if (val == null || val.isEmpty) {
                      return 'please enter last name';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: checkoutProvider!.mobile,
                  decoration: InputDecoration(labelText: 'Mobile No'),
                  validator: (val) {
                    if (val == null || val.isEmpty) {
                      return 'please enter mobile no';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: checkoutProvider!.city,
                  decoration: InputDecoration(labelText: 'City'),
                  validator: (val) {
                    if (val == null || val.isEmpty) {
                      return 'please enter city';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: checkoutProvider!.area,
                  decoration: InputDecoration(labelText: 'Area'),
                  validator: (val) {
                    if (val == null || val.isEmpty) {
                      return 'please enter area';
                    }
                    return null;
                  },
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
          color: Colors.grey[200],
          child: ElevatedButton(
            onPressed: () {
              if (formKey.currentState!.validate()) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Address added'),
                    backgroundColor: Colors.lightBlue,
                  ),
                );
                checkoutProvider!.addDeliveryAddress();
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => DeliveryDetails(),
                    ));
              }
            },
            child: Text('Add address'),
          ),
        ),
      ),
    );
  }
}
