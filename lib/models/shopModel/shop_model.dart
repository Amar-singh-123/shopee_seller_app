// To parse this JSON data, do
//
//     final sellerDetailsModels = sellerDetailsModelsFromJson(jsonString);

import 'dart:convert';

SellerDetailsModels sellerDetailsModelsFromJson(String str) => SellerDetailsModels.fromJson(json.decode(str));

String sellerDetailsModelsToJson(SellerDetailsModels data) => json.encode(data.toJson());

class SellerDetailsModels {
  String? sId;
  String? storeName;
  String? businessName;
  String? sellerPhone;
  String? sellerEmail;
  String? businessCategory;
  String? imageUrl;

  SellerDetailsModels({
    this.sId,
    this.storeName,
    this.businessName,
    this.sellerPhone,
    this.sellerEmail,
    this.businessCategory,
    this.imageUrl,
  });

  factory SellerDetailsModels.fromJson(Map<String, dynamic> json) => SellerDetailsModels(
    sId: json["sId"],
    storeName: json["storeName"],
    businessName: json["businessName"],
    sellerPhone: json["sellerPhone"],
    sellerEmail: json["sellerEmail"],
    businessCategory: json["businessCategory"],
    imageUrl: json["imageUrl"],
  );

  Map<String, dynamic> toJson() => {
    "sId": sId,
    "storeName": storeName,
    "businessName": businessName,
    "sellerPhone": sellerPhone,
    "sellerEmail": sellerEmail,
    "businessCategory": businessCategory,
    "imageUrl": imageUrl,
  };
}
