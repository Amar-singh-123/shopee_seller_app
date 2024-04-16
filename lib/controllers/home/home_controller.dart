import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:shopee_seller_app/controllers/services/app_firebase/app_firebase_auth.dart';
import 'package:shopee_seller_app/controllers/services/app_firebase/firestore_db.dart';
import 'package:shopee_seller_app/models/manage_business_model/BusinessModel.dart';
import 'package:flutter/material.dart';
import 'package:shopee_seller_app/models/orders/order_model.dart';
import 'package:shopee_seller_app/views/screens/catalogue/catalogue_screen.dart';
import 'package:shopee_seller_app/views/screens/catalogue/category/show_category.dart';
import 'package:shopee_seller_app/views/screens/catalogue/product/view_product.dart';
import 'package:shopee_seller_app/views/screens/caustomers/caustomer_home/caustome_home.dart';
import 'package:shopee_seller_app/views/screens/order_section/online_order_screen.dart';
import 'package:shopee_seller_app/views/screens/store_banner/store_banner_screen.dart';

class HomeController extends GetxController {
  RxString totalSell = "0".obs;
  RxString totalCod = "0".obs;
  RxString totalOnline = "0".obs;
  RxString totalOrders = '0'.obs;
  @override
  void onInit() {
    getOrders();
    super.onInit();
  }
  List<BusinessModel> get businessSummeryList => [
    BusinessModel(
      title: 'Sell',
      icon: Icons.sell,
      onTap: () {},
      amount: totalSell.value,
    ),
    BusinessModel(
      title: 'New Orders',
      icon: Icons.shopping_bag,
      onTap: () {
        Get.to(() => OnlineOrdersScreen());
      },
      amount: totalOrders.value,
    ),
    BusinessModel(
      title: 'Cod',
      icon: Icons.call_made_sharp,
      onTap: () {},
      amount: totalCod.value,
    ),
    BusinessModel(
      title: 'Online',
      icon: Icons.call_received,
      onTap: () {},
      amount: totalOnline.value,
    ),
  ];
  final manageBusinessList = [
    BusinessModel(
      title: 'customers',
      icon: Icons.emoji_people_rounded,
      onTap: () {
        Get.to(() => CustomerHome());
      },
      amount: "",
    ),
    BusinessModel(
      title: 'orders',
      icon: Icons.shopping_bag,
      onTap: () {
        Get.to(() => OnlineOrdersScreen());
      },
      amount: "",
    ),
    BusinessModel(
      title: 'Products',
      icon: Icons.group_work_sharp,
      onTap: () {
        Get.to(() => CatalogueScreen(selectedTab:0));
      },
      amount: "",
    ),
    BusinessModel(
      title: 'Categories',
      icon: Icons.category,
      onTap: () {
        Get.to(() => CatalogueScreen(selectedTab: 1,));
      },
      amount: "",
    ),
  ];
  final growBusinessList = [
    BusinessModel(
      title: 'Store Banners',
      icon: Icons.public,
      onTap: () {
        Get.to(() => StoreBannerScreen());
      },
      amount: "",
    ),
  ];

  void getOrders() {
    FirebaseFirestore.instance.collection('orders').where('sellerId',isEqualTo: AppAuth.userId).snapshots().listen((event) {
      totalOrders.value = event.docs.length.toString();
      if(event.docs.isNotEmpty){
        var ordersList = event.docs.map((e) => OrderModel.fromJson(e.data()));
        totalSell.value = ordersList.fold(0, (previousValue, element) =>  previousValue+ (element.totalPrice ?? 0)).toString();
        totalCod.value = ordersList.where((element) => element.paymentMode?.currentPaymentMode == 'cashOnDelivery').fold(0, (previousValue, element) =>  previousValue+ (element.totalPrice ?? 0)).toString();
        totalOnline.value = ordersList.where((element) => element.paymentMode?.currentPaymentMode == 'online').fold(0, (previousValue, element) =>  previousValue+ (element.totalPrice ?? 0)).toString();
        totalOrders.value = ordersList.where((element) => element.orderStatus?.currentOrderStatus == 'pending').toList().length.toString();
      }
    });
  }
// final _manageBusinessList = [
//   'customers',
//   'orders',
//   'products',
//   'categories',
//   'invoices',
//   'Wallet'
// ];
// final _growBusinessList = [
//   'collections',
//   'coupons',
//   'Store Banners',
//   'Marketing banners',
//   'Refer And Earn'
// ];
}
