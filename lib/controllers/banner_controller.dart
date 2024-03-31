import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shopee_seller_app/models/banner_model/banner_model.dart';
import 'package:shopee_seller_app/views/screens/shopee_ui/store_banner/store_banner_screen.dart';
import 'package:shopee_seller_app/views/utils/app_extensions/app_extensions.dart';

class BannerController {
  BuildContext context;
  BannerController({required this.context});

  final FirebaseFirestore _firebaseFireStore = FirebaseFirestore.instance;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;

  uploadBanner({File? image,String? link,String? uploadType})async{
    var imageName = DateTime.now().microsecondsSinceEpoch.toString();
    var storageRef = _firebaseStorage.ref().child("BannerImages/$imageName.jpg");
    var uploadTask = storageRef.putFile(image!);
    var downloadUrl = await (await uploadTask).ref.getDownloadURL();

    var data = BannerModel(bannerImage: downloadUrl.toString(),link: link,uploadType: uploadType);

    _firebaseFireStore.collection("Banners").add(data.toJson()).then((value) {
      var id = value.id;
      _firebaseFireStore.collection("Banners").doc(id).update({"bannerId": id}).then((value) {
        Fluttertoast.showToast(msg: "Data Insert Successfully");
        context.push(StoreBannerScreen());
      });
    });
  }

  // uploadLibraryBanner(File image)async{
  //   var imageName = DateTime.now().microsecondsSinceEpoch.toString();
  //   var storageRef = _firebaseStorage.ref().child("BannerImages/$imageName.jpg");
  //   var uploadTask = storageRef.putFile(image);
  //   var downloadUrl = await (await uploadTask).ref.getDownloadURL();
  //
  //   var data = BannerModel(bannerImage: downloadUrl.toString());
  //
  //   _firebaseFireStore.collection("BannersLibrary").add(data.toJson()).then((value) {
  //     var id = value.id;
  //     _firebaseFireStore.collection("BannersLibrary").doc(id).update({"bannerId": id}).then((value) {
  //       Fluttertoast.showToast(msg: "Data Insert Successfully");
  //       context.pushReplace(StoreBannerScreen());
  //     });
  //   });
  // }
  deleteBanner({required String id}){
    _firebaseFireStore.collection("Banners").doc(id).delete().then((value){
      Fluttertoast.showToast(msg: "Delete Successfully");
    });

  }
}
