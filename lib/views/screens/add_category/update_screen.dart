import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shopee_seller_app/views/screens/add_category/show_category.dart';

import '../../../models/category_model.dart';

class UpdateCategoryScreen extends StatefulWidget {
  final CategoryModel categoryModel;
  const UpdateCategoryScreen({Key? key, required this.categoryModel}) : super(key: key);

  @override
  State<UpdateCategoryScreen> createState() => _UpdateCategoryScreenState();
}

class _UpdateCategoryScreenState extends State<UpdateCategoryScreen> {
  late TextEditingController _categoryNameController;
  late String _categoryImage;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  bool _uploadingData = false;
  bool isFromFile = false;

  @override
  void initState() {
    super.initState();
    _categoryNameController = TextEditingController(text: widget.categoryModel.categoryName);
    _categoryImage = widget.categoryModel.categoryImg!;
  }

  Future<void> _saveOrUpdateCategory(String categoryId, String imageUrl, String categoryName) async {
    try {
      if (_categoryImage.isNotEmpty && isFromFile) {String imageName = '$categoryId.jpg';
        imageUrl = await _uploadImageToFirebaseStorage(File(_categoryImage), imageName);
      }
      await _firestore.collection('shoppe_categories').doc(categoryId).update({
        'categoryId': categoryId,
        'categoryImage': imageUrl,
        'categoryName': categoryName,
        'createdAt': Timestamp.now(),
        'updatedAt': Timestamp.now(),
      });
      Fluttertoast.showToast(
        msg: "Category updated successfully!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.green,
        textColor: Colors.white,
      );

      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const ShowCategory()));
    } catch (e) {
      Fluttertoast.showToast(
        msg: "Failed to update category: $e",
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
        title: const Text("Update Category"),
        backgroundColor: Colors.blue,
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
                                _categoryImage = image.path;
                                isFromFile = true;
                              });
                            }
                          },
                          child: Container(
                            height: 80,
                            width: 80,
                            decoration: ShapeDecoration(
                              shape: OutlineInputBorder(
                                borderSide: const BorderSide(color: Colors.blue),
                                borderRadius: BorderRadius.circular(7),
                              ),
                            ),
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Expanded(
                                    child: Stack(
                                      children: [
                                        if (_categoryImage.isEmpty)
                                          const Column(
                                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Text("No Image"),
                                            ],
                                          )
                                        else
                                          (isFromFile)
                                              ? Image.file(File(_categoryImage), fit: BoxFit.cover,)
                                              : Image.network(_categoryImage, fit: BoxFit.cover,),
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
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    autofocus: true,
                    focusNode: FocusNode(),
                    controller: _categoryNameController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                      labelText: 'Category Name',
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: MaterialButton(
          color: Colors.blue,
          onPressed: _uploadingData
              ? null
              : () async {
            if (_categoryNameController.text.isEmpty) {
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
              String categoryId = widget.categoryModel.categoryId ?? '';
              String imageUrl = widget.categoryModel.categoryImg ?? '';

              if (_categoryImage.isNotEmpty) {
                String imageName = '$categoryId.jpg';
                imageUrl = await _uploadImageToFirebaseStorage(File(_categoryImage), imageName);
              }

              await _saveOrUpdateCategory(categoryId, imageUrl, _categoryNameController.text);
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
          child: CupertinoButton(
            onPressed: null,
            color: Colors.blue,
            child: _uploadingData
                ? const CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
            )
                : const Row(
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
      ),
    );
  }

  @override
  void dispose() {
    _categoryNameController.dispose();
    isFromFile = false;
    super.dispose();
  }
}
