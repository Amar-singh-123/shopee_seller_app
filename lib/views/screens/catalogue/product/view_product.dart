import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shopee_seller_app/controllers/services/app_firebase/firestore_db.dart';
import '../../../../models/products/Product_model.dart';
import 'add_product.dart';

class ViewProducts extends StatefulWidget {
  const ViewProducts({Key? key}) : super(key: key);

  @override
  State<ViewProducts> createState() => _ViewProductsState();
}

class _ViewProductsState extends State<ViewProducts> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddProductScreen()),
          );
          FloatingActionButtonLocation.startDocked;
        },
        child: const Icon(Icons.add),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('products').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          }
          var products = snapshot.data!.docs;
          return ListView.builder(
            itemCount: products.length,
            itemBuilder: (context, index) {
              final product = Product.fromJson(
                  products[index].data() as Map<String, dynamic>);
              var prod = snapshot.data?.docs[index];
              // return Card(
              //   child: Row(
              //     mainAxisAlignment: MainAxisAlignment.spaceAround,
              //     children: [
              //       Row(
              //         children: [
              //           ClipRRect(
              //             borderRadius: BorderRadius.circular(5),
              //             child: Container(
              //               child: CachedNetworkImage(
              //                 fit: BoxFit.cover,
              //                 height: 100,
              //                 width: 100,
              //                 imageUrl: product.imageUrl?.first ?? "",
              //                 placeholder: (context, url) =>
              //                     const CupertinoActivityIndicator(),
              //                 errorWidget: (context, url, error) =>
              //                     const Icon(Icons.error),
              //               ),
              //             ),
              //           ),
              //         ],
              //       ),
              //       Row(
              //         children: [
              //           Column(
              //             children: [
              //               Text(
              //                 product.name ?? "",
              //                 style: TextStyle(
              //                     fontSize: 20, fontWeight: FontWeight.bold),
              //               ),
              //               Text(
              //                 '${product.price.toString()}',
              //                 style: TextStyle(
              //                     fontSize: 15, fontWeight: FontWeight.w400),
              //               ),
              //               Text(
              //                 '${product.discount.toString()}',
              //                 style: TextStyle(
              //                     fontSize: 15, fontWeight: FontWeight.w400),
              //               ),
              //             ],
              //           ),
              //           SizedBox(
              //             width: 10,
              //           ),
              //           Column(
              //             children: [
              //               Text(
              //                 '${product.unit.toString()}',
              //                 style: TextStyle(
              //                     fontSize: 15, fontWeight: FontWeight.w400),
              //               ),
              //               Text(
              //                 '${product?.description ?? ""}',
              //                 overflow: TextOverflow.ellipsis,
              //                 maxLines: 1,
              //                 style: TextStyle(
              //
              //                     fontSize: 15, fontWeight: FontWeight.w400),
              //               ),
              //               Text(
              //                 ' ${product.qty.toString()}',
              //                 style: TextStyle(
              //                     fontSize: 15, fontWeight: FontWeight.w400),
              //               ),
              //             ],
              //           )
              //         ],
              //       ),
              //       Row(
              //         children: [
              //           IconButton(
              //               onPressed: () {
              //                 showDialog(
              //                   context: context,
              //                   builder: (BuildContext context) {
              //                     return AlertDialog(
              //                       title: const Text('Delete your Product?'),
              //                       content: const Text(
              //                           "If you select Delete we will delete your account on our server."),
              //                       actions: [
              //                         TextButton(
              //                           child: const Text('Cancel'),
              //                           onPressed: () {
              //                             Navigator.of(context).pop();
              //                           },
              //                         ),
              //                         TextButton(
              //                           onPressed: () {
              //                             prod?.reference.delete();
              //                             Navigator.of(context).pop();
              //                           },
              //                           child: const Text(
              //                             'Delete',
              //                           ),
              //                         ),
              //                       ],
              //                     );
              //                   },
              //                 );
              //               },
              //               icon: Icon(Icons.delete))
              //         ],
              //       )
              //     ],
              //   ),
              // );
              return  Card(
                elevation: 0,
                margin:
                const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
                surfaceTintColor: Colors.white,
                shape: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(
                      color: Colors.black12,
                      width: 1,
                      style: BorderStyle.solid),
                ),
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.only(left: 1, top: 8),
                  child: Column(
                    children: [
                      ListTile(
                        leading: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: CachedNetworkImage(
                            width: 65,
                            fit: BoxFit.cover,
                            imageUrl: product.imageUrl?.first ?? "",
                            placeholder: (context, url) =>
                            const CupertinoActivityIndicator(),
                            errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                          ),
                        ),
                        title: Text(product.name ?? "",
                            style: TextStyle(color: Colors.grey)),
                        subtitle: const Text("Sub Categories (0)",
                            style: TextStyle(color: Colors.grey)),
                        trailing: PopupMenuButton<String>(
                          onSelected: (String value) {
                            if (value == 'edit') {

                            } else if (value == 'delete') {
                              // category.reference.delete();
                            }
                          },
                          itemBuilder: (BuildContext context) =>
                          <PopupMenuEntry<String>>[
                            const PopupMenuItem<String>(
                              height: 10,
                              value: 'edit',
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Icon(Icons.edit),
                                      Text("Edit"),
                                    ],
                                  ),
                                  Divider(
                                    height: 13,
                                    thickness: BorderSide.strokeAlignOutside,
                                    color: Colors.black12,
                                    endIndent: BorderSide.strokeAlignCenter,
                                  ),
                                ],
                              ),
                            ),
                            const PopupMenuItem<String>(
                              height: 10,
                              value: 'delete',
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Icon(Icons.delete_forever_sharp),
                                      Text("Delete"),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                               Padding(
                                padding: EdgeInsets.all(15.0),
                                child: Text(product.status?.available == true ? 'available' : 'Unavailable'),
                              ),
                              FlutterSwitch(
                                height: 20.0,
                                width: 40.0,
                                padding: 4.0,
                                toggleSize: 15.0,
                                borderRadius: 10.0,
                                activeColor: Colors.indigoAccent,
                                value:  product.status?.available ?? false,
                                onToggle: (value) async{
                                  product.status?.available = value;


                                await  AppFireStoreDatabase(collection: 'products').update(data: {"status":product.status?.toJson()}, doc: product.productId ?? "");
                                },
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Row(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      String deepLink =
                                          'https://shoppy.page.link/shoppy';
                                      String message =
                                          '${product.name}\n$deepLink';
                                      Share.share(message);
                                    },
                                    child: Padding(
                                      padding:
                                      const EdgeInsets.only(right: 8),
                                      child: Container(
                                        decoration: ShapeDecoration(
                                          shape: OutlineInputBorder(
                                            borderSide: const BorderSide(
                                                color: Colors.indigo),
                                            borderRadius:
                                            BorderRadius.circular(7),
                                          ),
                                        ),
                                        height: 37,
                                        width: 77,
                                        child: const Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Icon(Icons.share,
                                                size: 14,
                                                color: Colors.indigo),
                                            Text(
                                              "Share",
                                              style: TextStyle(
                                                  color: Colors.indigo),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
