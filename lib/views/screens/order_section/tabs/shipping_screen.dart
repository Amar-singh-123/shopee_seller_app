import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shopee_seller_app/views/utils/app_extensions/app_extensions.dart';

import '../../../../controllers/services/app_firebase/app_firebase_auth.dart';
import '../../../../models/orders/order_model.dart';
import '../../../../models/products/Product_model.dart';
import '../../../../models/user/user_model.dart';

class Shipping extends StatelessWidget {
  const Shipping({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
      stream: FirebaseFirestore.instance
          .collection('orders')
          .where('sellerId', isEqualTo: AppAuth.userId )
          .where('orderStatus.shipping', isEqualTo: true)
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
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
            .map((DocumentSnapshot<Map<String, dynamic>> document) =>
            OrderModel.fromJson(document.data()!))
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
      stream: FirebaseFirestore.instance
          .collection('UserProfile')
          .doc(orderModel.customerId)
          .snapshots(),
      builder: (context, AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>> userSnapShot) {
        if (userSnapShot.connectionState == ConnectionState.waiting) {
          return Center(child: CupertinoActivityIndicator());
        }
        if (!userSnapShot.hasData || userSnapShot.data == null || userSnapShot.data!.data() == null) {
          return Center(child: Text("No data exists"));
        }
        var user = UserModel.fromJson(userSnapShot.data!.data()!);
        return StreamBuilder<DocumentSnapshot<Map<String, dynamic>>>(
          stream: FirebaseFirestore.instance
              .collection('products')
              .doc(orderModel.productId ?? "")
              .snapshots(),
          builder: (context, AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>> productSnapShot) {
            if (productSnapShot.connectionState == ConnectionState.waiting) {
              return Center(child: CupertinoActivityIndicator());
            }
            if (!productSnapShot.hasData || productSnapShot.data == null || productSnapShot.data!.data() == null) {
              return Center(child: Text("No data exists"));
            }
            var product = Product.fromJson(productSnapShot.data!.data()!);

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
                      Text(
                        "# ${orderModel.orderId}",
                        style: const TextStyle(
                            fontSize: 12, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "${orderModel.orderDate?.toDate().formateDate} | ${orderModel.orderDate?.toDate().hour}-${orderModel.orderDate?.toDate().minute}-${orderModel.orderDate?.toDate().second}",
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
                          stream: FirebaseFirestore.instance
                              .collection('UserProfile')
                              .doc(orderModel.addressId)
                              .snapshots(),
                          builder: (context, AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>> snapshot) {
                            if (snapshot.connectionState == ConnectionState.waiting) {
                              return Text("");
                            }
                            if (!snapshot.hasData || snapshot.data == null || snapshot.data!.data() == null) {
                              return Text("");
                            }
                            var user = UserModel.fromJson(snapshot.data!.data()!);
                            return Text(
                              "${user.userName}",
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 15),
                            );
                          }),
                      Row(
                        children: [
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(Icons.call, size: 19),
                          ),
                          Text(
                            "${user.userContact}",
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
                            width: MediaQuery.of(context).size.width * 0.22,
                            height: MediaQuery.of(context).size.width * 0.22,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(width: 0.3, color: Colors.black12),
                            ),
                            child: SizedBox(
                              width: 50,
                              height: 50,
                              child: product.imageUrl != null ? Image.network(
                                product.imageUrl!.first,
                                fit: BoxFit.cover,
                              ) : Icon(
                                CupertinoIcons.photo,
                                size: 20,
                                color: Colors.black45,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              "${product.name} X ${orderModel.totalQuantity}.0",
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
                              child: Text('${orderModel.paymentMode?.cashOnDelivery ==  true?'cod':orderModel.paymentMode!.online == true?'online':'dj'}',style: TextStyle(color: Colors.white,fontSize: 15,fontWeight: FontWeight.w700 )),

                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all<Color>(
                                  Colors.blue,
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            TextButton(
                              onPressed: () {},
                              child:Text(orderModel.paymentMode?.cashOnDelivery ==  true?'due':'paid',style: TextStyle(color: Colors.white,fontSize: 15,fontWeight: FontWeight.w700 ),),
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all<Color>(
                                  Colors.pinkAccent,
                                ),
                              ),
                            )

                          ],
                        ),
                      ),
                      Text(
                        "₹${orderModel.totalPrice}",
                        style:
                        const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
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
                        "Order ${orderModel.orderStatus?.currentOrderStatus}",
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
          },
        );
      },
    );
  }
}
