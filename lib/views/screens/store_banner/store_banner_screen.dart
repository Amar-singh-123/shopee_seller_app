import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shopee_seller_app/views/utils/app_extensions/app_extensions.dart';
import 'package:shopee_seller_app/views/utils/app_constants/text_constants.dart';
import 'package:shopee_seller_app/views/utils/app_widgets/buttons/custome_button/pop_up_menu_button_widget.dart';

import 'banner_scren.dart';

class StoreBannerScreen extends StatefulWidget {
  const StoreBannerScreen({super.key});

  @override
  State<StoreBannerScreen> createState() => _StoreBannerScreenState();
}

class _StoreBannerScreenState extends State<StoreBannerScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.push(const BannerScreen());
        },
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
        title: const Text(storeBanner),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection("Banners").snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(child: Text("Something went wrong"));
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CupertinoActivityIndicator(),
            );
          }
          if (snapshot.hasData && snapshot.data!.docs.isEmpty) {
            return const Center(child: Text("Please Create Your Banner"));
          }
          return ListView.builder(
            itemCount: snapshot.data?.docs.length,
            itemBuilder: (context, index) {
              var data = snapshot.data?.docs[index];
              return Card(
                color: Colors.white,
                child: Column(
                  children: [
                    Stack(
                      children: [
                        CachedNetworkImage(
                          imageUrl: data?["bannerImage"],
                          fit: BoxFit.cover,
                          height: context.screenHeight / 4,
                          width: context.screenWidth / 1,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: context.screenHeight / 10,
                              height: context.screenHeight / 30,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  color: Colors.grey
                              ),
                              child: Center(child: Text(data?["uploadType"],style: TextStyle(color: Colors.white),)),
                            ),
                            PopUpMenuButtonWidget(
                              id: data?["bannerId"], data: data,
                            ),
                          ],
                        )
                        
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10, bottom: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Row(
                            children: [
                              Text(data?["isEnable"] ?? ""),
                              SizedBox(
                                width: context.screenWidth / 40,
                              ),
                              CupertinoSwitch(
                                value: data?['isEnable'] == "Enable"? true : false,
                                onChanged: (value) {
                                  setState(() {
                                    FirebaseFirestore.instance
                                        .collection("Banners")
                                        .doc(data?["bannerId"])
                                        .update({
                                      "isEnable": data?["isEnable"] == "Enable" ? "Disabled" : "Enable"
                                    });
                                  });
                                },
                              )
                            ],
                          ),
                          Row(
                            children: [
                              IconButton(
                                  onPressed: () async {
                                    Share.share(
                                        'Hello Welcome to FlutterCampus',
                                        subject: 'Welcome Message');
                                  },
                                  icon: const Icon(Icons.share)),
                              SizedBox(
                                width: context.screenWidth / 40,
                              ),
                              const Text("Share")
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
