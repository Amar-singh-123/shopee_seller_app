import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

OrderModel orderModelFromJson(String str) => OrderModel.fromJson(json.decode(str));

String orderModelToJson(OrderModel data) => json.encode(data.toJson());

class OrderModel {
  String? orderId;
  String? addressId;
  String? productId;
  String? sellerId;
  String? customerId;
  Timestamp? orderDate;
  int? color;
  String? size;
  String? pinCode;
  String? paymentId;
  int? totalQuantity;
  int? totalPrice;
  int? originalPrice;
  int? deliveryCharge;
  PaymentMode? paymentMode;
  OrderStatus? orderStatus;

  OrderModel({
    this.orderId,
    this.addressId,
    this.productId,
    this.sellerId,
    this.customerId,
    this.orderDate,
    this.pinCode,
    this.paymentId,
    this.totalQuantity,
    this.totalPrice,
    this.originalPrice,
    this.deliveryCharge,
    this.paymentMode,
    this.orderStatus,
    this.color,
    this.size,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) => OrderModel(
    orderId: json["orderId"],
    addressId: json["addressId"],
    productId: json["productId"],
    sellerId: json["sellerId"],
    customerId: json["customerId"],
    orderDate: json["orderDate"],
    pinCode: json["pinCode"],
    paymentId: json["paymentId"],
    totalQuantity: json["totalQuantity"],
    totalPrice: json["totalPrice"],
    color: json["color"],
    size: json["size"],
    originalPrice: json["originalPrice"],
    deliveryCharge: json["deliveryCharge"],
    paymentMode: json["paymentMode"] == null ? null : PaymentMode.fromJson(json["paymentMode"]),
    orderStatus: json["orderStatus"] == null ? null : OrderStatus.fromJson(json["orderStatus"]),
  );

  Map<String, dynamic> toJson() => {
    "orderId": orderId,
    "addressId": addressId,
    "productId": productId,
    "sellerId": sellerId,
    "customerId": customerId,
    "orderDate": orderDate,
    "pinCode": pinCode,
    "paymentId": paymentId,
    "totalQuantity": totalQuantity,
    "totalPrice": totalPrice,
    "originalPrice": originalPrice,
    "deliveryCharge": deliveryCharge,
    "color": color,
    "size": size,
    "paymentMode": paymentMode?.toJson(),
    "orderStatus": orderStatus?.toJson(),
  };
}

class OrderStatus {
  bool? pending;
  bool? confirmed;
  bool? readyForPickUp;
  bool? outForPickUp;
  bool? pickedUp;
  bool? readyForShip;
  bool? shipping;
  bool? shipped;
  bool? readyForDelivery;
  bool? outForDelivery;
  bool? delivered;
  bool? canceled;
  bool? returned;

  OrderStatus({
    this.pending = true,
    this.confirmed =  false,
    this.readyForPickUp = false,
    this.outForPickUp = false,
    this.pickedUp = false,
    this.readyForShip = false,
    this.shipping = false,
    this.shipped = false,
    this.readyForDelivery = false,
    this.outForDelivery = false,
    this.delivered = false,
    this.canceled = false,
    this.returned = false,
  });
  factory OrderStatus.fromJson(Map<String, dynamic> json) => OrderStatus(
    pending: json["pending"],
    confirmed: json["confirmed"],
    readyForPickUp: json["readyForPickUp"],
    outForPickUp: json["outForPickUp"],
    pickedUp: json["pickedUp"],
    readyForShip: json["readyForShip"],
    shipping: json["shipping"],
    shipped: json["shipped"],
    readyForDelivery: json["ReadyForDelivery"],
    outForDelivery: json["outForDelivery"],
    delivered: json["delivered"],
    canceled: json["canceled"],
    returned: json["returned"],
  );

  Map<String, dynamic> toJson() => {
    "pending": pending,
    "confirmed": confirmed,
    "readyForPickUp": readyForPickUp,
    "outForPickUp": outForPickUp,
    "pickedUp": pickedUp,
    "readyForShip": readyForShip,
    "shipping": shipping,
    "shipped": shipped,
    "ReadyForDelivery": readyForDelivery,
    "outForDelivery": outForDelivery,
    "delivered": delivered,
    "canceled": canceled,
    "returned": returned,
  };

  String get currentOrderStatus{
    if(pending == true) {
      return "pending";
    }
    else if(confirmed == true) {
      return "confirmed";
    }
    else if(readyForPickUp == true) {
      return "readyForPickUp";
    }
    else if(outForPickUp == true) {
      return "outForPickUp";
    }
    else if(pickedUp == true) {
      return "pickedUp";
    }
    else if(readyForShip == true) {
      return "readyForShip";
    }
    else if(shipping == true) {
      return "shipping";
    }
    else if(shipped == true) {
      return "shipped";
    }
    else if(readyForDelivery == true) {
      return "ReadyForDelivery";
    }
    else if(outForDelivery == true) {
      return "outForDelivery";
    }
    else if(delivered == true) {
      return "delivered";
    }
    else if(canceled == true) {
      return "canceled";
    }
    else if(returned == true) {
      return "returned";
    }
    else{
      return "";
    }

  }
}

class PaymentMode {
  bool? cashOnDelivery;
  bool? online;

  PaymentMode({
    this.cashOnDelivery,
    this.online,
  });

  factory PaymentMode.fromJson(Map<String, dynamic> json) => PaymentMode(
    cashOnDelivery: json["cashOnDelivery"],
    online: json["online"],
  );

  Map<String, dynamic> toJson() => {
    "cashOnDelivery": cashOnDelivery,
    "online": online,
  };

  String get currentPaymentMode {
    if(online == true){
      return "online";
    }else{
      return "cashOnDelivery";
    }
  }
}

