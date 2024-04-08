import 'package:flutter/cupertino.dart';

class BusinessModel{
  String title;
  IconData icon;
 String amount;
  void Function()? onTap;
  BusinessModel({required this.title,required this.icon,required this.onTap,required this.amount});
}



