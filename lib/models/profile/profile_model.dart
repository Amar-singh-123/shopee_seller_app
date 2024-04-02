// To parse this JSON data, do
//
//     final profileModel = profileModelFromJson(jsonString);

import 'dart:convert';

ProfileModel profileModelFromJson(String str) => ProfileModel.fromJson(json.decode(str));

String profileModelToJson(ProfileModel data) => json.encode(data.toJson());

class ProfileModel {
  String? sellerId;
  String? sellerName;
  String? sellerEmail;
  String? sellerPhone;
  String? sellerAddress;
  String? sellerImage;
  ProfileModel({
    this.sellerId,
    this.sellerName,
    this.sellerEmail,
    this.sellerPhone,
    this.sellerAddress,
    this.sellerImage,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) => ProfileModel(
    sellerId: json["seller_id"],
    sellerName: json["seller_name"],
    sellerEmail: json["seller_email"],
    sellerPhone: json["seller_phone"],
    sellerAddress: json["seller_address"],
    sellerImage: json["seller_image"],
  );
  Map<String, dynamic> toJson() => {
    "seller_id": sellerId,
    "seller_name": sellerName,
    "seller_email": sellerEmail,
    "seller_phone": sellerPhone,
    "seller_address": sellerAddress,
    "seller_image": sellerImage,
  };
}
