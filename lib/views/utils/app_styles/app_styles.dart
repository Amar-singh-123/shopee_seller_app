import 'package:flutter/material.dart';
import 'package:shopee_seller_app/views/utils/app_colors/app_colors.dart';

class AppStyle {
  static ButtonStyle buttonStyle = ElevatedButton.styleFrom(
    backgroundColor: AppColor.soft,
  );

}
 TextStyle defaultTextStyle = TextStyle(color: AppColor.white);
 TextStyle appBarTextStyle = TextStyle(
     color: Colors.black, fontWeight: FontWeight.w500, fontSize: 19);
ButtonStyle elevatedButtonStyle = ElevatedButton.styleFrom(
    backgroundColor: AppColor.deepPurple,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)));