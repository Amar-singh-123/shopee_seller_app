import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_material_color_picker/flutter_material_color_picker.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shopee_seller_app/controllers/services/app_firebase/app_firebase_auth.dart';
import 'package:shopee_seller_app/controllers/services/app_firebase/firestore_db.dart';
import 'package:shopee_seller_app/models/category/category_model.dart';
import 'package:shopee_seller_app/models/products/product_model.dart';
import 'package:shopee_seller_app/views/utils/app_extensions/app_extensions.dart';
import 'package:shopee_seller_app/views/utils/app_widgets/textfield/widget_class.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({Key? key}) : super(key: key);

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  List<File> productImages = [];
  List<String> productImagesUrls = [];
  List<String> productSize = [];
  var selectedCategory = CategoryModel();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController categoryController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController discountController = TextEditingController();
  final TextEditingController unitController = TextEditingController();
  final TextEditingController productDetailController = TextEditingController();
  final TextEditingController pieceController = TextEditingController();
  final TextEditingController sizeController = TextEditingController();

  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  bool _loading = false;
  Color screenPickerColor = Colors.white;
  List<Color> productColor = [];

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
        title: Text(
          "Add Products",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () async {
                        final pickedImage = await ImagePicker().pickImage(
                          source: ImageSource.gallery,
                        );
                        if (pickedImage != null) {
                          var file = File(pickedImage.path);
                          productImages.add(file);
                          setState(() {});
                        }
                      },
                      child: Container(
                        height: 100,
                        width: 100,
                        margin: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            width: 2,
                            color: Colors.blue,
                          ),
                        ),
                        child: productImages.isEmpty
                            ? Icon(CupertinoIcons.camera)
                            : ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.file(
                            productImages.first,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    productImages.isNotEmpty
                        ? Wrap(
                      children: List.generate(
                        productImages.length,
                            (index) => Container(
                          height: 100,
                          width: 100,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              width: 2,
                              color: Colors.blue,
                            ),
                          ),
                          child: productImages.isEmpty
                              ? Icon(CupertinoIcons.camera)
                              : ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.file(
                              productImages[index],
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    )
                        : Center(
                      child: Text("No images selected"),
                    )
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
              readOnly: true,
              onTap: () {
                selectCategory(context);
              },
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
                SizedBox(width: 20),
                Expanded(
                  child: TextcustomField(
                    controller: discountController,
                    labelText: 'Discounted Price',
                    keyboardType: TextInputType.number,
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: TextcustomField(
                    controller: unitController,
                    labelText: 'Product Unit',
                    keyboardType: TextInputType.number,
                  ),
                ),
                SizedBox(width: 20),
                Expanded(
                  child: TextcustomField(
                    controller: pieceController,
                    labelText: 'Piece',
                    keyboardType: TextInputType.number,
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            TextcustomField(
              controller: productDetailController,
              labelText: 'Product Details',
              keyboardType: TextInputType.text,
            ),
            ElevatedButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (_) => AlertDialog(
                    title: Text('Select Color'),
                    content: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: MaterialColorPicker(
                        onColorChange: (Color color) {
                          productColor.add(color);
                          setState(() {});
                        },
                        selectedColor: Colors.red,
                      ),
                    ),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text('Close'),
                      ),
                    ],
                  ),
                );
              },
              child: Text("Select Color"),
            ),
            SizedBox(height: 20),
            productColor.isNotEmpty
                ? Wrap(
              children: List.generate(
                productColor.length,
                    (index) => Container(
                  height: 40,
                  width: 40,
                  margin: EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: productColor[index],
                  ),
                ),
              ),
            )
                : Center(
              child: Text("No color selected"),
            ),
            ElevatedButton(
              onPressed: () {
                showModalBottomSheet<void>(
                  context: context,
                  builder: (BuildContext context) {
                    return Container(
                      color: Colors.amber,
                      child: Column(
                        children: [
                          Container(
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                mainAxisSize: MainAxisSize.min,
                                children: <Widget>[
                                  const Text('Select Product Size'),
                                  TextcustomField(
                                    controller: sizeController,
                                    labelText: 'Product Size',
                                    keyboardType: TextInputType.text,
                                  ),
                                  ElevatedButton(
                                    child: const Text('Close BottomSheet'),
                                    onPressed: () {
                                      productSize.add(sizeController.text);
                                      setState(() {});
                                      Navigator.pop(context);
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
              child: Text("Select Size"),
            ),
            SizedBox(height: 20),
            productSize.isNotEmpty
                ? Wrap(
              children: List.generate(
                productSize.length,
                    (index) => Container(
                  height: 40,
                  width: 40,
                  margin: EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                  child: Text(
                    productSize[index],
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ),
              ),
            )
                : Center(
              child: Text("No size selected"),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                onPressed: _addProduct,
                child: Text(
                  "Add Product",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _addProduct() async {
    setState(() {
      _loading = true;
    });

    try {
      List<String> imageUrl =
      await uploadImageToFirebaseStorage(productImages);

      String productId = await firestore.collection('products').doc().id;
print(imageUrl);
      Product product = Product(
        productId: productId,
        name: nameController.text,
        categoryId: selectedCategory.categoryId,
        price: priceController.text,
        discount: discountController.text,
        unit: unitController.text,
        description: productDetailController.text,
        qty: int.tryParse(pieceController.text) ?? 0,
        imageUrl: imageUrl.toList(),
        sellerId: AppAuth.userId,
        colors: productColor,
        createdAt: DateTime.now(),
        paymentMethod: [
          "CASH ON DELIVERY",
          "UPI",
        ],
        ratting: 0,
        status: Status(
          available: true,
          blocked: false,
          outOfStock: false,
        ),
        subCategoryId: "",
        title: "",
        updatedAt: DateTime.now(),
        totalSoldItem: 0,
        variants: productSize,
        brandId: "",
        shopId: "",
      );
      DatabaseReference databaseRef = FirebaseDatabase.instance.reference();
      await databaseRef.child('products').child(productId).set(product.toJson());
    _clearControllers();

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
        msg: "An error occurred. Please try again later.",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
      );

      setState(() {
        _loading = false;
      });
    }
  }

  void _clearControllers() {
    nameController.clear();
    categoryController.clear();
    priceController.clear();
    discountController.clear();
    unitController.clear();
    productDetailController.clear();
    pieceController.clear();
  }

  Future<List<String>> uploadImageToFirebaseStorage(
      List<File> productImages) async {
    try {
      List<String> productImageDownloadUrl = [];

      for (int i = 0; i < productImages.length; i++) {
        String fileName = DateTime.now().millisecondsSinceEpoch.toString();
        final firebaseStorageRef =
        FirebaseStorage.instance.ref().child('product_images/$fileName');

        await firebaseStorageRef.putFile(productImages[i]);
        String imageUrl = await firebaseStorageRef.getDownloadURL();
        productImageDownloadUrl.add(imageUrl.toString());
      }

      return productImageDownloadUrl;
    } catch (e) {
      print('Error uploading image to Firebase Storage: $e');
      throw e;
    }
  }

  void selectCategory(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
          stream: AppFireStoreDatabase(collection: "shoppe_category")
              .getAllAsStream()
              .streamAllData,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            }
            if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            }
            if (!snapshot.hasData || snapshot.data?.docs.isEmpty == true) {
              return Center(child: Text("No category found"));
            }

            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                var category =
                CategoryModel.fromJson(snapshot.data!.docs[index].data());
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(
                    onTap: () {
                      setState(() {
                        selectedCategory = category;
                        categoryController.text = category.categoryName ?? "";
                      });
                      Navigator.pop(context);
                    },
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: CachedNetworkImage(
                        imageUrl: category.categoryImg ?? "",
                        width: 70,
                        height: 70,
                        fit: BoxFit.cover,
                      ),
                    ),
                    title: Text(category.categoryName ?? ""),
                  ),
                );
              },
            );
          },
        );
      },
    );
  }
}
