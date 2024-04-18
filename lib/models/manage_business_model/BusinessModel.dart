import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class BusinessModel{
  String title;
  IconData icon;
 String amount;
 Stream<QuerySnapshot<Map<String,dynamic>>>? stream;
  void Function()? onTap;
  BusinessModel({required this.title,required this.icon,required this.onTap,required this.amount,this.stream});
}



