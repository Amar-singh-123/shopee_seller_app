import 'package:flutter/material.dart';
import 'package:shopee_seller_app/views/screens/shopee_ui/store_banner/banner_scren.dart';
import 'package:shopee_seller_app/views/utils/app_extensions/app_extensions.dart';
import 'package:shopee_seller_app/views/utils/app_constants/text_constants.dart';


class StoreBannerScreen extends StatelessWidget {
  const StoreBannerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        floatingActionButton: FloatingActionButton(onPressed: (){
          context.push(BannerScreen());
        },child: Icon(Icons.add),),
        appBar: AppBar(title: Text(storeBanner),),
        body: ListView(),

      ),
    );
  }
}
