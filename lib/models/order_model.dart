// To parse this JSON data, do
//
//     final orderModel = orderModelFromJson(jsonString);

import 'dart:convert';

OrderModel orderModelFromJson(String str) => OrderModel.fromJson(json.decode(str));

String orderModelToJson(OrderModel data) => json.encode(data.toJson());

class OrderModel {
  String? orderId;
  String? productId;
  String? categoryId;
  String? productName;
  String? categoryName;
  String? productImages;
  String? deliveryDate;
  String? deliveryTime;
  String? productDescription;
  String? productQuantity;
  String? productTotalPrice;
  String? customerId;
  OrderStatus? orderStatus;
  String? customerName;
  String? customerPhone;
  String? customerAddress;
  String? customerEmail;

  OrderModel({
    this.orderId,
    this.productId,
    this.categoryId,
    this.productName,
    this.categoryName,
    this.productImages,
    this.deliveryDate,
    this.deliveryTime,
    this.productDescription,
    this.productQuantity,
    this.productTotalPrice,
    this.customerId,
    this.orderStatus,
    this.customerName,
    this.customerPhone,
    this.customerAddress,
    this.customerEmail,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) => OrderModel(
    orderId: json["orderId"],
    productId: json["productId"],
    categoryId: json["categoryId"],
    productName: json["productName"],
    categoryName: json["categoryName"],
    productImages: json["productImages"],
    deliveryDate: json["deliveryDate"],
    deliveryTime: json["deliveryTime"],
    productDescription: json["productDescription"],
    productQuantity: json["productQuantity"],
    productTotalPrice: json["productTotalPrice"],
    customerId: json["customerId"],
    orderStatus: json["orderStatus"] == null ? null : OrderStatus.fromJson(json["orderStatus"]),
    customerName: json["customerName"],
    customerPhone: json["customerPhone"],
    customerAddress: json["customerAddress"],
    customerEmail: json["customerEmail"],
  );

  Map<String, dynamic> toJson() => {
    "orderId": orderId,
    "productId": productId,
    "categoryId": categoryId,
    "productName": productName,
    "categoryName": categoryName,
    "productImages": productImages,
    "deliveryDate": deliveryDate,
    "deliveryTime": deliveryTime,
    "productDescription": productDescription,
    "productQuantity": productQuantity,
    "productTotalPrice": productTotalPrice,
    "customerId": customerId,
    "orderStatus": orderStatus?.toJson(),
    "customerName": customerName,
    "customerPhone": customerPhone,
    "customerAddress": customerAddress,
    "customerEmail": customerEmail,
  };
}

class OrderStatus {
  bool? orderStatusNew;
  bool? confirmed;
  bool? shipment;
  bool? complete;
  bool? returns;
  bool? cancelled;

  OrderStatus({
    this.orderStatusNew,
    this.confirmed,
    this.shipment,
    this.complete,
    this.returns,
    this.cancelled,
  });

  factory OrderStatus.fromJson(Map<String, dynamic> json) => OrderStatus(
    orderStatusNew: json["new"],
    confirmed: json["confirmed"],
    shipment: json["shipment"],
    complete: json["complete"],
    returns: json["returns"],
    cancelled: json["cancelled"],
  );

  Map<String, dynamic> toJson() => {
    "new": orderStatusNew,
    "confirmed": confirmed,
    "shipment": shipment,
    "complete": complete,
    "returns": returns,
    "cancelled": cancelled,
  };
}
