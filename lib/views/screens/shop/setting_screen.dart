import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:shopee_seller_app/views/screens/shop/shop_details.dart';
import 'package:shopee_seller_app/views/utils/app_extensions/app_extensions.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({Key? key});

  @override
  _SettingScreenState createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  String? imageUrl; // Variable to store the image URL
  String? storeName; // Variable to store the image URL
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getCurrentUserImage();
    getName();

  }


  void getName() async {
    try {
      var user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        var querySnapshot = await FirebaseFirestore.instance.collection("SellerDetails").doc(user.uid).get();
        if (querySnapshot.exists) {
          var data = querySnapshot.data();

         setState(() {
           storeName = data?['storeName'];
         });
          print('Store Name: $storeName');
          // You can use storeName as needed, such as displaying it in your UI
        } else {
          print('Document does not exist');
        }
      }
    } catch (e) {
      print('Error getting store name: $e');
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Manage"),
      ),
      body: ListView(
        children: [
          Container(
            margin: EdgeInsetsDirectional.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
            ),
            height: context.screenHeight * 0.38, // Adjusted container height
            child: Column(
              children: [
                Container(
                  height: context.screenHeight * 0.23,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(400),
                      topRight: Radius.circular(400),
                      bottomRight: Radius.circular(55),
                      bottomLeft: Radius.circular(55),
                    ),
                    color: Color(0xfffe8eefe),
                  ),
                  child: Column(
                    children: [
                      Card(
                        color: Color(0xfff1641db),
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "Store Details",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 13,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 10, right: 10, bottom: 11),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    storeName ?? "Store name",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w900,
                                      fontSize: 15,
                                    ),
                                  ), // Added "Shop Name" text here
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(4),
                                    // Same border radius as the card
                                    child: GestureDetector(
                                      onTap: () => _showImageOptions(context),
                                      child: imageUrl != null
                                          ? Image.network(
                                        imageUrl!,
                                        height: MediaQuery.of(context).size.height * 0.060,
                                        fit: BoxFit.cover,
                                        width: MediaQuery.of(context).size.width * 0.15,
                                      )
                                          : FutureBuilder<String?>(
                                        future: _getCurrentUserImage(),
                                        builder: (context, snapshot) {
                                          if (snapshot.connectionState == ConnectionState.waiting) {
                                            return CupertinoActivityIndicator(color: Colors.yellow,);
                                          } else {
                                            if (snapshot.hasData) {
                                              return Image.network(
                                                snapshot.data!,
                                                height: MediaQuery.of(context).size.height * 0.060,
                                                fit: BoxFit.cover,
                                                width: MediaQuery.of(context).size.width * 0.15,
                                              );
                                            } else {
                                              return Image.network(
                                                "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR-RKXJ4XsJZD0N5ZRZGByBllxoQwA0lv6YF-OI1lt27A&s",
                                                height: MediaQuery.of(context).size.height * 0.060,
                                                fit: BoxFit.cover,color: Colors.blueGrey,
                                                width: MediaQuery.of(context).size.width * 0.15,
                                              );
                                            }
                                          }
                                        },
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: double.infinity,
                              child: Padding(
                                padding: const EdgeInsets.only(right: 15, left: 15, bottom: 8),
                                child: CupertinoButton(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(40),
                                  onPressed: () {
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => const SellerDetails(),));
                                  },
                                  child: Text(
                                    "Store Details",
                                    style: TextStyle(color: Color(0xfff1641db), fontSize: 15),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                          Row(
                            children: [
                              Text(
                                "Current Plan: ",
                                style: TextStyle(fontSize: 14,fontWeight: FontWeight.w600),
                              ),
                              Text(
                                "Free for ever",
                                style: TextStyle(fontSize: 14,color: Colors.red,fontWeight: FontWeight.w600),
                              ),
                            ],
                          ),
                            Text(
                              "Upgrade Now",
                              style: TextStyle(fontSize: 14,color: Color(0xfff1638db),fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }



  void _showImageOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.camera),
                title: Text('Camera'),
                onTap: () {
                  Navigator.pop(context);
                  _getImageFromCamera(context);
                },
              ),
              ListTile(
                leading: Icon(Icons.photo_library),
                title: Text('Gallery'),
                onTap: () {
                  Navigator.pop(context);
                  _getImageFromGallery(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }
  Future<String?> _getCurrentUserImage() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final doc = await FirebaseFirestore.instance.collection('SellerDetails').doc(user.uid).get();
      if (doc.exists) {
        return doc.data()?['imageUrl'];
      }
    }
    return null;
  }


  void _getImageFromCamera(BuildContext context) async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      _uploadImage(context, File(pickedFile.path));
    }
  }

  void _getImageFromGallery(BuildContext context) async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      _uploadImage(context, File(pickedFile.path));
    }
  }

  void _uploadImage(BuildContext context, File imageFile) async {
    try {
      final firebaseStorageRef = firebase_storage.FirebaseStorage.instance.ref().child('sellerImage/${DateTime.now().millisecondsSinceEpoch}.jpg');
      final uploadTask = firebaseStorageRef.putFile(imageFile);
      final snapshot = await uploadTask.whenComplete(() {});
      final downloadURL = await snapshot.ref.getDownloadURL();

      // Save downloadURL to Firestore
      await FirebaseFirestore.instance.collection('SellerDetails').add({'url': downloadURL});

      setState(() {
        imageUrl = downloadURL; // Set imageUrl to the downloaded URL
      });
    } catch (e) {
      print('Error uploading image: $e');
      // Handle error
    }
  }
}
