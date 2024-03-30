import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shopee_seller_app/views/product/widget_class.dart';

import 'Product_model.dart';

class AddProduct extends StatefulWidget {
  const AddProduct({Key? key}) : super(key: key);

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  var nameController = TextEditingController();
  var categoryController = TextEditingController();
  var priceController = TextEditingController();
  var discountController = TextEditingController();
  var unitController = TextEditingController();
  var productDetailController = TextEditingController();
  var pieceController = TextEditingController();

  final firestore = FirebaseFirestore.instance;
  File? _image;
  bool _loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.white),
        backgroundColor: Colors.blue,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_outlined),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(
          "Add Products",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 20),
            Container(
              height: 100,
              child: Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    Container(
                      height: 100,
                      width: 100,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                              width: 2,
                              color: Colors.blue,
                              style: BorderStyle.solid)),
                      child: _image == null
                          ? InkWell(
                              onTap: () async {
                                final image = await ImagePicker().pickImage(
                                  source: ImageSource.gallery,
                                );
                                if (image != null) {
                                  setState(() {
                                    _image = File(image.path);
                                  });
                                }
                              },
                              child: Icon(CupertinoIcons.camera),
                            )
                          : ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Image.file(
                                _image!,
                                fit: BoxFit.cover,
                              ),
                            ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            TextcustomField(
              controller: nameController,
              labelText: 'Product Name *',
              keyboardType: TextInputType.text,
            ),
            SizedBox(height: 20),
            TextcustomField(
              controller: categoryController,
              labelText: 'Product Category',
              keyboardType: TextInputType.text,
            ),
            SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: TextcustomField(
                    controller: priceController,
                    labelText: 'Price',
                    keyboardType: TextInputType.number,
                  ),
                ),
                Expanded(
                  child: TextcustomField(
                    controller: discountController,
                    labelText: 'Discounted Price',
                    keyboardType: TextInputType.number,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                    child: TextcustomField(
                  controller: unitController,
                  keyboardType: TextInputType.number,
                  labelText: 'Product Unit',
                )),
                Expanded(
                    child: TextcustomField(
                  controller: pieceController,
                  keyboardType: TextInputType.number,
                  labelText: ' Piece',
                )),
              ],
            ),
            const SizedBox(height: 20),
            TextcustomField(
              controller: productDetailController,
              keyboardType: TextInputType.text,
              labelText: ' Product Details',
            ),
            const SizedBox(
              height: 30,
            ),
            StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    height: 50,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Colors.blue,
                    ),
                    child: TextButton(
                      onPressed: _loading
                          ? null
                          : () async {
                              setState(() {
                                _loading = true;
                              });
                              try {
                                String imageUrl =
                                    await uploadImageToFirebaseStorage(_image!);

                                String productId =
                                    firestore.collection('products').doc().id;

                                Product product = Product(
                                  id: productId,
                                  name: nameController.text,
                                  category: categoryController.text,
                                  price: priceController.text,
                                  discount: discountController.text,
                                  unit: unitController.text,
                                  productDetail: productDetailController.text,
                                  piece: pieceController.text,
                                  imageUrl: imageUrl,
                                );

                                await firestore
                                    .collection('products')
                                    .doc(productId)
                                    .set(product.toJson());

                                nameController.clear();
                                categoryController.clear();
                                priceController.clear();
                                discountController.clear();
                                unitController.clear();
                                productDetailController.clear();
                                pieceController.clear();

                                Fluttertoast.showToast(
                                  msg: "Product added successfully!",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.BOTTOM,
                                );

                                setState(() {
                                  _loading = false;
                                });

                                Navigator.pop(context);
                              } catch (e) {
                                print('Error: $e');
                                Fluttertoast.showToast(
                                  msg:
                                      "An error occurred. Please try again later.",
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.BOTTOM,
                                );

                                setState(() {
                                  _loading = false;
                                });
                              }
                            },
                      child: _loading
                          ? CircularProgressIndicator()
                          : const Text(
                              "Add Product",
                              style:
                                  TextStyle(color: Colors.white, fontSize: 20),
                            ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<String> uploadImageToFirebaseStorage(File image) async {
    try {
      String fileName = DateTime.now().millisecondsSinceEpoch.toString();
      final firebaseStorageRef =
          FirebaseStorage.instance.ref().child('product_images/$fileName');
      await firebaseStorageRef.putFile(image);

      String imageUrl = await firebaseStorageRef.getDownloadURL();

      return imageUrl;
    } catch (e) {
      print('Error uploading image to Firebase Storage: $e');
      throw e;
    }
  }
}
