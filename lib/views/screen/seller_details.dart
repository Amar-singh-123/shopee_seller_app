import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:image_picker/image_picker.dart';
import 'package:shopee_seller_app/model/seller_details_model.dart';
import 'dart:io';

import 'package:shopee_seller_app/views/screen/setting_screen.dart';
import 'package:shopee_seller_app/views/utils/app_extensions/app_extensions.dart';

class SellerDetails extends StatefulWidget {
  const SellerDetails({Key? key});

  @override
  State<SellerDetails> createState() => _SellerDetailsState();
}

class _SellerDetailsState extends State<SellerDetails> {
  TextEditingController storeNameController = TextEditingController();
  TextEditingController businessNameController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController businessCategoryController = TextEditingController();
  TextEditingController individualController = TextEditingController();
  TextEditingController gstNumberController = TextEditingController();
  TextEditingController upiIdController = TextEditingController();
  TextEditingController fssaiLicenseNoController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController bankAccountController = TextEditingController();
  TextEditingController businessCategory = TextEditingController();

  String? imageUrl;
  File? imageFile;


  void getData(){
    var data = FirebaseAuth.instance.currentUser!.uid;
    var querySnapshot = FirebaseFirestore.instance.doc(data).collection("SellerDetails").get();
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
                onTap: () {
                  _showImageOptions(context);
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: imageUrl != null
                      ? Image.network(
                    imageUrl!,
                    height: MediaQuery.of(context).size.height * 0.060,
                    fit: BoxFit.cover,
                    width: MediaQuery.of(context).size.width * 0.15,
                  )
                      : Image.network(
                    "https://static.thenounproject.com/png/4974686-200.png",
                    height: MediaQuery.of(context).size.height * 0.060,
                    fit: BoxFit.cover,
                    width: MediaQuery.of(context).size.width * 0.15,
                  ),
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

  void _getImageFromCamera(BuildContext context) async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      setState(() {
        imageFile = File(pickedFile.path);
      });
      _uploadImage(context, imageFile!);
    }
  }

  //  _showCategoryButtonSheet(BuildContext context){
  //   showBottomSheet(context: context,
  //     builder: (BuildContext context) {
  //       return SafeArea(
  //           child: Column(
  //             mainAxisSize: MainAxisSize.min,
  //             children: <Widget>[
  //               ListView(
  //                 children: [
  //                   TextField(
  //                     controller: businessCategory,
  //                     decoration: InputDecoration(
  //                         border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
  //                         label: Text("Enter Business Category")
  //                     ),
  //                   ),
  //                   ElevatedButton(onPressed: (){
  //
  //                   },
  //                       child: Text("Submit"))
  //                 ],
  //               )
  //             ],
  //           )
  //       );
  //     },
  //   );
  // }



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
   //   if (user != null) {
       // var userId = user.uid;

        SellerDetailsModels sellerDetailsModels = SellerDetailsModels(
          sId: user?.uid,
          storeName: storeNameController.text.trim().toString(),
          sellerPhone: phoneController.text.trim().toString(),
          sellerEmail: emailController.text.trim().toString(),
          businessCategory: businessCategoryController.text.trim().toString(),
          businessName: businessNameController.text.trim().toString(),
          imageUrl: imageUrl,
        );

        await FirebaseFirestore.instance.collection('SellerDetails').doc(user?.uid).set(sellerDetailsModels.toJson());

        // Clear all text controllers after uploading data
        storeNameController.clear();
        phoneController.clear();
        emailController.clear();
        businessCategoryController.clear();
        individualController.clear();
        gstNumberController.clear();
        upiIdController.clear();
        fssaiLicenseNoController.clear();
        addressController.clear();
        bankAccountController.clear();

        // Optionally, show a success message or navigate to another screen
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


































// Padding(
//   padding: const EdgeInsets.all(10),
//   child: TextField(
//     controller: individualController,
//     decoration: InputDecoration(border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)
//     ),
//       labelText: "Individual",
//     ),
//   ),
// ),
// Padding(
//   padding: const EdgeInsets.all(10),
//   child: TextField(
//     controller: gstNumberController,
//     decoration: InputDecoration(border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)
//     ),
//       labelText: "GST Number",
//     ),
//   ),
// ),
// Padding(
//   padding: const EdgeInsets.all(10),
//   child: TextField(
//     controller: upiIdController,
//     decoration: InputDecoration(border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)
//     ),
//       labelText: "UPI Id",
//     ),
//   ),
// ),
//
// Padding(
//   padding: const EdgeInsets.all(10),
//   child: TextField(
//     controller: fssaiLicenseNoController,
//     decoration: InputDecoration(border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)
//     ),
//       labelText: "Fssai License No",
//     ),
//   ),
// ),
//
// Padding(
//   padding: const EdgeInsets.all(10),
//   child: TextField(
//     controller: addressController,
//     decoration: InputDecoration(border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)
//     ),
//       labelText: "Address",
//     ),
//   ),
// ),
//
// Padding(
//   padding: const EdgeInsets.all(10),
//   child: TextField(
//     controller: bankAccountController,
//     decoration: InputDecoration(border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)
//     ),
//       labelText: "Bank Details",
//     ),
//   ),
// ),