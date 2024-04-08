import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_material_color_picker/flutter_material_color_picker.dart';
import 'package:image_picker/image_picker.dart';

import '../../../models/category/category_model.dart';
import '../../utils/app_widgets/textfield/widget_class.dart';

class ProductEdit extends StatefulWidget {
  const ProductEdit({super.key});

  @override
  State<ProductEdit> createState() => _ProductEditState();
}

class _ProductEditState extends State<ProductEdit> {
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
  List<int> productColor = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: Colors.blue,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_outlined),
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
                          if (productImages.length < 5) {
                            productImages.add(file);
                            setState(() {});
                          } else {
                            // Handle if the maximum number of images (5) is reached
                            // You can show a toast, snackbar, or any other form of notification
                            print('Maximum number of images reached');
                          }
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
                          margin: const EdgeInsets.all(5),
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
                              ? const Icon(CupertinoIcons.camera)
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
                        : const Center(
                      child: Text("No images selected"),
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            TextcustomField(
              controller: nameController,
              labelText: 'Product Name *',
              keyboardType: TextInputType.text,
            ),
            const SizedBox(height: 20),
            TextcustomField(
              controller: categoryController,
              labelText: 'Product Category',
              keyboardType: TextInputType.text,
              readOnly: true,
              onTap: () {
              },
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: TextcustomField(
                    controller: priceController,
                    labelText: 'Price',
                    keyboardType: TextInputType.number,
                  ),
                ),
                const SizedBox(width: 20),
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
                    labelText: 'Product Unit',
                    keyboardType: TextInputType.number,
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: TextcustomField(
                    controller: pieceController,
                    labelText: 'Piece',
                    keyboardType: TextInputType.number,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            TextcustomField(
              controller: productDetailController,
              labelText: 'Product Details',
              keyboardType: TextInputType.text,
            ),
            Container(
              margin: const EdgeInsets.only(left: 10, right: 10),
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.blue),
                ),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (_) => AlertDialog(
                      title: const Text(
                        'Select Color',
                      ),
                      content: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: MaterialColorPicker(
                          onColorChange: (Color color) {
                            productColor.add(color.value);
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
                child: Text("Select Color",
                    style: TextStyle(color: Colors.white, fontSize: 17)),
              ),
            ),
            const SizedBox(height: 20),
            productColor.isNotEmpty
                ? Wrap(
              children: List.generate(
                productColor.length,
                    (index) => Container(
                  height: 40,
                  width: 40,
                  margin: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(productColor[index]),
                  ),
                ),
              ),
            )
                : const Center(
              child: Text("No color selected"),
            ),
            Container(
              margin: const EdgeInsets.only(
                left: 10,
                right: 10,
              ),
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.blue),
                ),
                onPressed: () {
                  showModalBottomSheet<void>(
                    context: context,
                    builder: (BuildContext context) {
                      return Container(
                        color: Colors.white70,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Container(margin: const EdgeInsets.all(10),child:IconButton(onPressed: () {
                              Navigator.pop(context);
                            }, icon: const Icon(Icons.close)),),
                            Column(
                              children: <Widget>[
                                const Text(
                                  'Select Product Size',
                                ),
                                TextcustomField(
                                  controller: sizeController,
                                  labelText: 'Product Size',
                                  keyboardType: TextInputType.text,
                                ),
                                ElevatedButton(
                                  child: const Text(
                                    'Add size',
                                  ),
                                  onPressed: () {
                                    setState(() {});
                                    productSize.add(sizeController.text);
                                  },
                                ),
                                const SizedBox(height: 20),
                                productSize.isNotEmpty
                                    ? Wrap(
                                  children: List.generate(
                                    productSize.length,
                                        (index) => Container(
                                      height: 40,
                                      width: 40,
                                      margin: EdgeInsets.all(10),
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                      ),
                                      child: Text(
                                        productSize[index],
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                                    : const Center(
                                  child: Text(
                                    "No size selected",
                                  ),
                                ),

                              ],
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
                child: const Text("Select Size",
                    style: TextStyle(color: Colors.white, fontSize: 17)),
              ),
            ),
            const SizedBox(height: 20),
            productSize.isNotEmpty
                ? Wrap(
              children: List.generate(
                productSize.length,
                    (index) => Container(
                  height: 40,
                  width: 40,
                  margin: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                  ),
                  child: Text(
                    productSize[index],
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            )
                : const Center(
              child: Text(
                "No size selected",
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.blue),
                ),
                onPressed: () {

                },
                child: const Text(
                  "Add Product",
                  style: TextStyle(color: Colors.white, fontSize: 17),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
