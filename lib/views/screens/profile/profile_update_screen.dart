// import 'dart:io';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:shopee_seller_app/views/screens/profile/profile_screen.dart';
//
// class UpdateScreens extends StatefulWidget {
//   final String id;
//   final String username;
//   final String address;
//   final String age;
//   final String gender;
//   final String image;
//
//   const UpdateScreens({
//     Key? key,
//     required this.id,
//     required this.username,
//     required this.address,
//     required this.age,
//     required this.gender,
//     required this.image, required email,
//   }) : super(key: key);
//
//   @override
//   State<UpdateScreens> createState() => _UpdateScreensState();
// }
//
// class _UpdateScreensState extends State<UpdateScreens> {
//   TextEditingController usernameController = TextEditingController();
//   TextEditingController addressController = TextEditingController();
//   TextEditingController ageController = TextEditingController();
//   TextEditingController genderController = TextEditingController();
//   File? pickedImage;
//
//   @override
//   void initState() {
//     super.initState();
//     // Initialize controllers with initial values
//     usernameController.text = widget.username;
//     addressController.text = widget.address;
//     ageController.text = widget.age;
//     genderController.text = widget.gender;
//   }
//
//   showAlertBox() {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           title: const Text("Pick Image From"),
//           content: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               ListTile(
//                 onTap: () {
//                   pickImage(ImageSource.camera);
//                   Navigator.pop(context);
//                 },
//                 leading: const Icon(Icons.camera_alt),
//                 title: const Text("Camera"),
//               ),
//               ListTile(
//                 onTap: () {
//                   pickImage(ImageSource.gallery);
//                   Navigator.pop(context);
//                 },
//                 leading: const Icon(Icons.image),
//                 title: const Text("Gallery"),
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () => FocusScope.of(context).unfocus(),
//       child: Scaffold(
//         appBar: AppBar(
//           title: const Text('Update Screens'),
//           centerTitle: true,
//           backgroundColor: Colors.blue,
//         ),
//         body: ListView(
//           children: [
//             Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 InkWell(
//                   onTap: () {
//                     showAlertBox();
//                   },
//                   child: (pickedImage != null)
//                       ? CircleAvatar(
//                     radius: 80,
//                     backgroundImage: FileImage(pickedImage!),
//                   )
//                       : (widget.image.isNotEmpty)
//                       ? CircleAvatar(
//                     radius: 80,
//                     backgroundImage: NetworkImage(widget.image),
//                   )
//                       : const CircleAvatar(
//                     radius: 80,
//                     child: Icon(Icons.person, size: 80),
//                   ),
//                 ),
//                 SizedBox(height: 10),
//                 TextFormField(
//                   controller: usernameController,
//                   decoration: InputDecoration(
//                     prefixIcon: Icon(Icons.person),
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(10),
//                     ),
//                     hintText: 'Enter Your UserName',
//                   ),
//                   validator: (value) {
//                     if (value == null || value.isEmpty) {
//                       return 'Enter Your UserName';
//                     }
//                     return null;
//                   },
//                   keyboardType: TextInputType.text,
//                 ),
//                 SizedBox(height: 10),
//                 TextFormField(
//                   controller: addressController,
//                   decoration: InputDecoration(
//                     prefixIcon: Icon(Icons.location_on),
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(10),
//                     ),
//                     hintText: 'Enter Your Address',
//                   ),
//                   validator: (value) {
//                     if (value == null || value.isEmpty) {
//                       return 'Enter Your Address';
//                     }
//                     return null;
//                   },
//                   keyboardType: TextInputType.text,
//                 ),
//                 SizedBox(height: 10),
//                 TextFormField(
//                   controller: ageController,
//                   decoration: InputDecoration(
//                     prefixIcon: Icon(Icons.calendar_today),
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(10),
//                     ),
//                     hintText: 'Enter Your Age',
//                   ),
//                   validator: (value) {
//                     if (value == null || value.isEmpty) {
//                       return 'Enter Your Age';
//                     }
//                     return null;
//                   },
//                   keyboardType: TextInputType.number,
//                 ),
//                 SizedBox(height: 10),
//                 TextFormField(
//                   controller: genderController,
//                   decoration: InputDecoration(
//                     prefixIcon: Icon(Icons.transgender),
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.circular(10),
//                     ),
//                     hintText: 'Enter Your Gender',
//                   ),
//                   validator: (value) {
//                     if (value == null || value.isEmpty) {
//                       return 'Enter Your Gender';
//                     }
//                     return null;
//                   },
//                   keyboardType: TextInputType.text,
//                 ),
//                 SizedBox(height: 20),
//                 ElevatedButton(
//                   onPressed: () {
//                     upload(
//                       usernameController.text,
//                       addressController.text,
//                       ageController.text,
//                       genderController.text,
//                     );
//                   },
//                   child: Text("Update"),
//                 )
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   pickImage(ImageSource imageSource) async {
//     final photo = await ImagePicker().pickImage(source: imageSource);
//     if (photo != null) {
//       final tempImage = File(photo.path);
//       setState(() {
//         pickedImage = tempImage;
//       });
//     }
//   }
//
//   upload(String username, String address, String age, String gender) async {
//     if (username.isEmpty || address.isEmpty || age.isEmpty || gender.isEmpty) {
//       showDialog(
//         context: context,
//         builder: (BuildContext context) {
//           return AlertDialog(
//             title: const Text("Enter Required Fields"),
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
//       uploadData(username, address, age, gender);
//     }
//   }
//
//   uploadData(String username, String address, String age, String gender) async {
//     if (pickedImage != null) {
//       // Upload new image to Firebase Storage
//       UploadTask uploadTask = FirebaseStorage.instance
//           .ref('profile_pics')
//           .child(widget.id)
//           .putFile(pickedImage!);
//       TaskSnapshot taskSnapshot = await uploadTask;
//       String url = await taskSnapshot.ref.getDownloadURL();
//
//       // Update Firestore document with new data including image URL
//       await FirebaseFirestore.instance.collection("Seller_Profile").doc(widget.id).update({
//         "Username": username,
//         "Address": address,
//         "Age": age,
//         "Gender": gender,
//         "Image": url,
//       });
//     } else {
//       // Update Firestore document without image URL
//       await FirebaseFirestore.instance.collection("Seller_Profile").doc(widget.id).update({
//         "Username": username,
//         "Address": address,
//         "Age": age,
//         "Gender": gender,
//       });
//     }
//
//     // Show success message and navigate to ShowUserData screen
//     ScaffoldMessenger.of(context).showSnackBar(
//       const SnackBar(content: Text('User data uploaded successfully')),
//     );
//     Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ProfileScreen()));
//   }
// }
