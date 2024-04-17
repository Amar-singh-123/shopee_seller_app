// //<<<<<<< Updated upstream
// // import 'package:cloud_firestore/cloud_firestore.dart';
// // import 'package:firebase_auth/firebase_auth.dart';
// // import 'package:flutter/material.dart';
// // import 'package:get/get.dart';
// // import 'package:shopee_seller_app/views/screens/auth/email_auth/signing_with_email.dart';
// // import 'package:shopee_seller_app/views/screens/profile/profile_update_screen.dart';
// // import 'package:shopee_seller_app/views/utils/app_extensions/app_extensions.dart';
// //
// // class ProfileScreen extends StatefulWidget {
// //   const ProfileScreen({Key? key}) : super(key: key);
// //   @override
// //   State<ProfileScreen> createState() => _ProfileScreenState();
// // }
// // class _ProfileScreenState extends State<ProfileScreen> {
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(
// //         title: Text("Profile"),
// //         backgroundColor: Colors.blue,
// //       ),
// //       body: Container(
// //         color: Colors.white,
// //         padding: EdgeInsets.all(16.0),
// //         child: StreamBuilder<DocumentSnapshot>(
// //           stream: FirebaseFirestore.instance
// //               .collection("Seller_Profile")
// //               .doc(FirebaseAuth.instance.currentUser?.uid)
// //               .snapshots(),
// //           builder: (context, snapshot) {
// //             if (snapshot.connectionState == ConnectionState.waiting) {
// //               return Center(
// //                 child: CircularProgressIndicator(),
// //               );
// //             } else if (snapshot.hasError) {
// //               return Text(snapshot.error.toString());
// //             } else if (snapshot.hasData && snapshot.data!.exists) {
// //               var profileData = snapshot.data!.data() as Map<String, dynamic>;
// //
// //               return Column(
// //                 crossAxisAlignment: CrossAxisAlignment.start,
// //                 children: [
// //                   if (profileData["image"] != null)
// //                     CircleAvatar(
// //                       backgroundImage: NetworkImage(profileData["image"]),
// //                       radius: 50,
// //                     ),
// //                   20.height,
// //                   Text(
// //                     "${profileData["name"]}",
// //                     style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
// //                   ),
// //                   10.height,
// //                   Text(
// //                     "${profileData["Email"]}",
// //                     style: TextStyle(fontSize: 18),
// //                   ),
// //                  10.height,
// //                   Text(
// //                     "Address: ${profileData["Address"]}",
// //                     style: TextStyle(fontSize: 18),
// //                   ),
// //                   10.height,
// //                   Text(
// //                     "Age: ${profileData["age"]}",
// //                     style: TextStyle(fontSize: 18),
// //                   ),
// //                   30.height,
// //                   Text(
// //                     "Gender: ${profileData["gender"]}",
// //                     style: TextStyle(fontSize: 18),
// //                   ),
// //                   Row(
// //                     mainAxisAlignment: MainAxisAlignment.spaceAround,
// //                     children: [
// //                       ElevatedButton.icon(
// //                         onPressed: () {
// //                           Navigator.push(
// //                             context,
// //                             MaterialPageRoute(
// //                               builder: (context) =>
// //                                   UpdateScreens(
// //                                     id: profileData["Id"] ?? "",
// //                                     image: profileData["image"] ?? "",
// //                                     username: profileData["name"] ?? "",
// //                                     email: profileData["Email"] ?? "",
// //                                     address: profileData["Address"] ?? "",
// //                                     age: profileData["age"] ?? "",
// //                                     gender: profileData["gender"] ?? "",
// //                                   ),
// //                             ),
// //                           );
// //                         },
// //                         icon: Icon(Icons.edit),
// //                         label: Text('Edit'),
// //                       ),
// //                       ElevatedButton.icon(
// //                         onPressed: () {
// //                           FirebaseAuth.instance.signOut();
// //                           Get.offAll(SigningWithEmail());
// //                           //Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SigningWithEmail(),));
// //                         },
// //                         icon: Icon(Icons.logout),
// //                         label: Text('Logout'),
// //                       ),
// //                     ],
// //                   ),
// //                 ],
// //               );
// //             } else {
// //               return Center(
// //                 child: Text("No Data Found"),
// //               );
// //             }
// //           },
// //         ),
// //       ),
// //     );
// //   }
// // }
// =======
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:shopee_seller_app/views/screens/profile/profile_update_screen.dart';
// import 'package:shopee_seller_app/views/utils/app_extensions/app_extensions.dart';
//
// class ProfileScreen extends StatefulWidget {
//   const ProfileScreen({Key? key}) : super(key: key);
//   @override
//   State<ProfileScreen> createState() => _ProfileScreenState();
// }
// class _ProfileScreenState extends State<ProfileScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Profile"),
//         backgroundColor: Colors.blue,
//       ),
//       body: Container(
//         color: Colors.white,
//         padding: EdgeInsets.all(16.0),
//         child: StreamBuilder<DocumentSnapshot>(
//           stream: FirebaseFirestore.instance
//               .collection("Seller_Profile")
//               .doc(FirebaseAuth.instance.currentUser?.uid)
//               .snapshots(),
//           builder: (context, snapshot) {
//             if (snapshot.connectionState == ConnectionState.waiting) {
//               return Center(
//                 child: CircularProgressIndicator(),
//               );
//             } else if (snapshot.hasError) {
//               return Text(snapshot.error.toString());
//             } else if (snapshot.hasData && snapshot.data!.exists) {
//               var profileData = snapshot.data!.data() as Map<String, dynamic>;
//
//               return Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   if (profileData["image"] != null)
//                     CircleAvatar(
//                       backgroundImage: NetworkImage(profileData["image"]),
//                       radius: 50,
//                     ),
//                   20.height,
//                   Text(
//                     "${profileData["name"]}",
//                     style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//                   ),
//                   10.height,
//                   Text(
//                     "${profileData["Email"]}",
//                     style: TextStyle(fontSize: 18),
//                   ),
//                  10.height,
//                   Text(
//                     "Address: ${profileData["Address"]}",
//                     style: TextStyle(fontSize: 18),
//                   ),
//                   10.height,
//                   Text(
//                     "Age: ${profileData["age"]}",
//                     style: TextStyle(fontSize: 18),
//                   ),
//                   30.height,
//                   Text(
//                     "Gender: ${profileData["gender"]}",
//                     style: TextStyle(fontSize: 18),
//                   ),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceAround,
//                     children: [
//                       ElevatedButton.icon(
//                         onPressed: () {
//                           Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                               builder: (context) =>
//                                   UpdateScreens(
//                                     id: profileData["Id"] ?? "",
//                                     image: profileData["image"] ?? "",
//                                     username: profileData["name"] ?? "",
//                                     email: profileData["Email"] ?? "",
//                                     address: profileData["Address"] ?? "",
//                                     age: profileData["age"] ?? "",
//                                     gender: profileData["gender"] ?? "",
//                                   ),
//                             ),
//                           );
//                         },
//                         icon: Icon(Icons.edit),
//                         label: Text('Edit'),
//                       ),
//                       ElevatedButton.icon(
//                         onPressed: () {
//                           // Add logout functionality
//                         },
//                         icon: Icon(Icons.logout),
//                         label: Text('Logout'),
//                       ),
//                     ],
//                   ),
//                 ],
//               );
//             } else {
//               return Center(
//                 child: Text("No Data Found"),
//               );
//             }
//           },
//         ),
//       ),
//     );
//   }
// }
// // >>>>>>> Stashed changes
