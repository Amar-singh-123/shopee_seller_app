import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

Product productModelFromJson(String str) => Product.fromJson(json.decode(str));

String productModelToJson(Product data) => json.encode(data.toJson());

class Product {
  String? productId;
  String? name;
  String? price;
  List<String>? imageUrl;
  String? description;
  String? categoryId;
  String? subCategoryId;
  dynamic createdAt;
  dynamic updatedAt;
  String? discount;
  String? unit;
  int? qty;
  String? sellerId;
  double? ratting;
  String? title;
  List<dynamic>? colors;
  List<dynamic>? variants;
  String? shopId;
  String? brandId;
  int? totalSoldItem;
  Status? status;
  List<String>? paymentMethod;

  Product({
    this.productId,
    this.name,
    this.price,
    this.imageUrl,
    this.description,
    this.categoryId,
    this.subCategoryId,
    this.createdAt,
    this.updatedAt,
    this.discount,
    this.unit,
    this.qty,
    this.sellerId,
    this.ratting,
    this.title,
    this.colors,
    this.variants,
    this.shopId,
    this.brandId,
    this.totalSoldItem,
    this.status,
    this.paymentMethod,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    productId: json["productId"],
    name: json["name"],
    price: json["price"],
    imageUrl: json["imageUrl"] == null ? [] : List<String>.from(json["imageUrl"]!.map((x) => x)),
    description: json["description"],
    categoryId: json["categoryId"],
    subCategoryId: json["subCategoryId"],
    createdAt: json["createdAt"],
    updatedAt: json["updatedAt"],
    discount: json["discount"],
    unit: json["unit"],
    qty: json["qty"],
    sellerId: json["sellerId"],
    ratting: json["ratting"]?.toDouble(),
    title: json["title"],
    colors: json["colors"] == null ? [] : List<dynamic>.from(json["colors"]!.map((x) => x)),
    variants: json["variants"] == null ? [] : List<dynamic>.from(json["variants"]!.map((x) => x)),
    shopId: json["shopId"],
    brandId: json["brandId"],
    totalSoldItem: json["totalSoldItem"],
    status: json["status"] == null ? null : Status.fromJson(json["status"]),
    paymentMethod: json["paymentMethod"] == null ? [] : List<String>.from(json["paymentMethod"]!.map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "productId": productId,
    "name": name,
    "price": price,
    "imageUrl": imageUrl == null ? [] : List<dynamic>.from(imageUrl!.map((x) => x)),
    "description": description,
    "categoryId": categoryId,
    "subCategoryId": subCategoryId,
    "createdAt": createdAt,
    "updatedAt": updatedAt,
    "discount": discount,
    "unit": unit,
    "qty": qty,
    "sellerId": sellerId,
    "ratting": ratting,
    "title": title,
    "colors": colors == null ? [] : List<dynamic>.from(colors!.map((x) => x)),
    "variants": variants == null ? [] : List<dynamic>.from(variants!.map((x) => x)),
    "shopId": shopId,
    "brandId": brandId,
    "totalSoldItem": totalSoldItem,
    "status": status?.toJson(),
    "paymentMethod": paymentMethod == null ? [] : List<dynamic>.from(paymentMethod!.map((x) => x)),
  };
}



class Status {
  bool? available;
  bool? outOfStock;
  bool? blocked;

  Status({
    this.available = true,
    this.outOfStock = false,
    this.blocked = false,
  });

  factory Status.fromJson(Map<String, dynamic> json) => Status(
    available: json["available"],
    outOfStock: json["outOfStock"],
    blocked: json["blocked"],
  );

  Map<String, dynamic> toJson() => {
    "available": available,
    "outOfStock": outOfStock,
    "blocked": blocked,
  };
}
