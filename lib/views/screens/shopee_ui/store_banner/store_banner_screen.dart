import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:shopee_seller_app/controllers/banner_controller.dart';
import 'package:shopee_seller_app/views/screens/shopee_ui/store_banner/banner_scren.dart';
import 'package:shopee_seller_app/views/utils/app_extensions/app_extensions.dart';
import 'package:shopee_seller_app/views/utils/app_constants/text_constants.dart';
import 'package:shopee_seller_app/views/utils/app_widgets/buttons/custome_button/pop_up_menu_button_widget.dart';

class StoreBannerScreen extends StatefulWidget {
  const StoreBannerScreen({super.key});

  @override
  State<StoreBannerScreen> createState() => _StoreBannerScreenState();
}

class _StoreBannerScreenState extends State<StoreBannerScreen> {
  bool _switchValue = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(onPressed: (){
        context.push(const BannerScreen());
      },child: const Icon(Icons.add),),
      appBar: AppBar(title: const Text(storeBanner),),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection("Banners").snapshots(),
          builder: (context, snapshot) {
            if(snapshot.hasError){
              return const Center(child: Text("Something went wrong"));
            }
            if(snapshot.connectionState == ConnectionState.waiting){
              return const Center(child: CupertinoActivityIndicator(),);
            }
            if(snapshot.hasData && snapshot.data!.docs.isEmpty){
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
                            CachedNetworkImage(imageUrl: data?["bannerImage"],fit: BoxFit.cover,height: context.screenHeight / 4,width: context.screenWidth / 1,),
                            PopUpMenuButtonWidget(id: data?["bannerId"],)
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 10,bottom: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Row(
                                children: [
                                  const Text("Enabled",),
                                  SizedBox(width: context.screenWidth / 40,),
                                  CupertinoSwitch(
                                    value: _switchValue,
                                    onChanged: (value) {
                                      setState(() {
                                        _switchValue = value;
                                        FirebaseFirestore.instance.collection("Banners").doc(data?["bannerId"]).update({"isEnable" : _switchValue});
                                      });
                                    },
                                  ),
                                ],
                              ),
                              Row(  
                                children: [
                                  IconButton(onPressed: ()async{
                                  //  await Share.share("jgfhgv");
                                  Share.share('Hello Welcome to FlutterCampus', subject: 'Welcome Message');

                                  }, icon: Icon(Icons.share)),
                                  SizedBox(width: context.screenWidth / 40,),
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
