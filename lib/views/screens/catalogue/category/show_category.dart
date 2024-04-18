import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shopee_seller_app/controllers/services/app_firebase/app_firebase_auth.dart';
import 'package:shopee_seller_app/views/screens/catalogue/category/update_screen.dart';
import '../../../../models/category/category_model.dart';
import 'add_category.dart';

class ShowCategory extends StatefulWidget {
  const ShowCategory({super.key});

  @override
  State<ShowCategory> createState() => _ShowCategoryState();
}

bool _switchValue = true;

class _ShowCategoryState extends State<ShowCategory> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: FirebaseFirestore.instance
            .collection('shoppe_category').where('sellerId', isEqualTo: AppAuth.userId)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else {
            return ListView.builder(
              physics: const BouncingScrollPhysics(),
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                DocumentSnapshot category = snapshot.data!.docs[index];
                return Card(
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
                              imageUrl: category['categoryImg'],
                              placeholder: (context, url) =>
                                  const CupertinoActivityIndicator(),
                              errorWidget: (context, url, error) =>
                                  const Icon(Icons.error),
                            ),
                          ),
                          title: Text(category['categoryName'],
                              style: TextStyle(color: Colors.grey)),
                          subtitle: const Text("Sub Categories (0)",
                              style: TextStyle(color: Colors.grey)),
                          trailing: PopupMenuButton<String>(
                            onSelected: (String value) {
                              if (value == 'edit') {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => UpdateCategoryScreen(
                                        categoryModel:
                                            categoryModelFromSnapshot(
                                                category)),
                                  ),
                                );
                              } else if (value == 'delete') {
                                category.reference.delete();
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
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            // Row(
                            //   children: [
                            //     const Padding(
                            //       padding: EdgeInsets.all(15.0),
                            //       child: Text("Online"),
                            //     ),
                            //     FlutterSwitch(
                            //       height: 20.0,
                            //       width: 40.0,
                            //       padding: 4.0,
                            //       toggleSize: 15.0,
                            //       borderRadius: 10.0,
                            //       activeColor: Colors.indigoAccent,
                            //       value: _switchValue,
                            //       onToggle: (value) {
                            //         setState(() {
                            //           _switchValue = value;
                            //         });
                            //       },
                            //     ),
                            //   ],
                            // ),

                                Row(
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        String deepLink =
                                            'https://shoppy.page.link/shoppy';
                                        String message =
                                            '${category['categoryName']}\n$deepLink';
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
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.indigo,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AddCategoriesScreen(),
            ),
          );
        },
        label: const Text(
          'CATEGORY',
          style: TextStyle(letterSpacing: 1, fontSize: 14, color: Colors.white),
        ),
        icon: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }

  CategoryModel categoryModelFromSnapshot(DocumentSnapshot snapshot) {
    Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
    return CategoryModel(
      categoryId: data['categoryId'],
      categoryImg: data['categoryImg'],
      categoryName: data['categoryName'],
      createdAt: data['createdAt'],
      updatedAt: data['updatedAt'],
    );
  }
}
