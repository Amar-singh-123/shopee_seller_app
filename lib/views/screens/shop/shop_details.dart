import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:image_picker/image_picker.dart';
import 'package:shopee_seller_app/models/shopModel/shop_model.dart';
import 'dart:io';
import 'package:shopee_seller_app/views/utils/app_extensions/app_extensions.dart';
import '../settings/setting_screen.dart';

class ShopDetailsScreen extends StatefulWidget {
  const ShopDetailsScreen({Key? key});

  @override
  State<ShopDetailsScreen> createState() => _ShopDetailsScreenState();
}

class _ShopDetailsScreenState extends State<ShopDetailsScreen> {
  TextEditingController storeNameController = TextEditingController();
  TextEditingController businessNameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController businessCategoryController = TextEditingController();

  String? imageUrl;
  File? imageFile;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getCurrentUserImage();
    getData();
  }

  void getData()async{
    User? user = FirebaseAuth.instance.currentUser;
    if(user != null){
    final doc = await FirebaseFirestore.instance.collection("SellerDetails").doc(user.uid).get();
      if(doc.exists){
        setState(() {
          storeNameController.text = doc.data()?["storeName"] ?? "";
          businessNameController.text = doc.data()?["businessName"]??"";
          phoneController.text = doc.data()?["sellerPhone"]?? "";
          emailController.text = doc.data()?["sellerEmail"]?? "";
          businessCategoryController.text = doc.data()?["businessCategory"]?? "";
        });
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.close),
        ),
        title: Text("Store Details"),
      ),
      body: ListView(
        physics: BouncingScrollPhysics(),
        children: [
          Column(
            children: [
              20.height,
              GestureDetector(
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

              Text("Update Logo"),
              80.height,
              Padding(
                padding: const EdgeInsets.all(10),
                child: TextField(
                  controller: storeNameController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5),
                    ),
                    labelText: "Store Name",
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(10),
                child: TextField(
                  controller: businessNameController,
                  decoration: InputDecoration(border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)
                  ),
                    labelText: "Business Name",
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: TextField(
                  controller: phoneController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)
                  ),
                    labelText: "Phone",
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(10),
                child: TextField(
                  controller: emailController,
                  decoration: InputDecoration(border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)
                  ),
                    labelText: "Email Address",
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(10),
                child: TextField(
                  // onTap: _showCategoryButtonSheet(context),
                  controller: businessCategoryController,
                  decoration: InputDecoration(border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)
                  ),
                    labelText: "Business Category",
                  ),
                ),
              ),
              40.height,
            ],
          )
        ],
      ),
      bottomNavigationBar: SizedBox(
        width: double.infinity,
        height: 60,
        child: ElevatedButton(
          style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(Color(0xfff1024db)),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.zero,
              ),
            ),
          ),
          onPressed: () {
            _saveSellerDetails();
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.save,
                color: Colors.white,
              ),
              Text(
                "Save",
                style: TextStyle(color: Colors.white),
              )
            ],
          ),
        ),
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
      setState(() {
        imageFile = File(pickedFile.path);
      });
      _uploadImage(context, imageFile!);
    }
  }

  void _getImageFromGallery(BuildContext context) async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        imageFile = File(pickedFile.path);
      });
      _uploadImage(context, imageFile!);
    }
  }

  void _uploadImage(BuildContext context, File imageFile) async {
    try {
      final userId = FirebaseAuth.instance.currentUser!.uid;
      final firebaseStorageRef = firebase_storage.FirebaseStorage.instance.ref().child('sellerImage/$userId.jpg');
      final uploadTask = firebaseStorageRef.putFile(imageFile);
      final snapshot = await uploadTask.whenComplete(() {});
      final downloadURL = await snapshot.ref.getDownloadURL();

      setState(() {
        imageUrl = downloadURL;
      });
    } catch (e) {
      print('Error uploading image: $e');
    }
  }

  void _saveSellerDetails() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
        SellerDetailsModels sellerDetailsModels = SellerDetailsModels(
          sId: user?.uid,
          storeName: storeNameController.text.trim().toString(),
          sellerPhone: phoneController.text.trim().toString(),
          sellerEmail: emailController.text.trim().toString(),
          businessCategory: businessCategoryController.text.trim().toString(),
          businessName: businessNameController.text.trim().toString(),
          imageUrl: imageUrl.toString(),
        );

        await FirebaseFirestore.instance.collection('SellerDetails').doc(user?.uid).update(sellerDetailsModels.toJson());
        // Clear all text controllers after uploading data
        storeNameController.clear();
        phoneController.clear();
        emailController.clear();
        businessCategoryController.clear();
        businessNameController.clear();

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Seller details saved successfully!'),
          ),
        );
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SettingScreen()));
      // } else {
      //   print('User is not authenticated');
      //   // Handle the case where the user is not authenticated
      // }
    } catch (e) {
      // Handle errors
      print('Error saving seller details: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to save seller details. Please try again.'),
        ),
      );
    }
  }

}







