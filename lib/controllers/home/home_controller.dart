import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:shopee_seller_app/controllers/services/app_firebase/firestore_db.dart';
import 'package:shopee_seller_app/models/manage_business_model/BusinessModel.dart';
import 'package:flutter/material.dart';
import 'package:shopee_seller_app/views/screens/catalogue/catalogue_screen.dart';
import 'package:shopee_seller_app/views/screens/catalogue/category/show_category.dart';
import 'package:shopee_seller_app/views/screens/catalogue/product/view_product.dart';
import 'package:shopee_seller_app/views/screens/caustomers/caustomer_home/caustome_home.dart';
import 'package:shopee_seller_app/views/screens/order_section/online_order_screen.dart';
import 'package:shopee_seller_app/views/screens/store_banner/store_banner_screen.dart';

class HomeController extends GetxController {
  @override
  void onInit() {
    getOrders();
    super.onInit();
  }
  RxString _totalOrders = '0'.obs;
  List<BusinessModel> get businessSummeryList => [
    BusinessModel(
      title: 'Sell',
      icon: Icons.sell,
      onTap: () {},
      amount: '0',
    ),
    BusinessModel(
      title: 'Orders',
      icon: Icons.shopping_bag,
      onTap: () {
        Get.to(() => OnlineOrdersScreen());
      },
      amount: _totalOrders.value,
    ),
    BusinessModel(
      title: 'To Pay',
      icon: Icons.call_made_sharp,
      onTap: () {},
      amount: '0',
    ),
    BusinessModel(
      title: 'To Collect',
      icon: Icons.call_received,
      onTap: () {},
      amount: '0',
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
    AppFireStoreDatabase(collection: 'Orders')
        .getAllAsStream()
        .streamAllData
        ?.listen((event) {
      _totalOrders.value = event.docs.length.toString();
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
