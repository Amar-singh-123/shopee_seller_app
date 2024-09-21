import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopee_seller_app/controllers/services/app_firebase/app_firebase_auth.dart';
import 'package:shopee_seller_app/models/orders/order_model.dart';
import 'package:shopee_seller_app/models/user/user_model.dart';
import 'package:shopee_seller_app/views/utils/app_colors/app_colors.dart';
import 'package:shopee_seller_app/views/utils/app_extensions/app_extensions.dart';

import 'caustomer_form.dart';

class CustomerHome extends StatefulWidget {
  const CustomerHome({super.key});

  @override
  State<CustomerHome> createState() => _CustomerHomeState();
}

bool _switchValue = true;

class _CustomerHomeState extends State<CustomerHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Customers"),
        // leading: IconButton(
        //   icon: Icon(Icons.arrow_back),
        //   onPressed: () {
        //
        //   },
        // ),

        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              // Add search icon functionality here
            },
          ),
          IconButton(
            icon: Icon(Icons.menu),
            onPressed: () {
              // Add menu icon functionality here
            },
          ),
          IconButton(
            icon: Icon(Icons.more_vert),
            onPressed: () {
              // Add right arrow icon functionality here
            },
          ),
        ],
        // bottom: PreferredSize(
        //   preferredSize: Size(context.screenWidth, 50),
        //   child: Column(
        //     children: [
        //       Row(
        //         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        //         children: [
        //           ElevatedButton(onPressed: () {}, child: Text("Due")),
        //           ElevatedButton(onPressed: () {}, child: Text("Advance")),
        //           Text("Address Book"),
        //           Switch(
        //             value: _switchValue,
        //             onChanged: (bool value) {
        //               setState(() {
        //                 _switchValue = value;
        //               });
        //             },
        //           )
        //         ],
        //       )
        //     ],
        //   ),
        // ),
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                stream: FirebaseFirestore.instance
                    .collection('orders')
                    .where('sellerId', isEqualTo: AppAuth.userId)
                    .snapshots(),
                builder: (context, orderSnapShot) {
                  if (orderSnapShot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CupertinoActivityIndicator(),);
                  }
                  if (orderSnapShot.data == null || orderSnapShot.data?.docs.isEmpty == true) {
                    return const Center(child: Text('No Customer Available'));
                  }
                  var orderList = <OrderModel>[];
                  orderSnapShot.data!.docs.forEach((e) {
                  var order = OrderModel.fromJson(e.data());
                  var res =  orderList.where((element) => element.customerId == order.customerId).toList();
                   if(res.isEmpty){
                     orderList.add(order);
                   }
                  });

                  return ListView.builder(
                    itemCount: orderList.length, // Example item count
                    itemBuilder: (context, index) {
                      var order = orderList[index];
                      return StreamBuilder<
                              DocumentSnapshot<Map<String, dynamic>>>(
                          stream: FirebaseFirestore.instance
                              .collection('UserProfile')
                              .doc(order.customerId)
                              .snapshots(),
                          builder: (context, userSnapShot) {
                            if (userSnapShot.connectionState ==
                                ConnectionState.waiting) {
                              return const Center(
                                child: CupertinoActivityIndicator(),
                              );
                            }
                            if (userSnapShot.data == null ||
                                userSnapShot.data?.data() == null) {
                              return const Center(
                                  child: Text('No Customer Available'));
                            }
                            var user =
                                UserModel.fromJson(userSnapShot.data!.data()!);
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ListTile(
                                shape: 5.shapeBorderRadius,
                                tileColor: AppColor.lightBlue,
                                leading: CircleAvatar(
                                  radius: 30,
                                  child: Center(
                                      child: Text(
                                          "${user.userName?[0].capitalize}")),
                                ),
                                title: Text('${user.userName}'),
                                subtitle: Text("${user.userContact}"),
                                trailing:
                                    const Icon(Icons.account_circle_rounded),
                              ),
                            );
                          });
                    },
                  );
                }),
          ),
        ],
      ),
      // floatingActionButton: FloatingActionButton.extended(
      //   onPressed: () {
      //     // Add functionality for the floating action button here
      //     Navigator.push(
      //         context,
      //         MaterialPageRoute(
      //           builder: (context) => Customer_form(),
      //         ));
      //   },
      //   backgroundColor: Colors.blue,
      //   icon: Icon(
      //     Icons.person_add,
      //     color: Colors.white,
      //   ),
      //   label: Text("Caustomer", style: TextStyle(color: Colors.white)),
      // ),
    );
  }
}
