import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shopee_seller_app/views/utils/app_extensions/app_extensions.dart';

class BannerLibraryScreen extends StatelessWidget {
  const BannerLibraryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Store Banner Library",style: TextStyle(fontSize: 20),),
        elevation: 5,
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection("BannersLibrary").snapshots(),
        builder: (context, snapshot) {
          if(snapshot.hasError){
            return const Center(child: Text("Something went wrong"));
          }
          if(snapshot.connectionState == ConnectionState.waiting){
            return const Center(child: CupertinoActivityIndicator(),);
          }
          return ListView.builder(
            itemCount: snapshot.data?.docs.length,
            itemBuilder: (context, index) {
              var data = snapshot.data?.docs[index];
              return Card(
                elevation: 20,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: Stack(
                    children: [
                      CachedNetworkImage(imageUrl: data?["bannerImage"],fit: BoxFit.cover,height: context.screenHeight / 4,width: context.screenWidth / 1,),
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
