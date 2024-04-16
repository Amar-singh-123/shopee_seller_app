import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shopee_seller_app/controllers/services/app_firebase/app_firebase_auth.dart';
import 'package:shopee_seller_app/views/screens/catalogue/category/show_category.dart';

import '../../../../models/category/category_model.dart';

class AddCategoriesScreen extends StatefulWidget {
  const AddCategoriesScreen({Key? key}) : super(key: key);

  @override
  State<AddCategoriesScreen> createState() => _AddCategoriesScreenState();
}

class _AddCategoriesScreenState extends State<AddCategoriesScreen> {
  late TextEditingController categoriesCon;
  File? _image;
  final FirebaseFirestore fireStore = FirebaseFirestore.instance;
  bool _uploadingData = false;
  @override
  void initState() {
    super.initState();
    categoriesCon = TextEditingController();
  }

  Future<void> _addCategoryToFireStore(String categoryId, String imageUrl, String categoryName) async {
    CategoryModel categoryModel = CategoryModel(
      categoryId: categoryId,
      sellerId: AppAuth.userId,
      categoryImg: imageUrl,
      categoryName: categoryName,
      createdAt: Timestamp.now().toString(),
      updatedAt: Timestamp.now().toString(),
    );
    try {
      await fireStore
          .collection('shoppe_category')
          .doc(categoryId)
          .set(categoryModel.toJson());
      Fluttertoast.showToast(
        msg: "Category added successfully!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.green,
        textColor: Colors.white,
      );
      Navigator.pop(context);
    } catch (e) {
      Fluttertoast.showToast(
        msg: "Failed to add category: $e",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
      );
    } finally {
      setState(() {
        _uploadingData = false;
      });
    }
  }

  Future<String> _uploadImageToFirebaseStorage(File imageFile, String imageName) async {
    try {
      final Reference storageReference = FirebaseStorage.instance.ref().child('category_images/$imageName');
      final UploadTask uploadTask = storageReference.putFile(imageFile);
      final TaskSnapshot taskSnapshot = await uploadTask;
      final String imageUrl = await taskSnapshot.ref.getDownloadURL();
      return imageUrl;
    } catch (e) {
      throw Exception("Failed to upload image: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Add New Category"),
        backgroundColor: Colors.white,
        elevation: 4,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              children: [
                SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.all(20.0),
                  child: Stack(
                    children: [
                      Center(
                        child: InkWell(
                          borderRadius: BorderRadius.circular(7),
                          onTap: () async {
                            final image = await ImagePicker().pickImage(source: ImageSource.gallery);
                            if (image != null) {
                              setState(() {
                                _image = File(image.path);
                              });
                            }
                          },
                          child: Container(
                            height: 80,
                            width: 80,
                            decoration: ShapeDecoration(
                              shape: OutlineInputBorder(
                                  borderSide:
                                      const BorderSide(color: Colors.blue),
                                  borderRadius: BorderRadius.circular(7)),
                            ),
                            child: Center(
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Expanded(
                                    child: Stack(
                                      children: [
                                        _image == null
                                            ? const Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  Positioned(
                                                    left: 160,
                                                    top: 10,
                                                    child: Icon(
                                                        Icons
                                                            .add_a_photo_outlined,
                                                        color: Colors.blue),
                                                  ),
                                                  Positioned(
                                                    left: 145,
                                                    top: 50,
                                                    child: Text(
                                                      "Add Image",
                                                      style: TextStyle(
                                                          color: Colors.blue,
                                                          fontSize: 13),
                                                    ),
                                                  ),
                                                ],
                                              )
                                            : Image.file(
                                                fit: BoxFit.cover,
                                                _image!,
                                              ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                  Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    autofocus: true,
                    focusNode: FocusNode(),
                    controller: categoriesCon,
                    style: TextStyle(color:  Colors.black),
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        labelText: 'Category Name'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: CupertinoButton(
          onPressed: _uploadingData
              ? null
              : () async {
                  if (_image == null) {
                    Fluttertoast.showToast(
                      msg: "Please select an image",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                      backgroundColor: Colors.red,
                      textColor: Colors.white,
                    );
                    return;
                  }
                  if (categoriesCon.text.isEmpty) {
                    Fluttertoast.showToast(
                      msg: "Please enter a category name",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                      backgroundColor: Colors.red,
                      textColor: Colors.white,
                    );
                    return;
                  }

                  setState(() {
                    _uploadingData = true;
                  });
                  try {
                    String categoryId = fireStore.collection('shoppe_category').doc().id;

                    String imageName = '$categoryId.jpg';
                    String imageUrl = await _uploadImageToFirebaseStorage(_image!, imageName);
                    await _addCategoryToFireStore(categoryId, imageUrl, categoriesCon.text);
                  } catch (e) {
                    Fluttertoast.showToast(
                      msg: "Failed to save category: $e",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                      backgroundColor: Colors.red,
                      textColor: Colors.white,
                    );
                  }
                },
          color: Colors.blueAccent,
          child: _uploadingData
              ? const CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                ) : const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.save,
                      color: Colors.white,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 7),
                      child: Text(
                        "Save",
                        style: TextStyle(color: Colors.white),
                      ),
                    )
                  ],
                ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    categoriesCon.dispose();
    super.dispose();
  }
}
