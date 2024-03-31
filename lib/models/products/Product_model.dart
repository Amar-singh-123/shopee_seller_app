
import 'dart:convert';

Product welcomeFromJson(String str) => Product.fromJson(json.decode(str));

String welcomeToJson(Product data) => json.encode(data.toJson());

class Product {
  String id;
  String name;
  String category;
  String price;
  String discount;
  String unit;
  String productDetail;
  String piece;
  String imageUrl;
  Product({
    required this.id,
    required this.name,
    required this.category,
    required this.price,
    required this.discount,
    required this.unit,
    required this.productDetail,
    required this.piece,
    required this.imageUrl,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    id: json["id"],
    name: json["name"],
    category: json["category"],
    price: json["price"],
    discount: json["discount"],
    unit: json["unit"],
    productDetail: json["productDetail"],
    piece: json["piece"],
    imageUrl: json["imageUrl"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "category": category,
    "price": price,
    "discount": discount,
    "unit": unit,
    "productDetail": productDetail,
    "piece": piece,
    "imageUrl": imageUrl,
  };
}