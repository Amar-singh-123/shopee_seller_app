//
// import 'dart:io';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:shopee_seller_app/views/screens/home/home_screen.dart';
// import 'package:shopee_seller_app/views/utils/app_extensions/app_extensions.dart';
// import '../models/profile/profile_model.dart';
// import '../views/screens/profile/profile_screen.dart';
//
// class AppController{
//   BuildContext context;
//   AppController({required this.context});
//   void setDataToFirebase(ProfileModel userData,) {
//     var id = FirebaseAuth.instance.currentUser?.uid;
//     FirebaseFirestore.instance.collection('SellerProfilm e').doc(id).set(userData.toJson())
//         .then((value) {
//      context.pushReplace(ProfileScreen());
//     }).catchError((error) {
//       print('Failed to set data: $error');
//     });
//   }
//
//
//   upload(ProfileModel seller) async {
//     if (seller.name!.isEmpty ||
//         seller.email!.isEmpty ||
//         seller.address!.isEmpty ||
//         seller.age! <= 0 ||
//         seller.gender!.isEmpty ||
//         seller.imageUrl!.isEmpty) {
//       showDialog(
//         context: context,
//         builder: (BuildContext context) {
//           return AlertDialog(
//             title: const Text("Enter required fields"),
//             actions: [
//               TextButton(
//                 onPressed: () {
//                   Navigator.pop(context);
//                 },
//                 child: const Text("Ok"),
//               ),
//             ],
//           );
//         },
//       );
//     } else {
//       try {
//         UploadTask uploadTask = FirebaseStorage.instance
//             .ref()
//             .child('profile_pics') // Use email as filename
//             .putFile(File(seller.imageUrl.toString()));
//         TaskSnapshot taskSnapshot = await uploadTask;
//         String url = await taskSnapshot.ref.getDownloadURL();
//         var id = FirebaseAuth.instance.currentUser?.uid;
//         await FirebaseFirestore.instance
//             .collection("Seller_Profile")
//             .doc(id)
//             .set({
//           "Id": id,
//           "name": seller.name,
//           "Address": seller.address,
//           "Age": seller.age,
//           "Gender": seller.gender,
//           "image": url,
//         });
//
//         // Show success message
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(content: Text('Registration Successful')),
//         );
//         Get.offAll(()=>const HomeScreen());
//       } catch (ex) {
//         // Show error message
//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(content: Text('Registration failed')),
//         );
//       }
//     }
//   }
//
//   // Future<void> _signOut() async {
//   //   try {
//   //     await FirebaseAuth.instance.signOut();
//   //     Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginScreen(),));
//   //   } catch (e) {
//   //     print("Error signing out: $e");
//   //   }
//   // }
// }
