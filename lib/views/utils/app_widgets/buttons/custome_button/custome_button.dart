import 'package:flutter/material.dart';
import 'package:shopee_seller_app/views/utils/app_colors/app_colors.dart';
import 'package:shopee_seller_app/views/utils/app_extensions/app_extensions.dart';

class CustomButtonWidget extends StatelessWidget {
   CustomButtonWidget({super.key,required this.text,required this.onTap});
  String text;
   void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: context.screenWidth,
        height: context.screenWidth / 7,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: Colors.blueAccent
        ),
        child: Center(child: Text(text,style: TextStyle(color: AppColor.white,fontWeight: FontWeight.bold),),),
      ),
    );
  }
}
