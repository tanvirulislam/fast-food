// ignore_for_file: unnecessary_const, prefer_const_constructors, avoid_print

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:taza_khabar/widget/custom_text_filed.dart';

class AddProducts extends StatefulWidget {
  const AddProducts({Key? key}) : super(key: key);

  @override
  State<AddProducts> createState() => _AddProductsState();
}

class _AddProductsState extends State<AddProducts> {
  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController quantityController = TextEditingController();

  var key = GlobalKey<FormState>();
  String? imageUrl;

  void clearText() {
    nameController.clear();
    descriptionController.clear();
    priceController.clear();
    quantityController.clear();
  }

  final Stream<QuerySnapshot> _stream = FirebaseFirestore.instance
      .collection('products')
      .orderBy('product-name', descending: false)
      .snapshots();

  delete(productId) {
    FirebaseFirestore.instance
        .collection('newProducts')
        .doc(productId)
        .delete();
  }

  @override
  Widget build(BuildContext context) {
    String id = DateTime.now().microsecondsSinceEpoch.toString();

    uploadImage() async {
      // pick an image-------------
      ImagePicker imagePicker = ImagePicker();
      XFile? file = await imagePicker.pickImage(source: ImageSource.gallery);
      if (file == null) return;

      // Get a referance to storeage root
      Reference referenceRoot = FirebaseStorage.instance.ref();
      Reference referenceDirImage = referenceRoot.child('images');

      // create a referance for the image to be stored
      Reference referenceImageToUpload = referenceDirImage.child(id);
      try {
        // store the image file
        await referenceImageToUpload.putFile(File(file.path));

        //  get downloadUrl
        imageUrl = await referenceImageToUpload.getDownloadURL();
      } catch (e) {
        print(e);
      }
    }

    addProduct() async {
      await FirebaseFirestore.instance
          .collection('products')
          .doc(id)
          .set({
            'productId': id,
            'product-name': nameController.text,
            'product-price': int.parse(priceController.text),
            'product-dsrp': descriptionController.text,
            'product-img': [imageUrl],
          })
          .then((value) => print("Product Added-----------------"))
          .catchError((error) =>
              print("---------------------Failed to add user: $error"));
    }

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Add product'),
          backgroundColor: Theme.of(context).primaryColor,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Form(
                  key: key,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Text('Select image'),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: InkWell(
                              onTap: () async {
                                setState(() {
                                  id;
                                });
                                uploadImage();
                              },
                              child: const Icon(
                                Icons.image,
                                size: 40,
                                color: Colors.cyan,
                              ),
                            ),
                          ),
                        ],
                      ),
                      customeTextField(
                        'Product name',
                        (value) {
                          if (value == null || value.isEmpty) {
                            return 'enter name';
                          }
                          return null;
                        },
                        nameController,
                        TextInputType.name,
                      ),
                      customeTextField(
                        'Product description',
                        (value) {
                          if (value == null || value.isEmpty) {
                            return 'enter name';
                          }
                          return null;
                        },
                        descriptionController,
                        TextInputType.name,
                      ),
                      customeTextField(
                        'Product price',
                        (value) {
                          if (value == null || value.isEmpty) {
                            return 'enter price';
                          }
                          return null;
                        },
                        priceController,
                        TextInputType.number,
                      ),
                      const SizedBox(height: 20),
                      Center(
                        child: ElevatedButton(
                          onPressed: () async {
                            setState(() {
                              id;
                            });
                            if (key.currentState!.validate()) {
                              if (imageUrl != null) {
                                addProduct();
                                clearText();
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    backgroundColor:
                                        Theme.of(context).primaryColor,
                                    content: const Text('product upload'),
                                  ),
                                );
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Please Select an image'),
                                  ),
                                );
                              }
                            }
                          },
                          child: const Text('submit'),
                          style: ElevatedButton.styleFrom(
                            primary: Colors.cyan,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 30,
                              vertical: 12,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Product List',
                textScaleFactor: 1.6,
              ),
              StreamBuilder(
                stream: _stream,
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasError) {
                    return const Text('Something went wrong');
                  } else if (snapshot.connectionState ==
                      ConnectionState.waiting) {
                    return const Center(
                      child: const Text(
                        "Loading",
                        textScaleFactor: 1.4,
                      ),
                    );
                  }
                  return Column(
                    children: snapshot.data!.docs.map((data) {
                      return Card(
                        elevation: 2,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            FancyShimmerImage(
                              height: 90,
                              width: 100,
                              boxFit: BoxFit.cover,
                              errorWidget:
                                  Center(child: Text('Image not Found')),
                              imageUrl: data['product-img'][0],
                            ),
                            Text(
                              data['product-name'],
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text('TK ${data['product-price'].toString()}'),
                            IconButton(
                              onPressed: () {
                                delete(data.id);
                              },
                              icon: Icon(
                                Icons.delete,
                                color: Theme.of(context).hintColor,
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
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
