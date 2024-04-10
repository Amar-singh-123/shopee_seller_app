import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shopee_seller_app/controllers/services/app_firebase/app_firebase_auth.dart';
import 'package:shopee_seller_app/models/orders/order_model.dart';
import 'package:shopee_seller_app/models/user/user_model.dart';
import 'package:shopee_seller_app/views/utils/app_extensions/app_extensions.dart';

class NewScreen extends StatelessWidget {
  const NewScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('orders')
          .where('sellerId', isEqualTo: AppAuth.userId)
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }
        if (snapshot.data == null || snapshot.data!.docs.isEmpty) {
          return const Center(
            child: Text(
              'No orders in the section.',
              style: TextStyle(fontSize: 13, color: Colors.black45),
            ),
          );
        }
        final List<OrderModel> orders = snapshot.data!.docs
            .map((DocumentSnapshot document) =>
            OrderModel.fromJson(document.data() as Map<String, dynamic>))
            .toList();

        return ListView.builder(
          itemCount: orders.length,
          itemBuilder: (BuildContext context, int index) {
            OrderModel order = orders[index];
            return orderDetailsItem(order, context);
          },
        );
      },
    );
  }



  Widget orderDetailsItem(OrderModel orderModel, BuildContext context) {
    return StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
        stream: FirebaseFirestore.instance.collection('UserProfile').doc(orderModel.addressId).snapshots(),
        builder: (context, userSnapShot) {

          return StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
              stream: FirebaseFirestore.instance.collection('products').doc(orderModel.productId ?? "").snapshots(),
              builder: (context, productSnapShot) {
                return Container(
                  child:Column(
                    children: [
                      Card(child: Text(orderModel.toJson().toString()),),
                      10.height,
                      Card(child: Text(orderModel.toJson().toString()),),
                    ],
                  ),
                );
              },);
        },);
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black45, width: 0.7),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Text(
                    "# ${orderModel.orderId}",
                    style: const TextStyle(
                        fontSize: 12, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              Text(
                "${orderModel.orderDate
                    ?.toDate()
                    .formateDate}",
                style: const TextStyle(
                  color: Colors.black54,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          const Padding(
            padding: EdgeInsets.only(top: 10),
            child: Divider(
              color: Colors.black45,
              height: 0.7,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                stream: FirebaseFirestore.instance.collection('UserProfile').doc(orderModel.addressId).snapshots(),
                builder: (context, snapshot) {
                  if(snapshot.data == null || snapshot.connectionState == ConnectionState.waiting){
                    return Text("");
                  }
                var user =  UserModel.fromJson((snapshot.data!.data()!));
                  return Text(
                    "${user.userContact}",
                    style: const TextStyle(
                        fontWeight: FontWeight.bold, fontSize: 15),
                  );
                }
              ),
              Row(
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.call, size: 19),
                  ),
                  Text(
                    "${orderModel.orderId}",
                    style: const TextStyle(
                      color: Colors.black54,
                      fontSize: 10,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              )
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: MediaQuery
                        .of(context)
                        .size
                        .width * 0.22,
                    height: MediaQuery
                        .of(context)
                        .size
                        .width * 0.22,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(width: 0.3, color: Colors.black12),
                    ),
                    child: const ClipOval(
                      child: Center(
                        child: Icon(
                          CupertinoIcons.photo,
                          size: 20,
                          color: Colors.black45,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "productName X ${orderModel.totalQuantity}.0",
                      style: const TextStyle(
                        color: Colors.black54,
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.arrow_forward_ios,
                  size: 20,
                  color: Color(0xff2041a9),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Row(
                  children: [
                    TextButton(
                      onPressed: () {},
                      child: Text('cod'),
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                          Colors.blue,
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    TextButton(
                      onPressed: () {},
                      child: Text('due'),
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                          Colors.pinkAccent,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                "₹${orderModel.totalPrice}",
                style: const TextStyle(
                    fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          const Padding(
            padding: EdgeInsets.only(top: 10, bottom: 10),
            child: Divider(
              color: Colors.black45,
              height: 0.7,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Order pending",
                style: const TextStyle(
                  color: Colors.black54,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Row(
                children: [
                  const Icon(
                    Icons.two_wheeler,
                    size: 15,
                    color: Color(0xff2041a9),
                  ),
                  const Text(
                    "Dispatch",
                    style: TextStyle(
                      color: Color(0xff2041a9),
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:shopee_seller_app/controllers/services/app_firebase/app_firebase_auth.dart';
// import 'package:shopee_seller_app/models/orders/order_model.dart';
// import 'package:shopee_seller_app/views/utils/app_constants/image_constants.dart';
// import 'package:shopee_seller_app/views/utils/app_extensions/app_extensions.dart';
//
// class NewScreen extends StatelessWidget {
//   const NewScreen({Key? key});
//
//   @override
//   Widget build(BuildContext context) {
//     return StreamBuilder<QuerySnapshot>(
//       stream: FirebaseFirestore.instance.collection('orders').where('sellerId',isEqualTo: AppAuth.userId).snapshots(),
//       builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
//         if (snapshot.connectionState == ConnectionState.waiting) {
//           return Center(
//             child: CircularProgressIndicator(),
//           );
//         }
//         if (snapshot.hasError) {
//           return Text('Error: ${snapshot.error}');
//         }
//         if (snapshot.data == null || snapshot.data!.docs.isEmpty) {
//           return Center(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                // Container(constraints: BoxConstraints(maxHeight: 200, maxWidth: 200),child: Image.asset('assets/images/cards.png', width: context.screenWidth*0.48)),
//                 const Text(
//                   'No orders in the section.',
//                   style: TextStyle(fontSize: 13, color: Colors.black45),
//                 ),
//               ],
//             ),
//           );
//         }
//         final List<OrderModel> orders = snapshot.data!.docs.map((DocumentSnapshot document) {
//           Map<String, dynamic> data = document.data() as Map<String, dynamic>;
//           return OrderModel.fromJson(data);
//         }).toList();
//
//         return ListView.builder(
//           itemCount: orders.length,
//           itemBuilder: (BuildContext context, int index) {
//             final OrderModel order = orders[index];
//             return orderDetailsItem(order, context);
//           },
//         );
//       },
//     );
//   }
//
//   Widget orderDetailsItem(OrderModel orderModel, BuildContext context) {
//     return Container(
//       margin: EdgeInsets.all(16),
//       padding: EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         border: Border.all(color: Colors.black45, width: 0.7),
//         borderRadius: BorderRadius.all(Radius.circular(10)),
//       ),
//       child: Column(
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Row(
//                 children: [
//                   Text(
//                     "# ORD-0007",
//                     style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
//                   ),
//                   Icon(
//                     CupertinoIcons.link,
//                     size: 15,
//                     color: Color(0xff2041a9),
//                   ),
//                   Text(
//                     " INV-0007",
//                     style: TextStyle(
//                       color: Color(0xff2041a9),
//                       fontSize: 14,
//                       fontWeight: FontWeight.w500,
//                     ),
//                   ),
//                 ],
//               ),
//               Text(
//                 "${orderModel.deliveryDate} | ${orderModel.deliveryTime}",
//                 style: TextStyle(
//                   color: Colors.black54,
//                   fontSize: 12,
//                   fontWeight: FontWeight.w500,
//                 ),
//               ),
//             ],
//           ),
//           Padding(
//             padding: const EdgeInsets.only(top: 10),
//             child: Divider(
//               color: Colors.black45,
//               height: 0.7,
//             ),
//           ),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
//                 stream: FirebaseFirestore.instance.collection('UserSignUpDetails').doc(orderModel.addressId ?? "").snapshots(),
//                 builder: (context, snapshot) {
//                   return Text(
//                     "${orderModel.orderId}",
//                     style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
//                   );
//                 }
//               ),
//               Row(
//                 children: [
//                   IconButton(
//                     onPressed: () {},
//                     icon: Icon(Icons.call, size: 19),
//                   ),
//                   IconButton(
//                     onPressed: () {},
//                     icon: Image.network(
//                       whatsapp,
//                       width: 19,
//                     ),
//
//                   ),
//                   Text(
//                     "${orderModel}",
//                     style: TextStyle(
//                       color: Colors.black54,
//                       fontSize: 10,
//                       fontWeight: FontWeight.w500,
//                     ),
//                   ),
//                 ],
//               )
//             ],
//           ),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Row(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Container(
//                     width: MediaQuery.of(context).size.width * 0.22,
//                     height: MediaQuery.of(context).size.width * 0.22,
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(10),
//                       border: Border.all(width: 0.3, color: Colors.black12),
//                     ),
//                     child: ClipOval(
//                       child: orderModel.productImages == null
//                           ? Center(
//                         child: const Icon(
//                           CupertinoIcons.photo,
//                           size: 20,
//                           color: Colors.black45,
//                         ),
//                       )
//                           : Image.network(
//                         orderModel.productImages.toString(),
//                         fit: BoxFit.cover,
//                         width: MediaQuery.of(context).size.width * 0.12,
//                         height: MediaQuery.of(context).size.width * 0.12,
//                       ),
//                     ),
//                   ),
//                   Padding(
//                     padding: const EdgeInsets.all(8.0),
//                     child: Text(
//                       "${orderModel.productName} X ${orderModel.productQuantity}.0",
//                       style: TextStyle(
//                         color: Colors.black54,
//                         fontSize: 15,
//                         fontWeight: FontWeight.w500,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//               IconButton(
//                 onPressed: () {},
//                 icon: Icon(
//                   Icons.arrow_forward_ios,
//                   size: 20,
//                   color: Color(0xff2041a9),
//                 ),
//               ),
//             ],
//           ),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Padding(
//                 padding: const EdgeInsets.only(top: 10),
//                 child: Row(
//                   children: [
//                     TextButton(
//                       onPressed: () {},
//                       child: Text('cod'),
//                       style: ButtonStyle(
//                         backgroundColor: MaterialStateProperty.all<Color>(
//                           Colors.blue,
//                         ), // Set background color
//                       ),
//                     ),
//                     SizedBox(width: 10),
//                     TextButton(
//                       onPressed: () {},
//                       child: Text('due'),
//                       style: ButtonStyle(
//                         backgroundColor: MaterialStateProperty.all<Color>(
//                           Colors.pinkAccent,
//                         ), // Set background color
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               Text(
//                 "₹${orderModel.productTotalPrice}",
//                 style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//               ),
//             ],
//           ),
//           Padding(
//             padding: const EdgeInsets.only(top: 10, bottom: 10),
//             child: Divider(
//               color: Colors.black45,
//               height: 0.7,
//             ),
//           ),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text(
//                 "Order pending",
//                 style: TextStyle(
//                   color: Colors.black54,
//                   fontSize: 12,
//                   fontWeight: FontWeight.w500,
//                 ),
//               ),
//               Row(
//                 children: [
//                   Icon(
//                     Icons.two_wheeler,
//                     size: 15,
//                     color: Color(0xff2041a9),
//                   ),
//                   Text(
//                     "  Dispatch",
//                     style: TextStyle(
//                       color: Color(0xff2041a9),
//                       fontSize: 14,
//                       fontWeight: FontWeight.w500,
//                     ),
//                   ),
//                 ],
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }

