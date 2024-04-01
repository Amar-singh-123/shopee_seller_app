import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopee_seller_app/views/screens/home/home_ui_screen.dart';
import 'package:shopee_seller_app/views/screens/order_section/online_order_screen.dart';
import 'package:shopee_seller_app/views/screens/settings/setting_screen.dart';
import 'package:shopee_seller_app/views/utils/app_extensions/app_extensions.dart';
import '../../utils/app_colors/app_colors.dart';
import '../auth/phone_auth/phone_auth_screen.dart';
import '../catalogue/catalogue_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        onTap: (value) {
          _selectedIndex = value;
          setState(() {});
        },
        showUnselectedLabels: true,
        type: BottomNavigationBarType.shifting,
        selectedItemColor: AppColor.inActiveColor,
        unselectedItemColor: AppColor.gray,
        currentIndex: _selectedIndex,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.home), label: "home"),
          BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.bag), label: "orders"),
          BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.cart), label: "Catalogue"),
          BottomNavigationBarItem(
              icon: Icon(CupertinoIcons.settings), label: "manage"),
        ],
      ),
      body: allScreens[_selectedIndex],
    );
  }
  var allScreens = [
    HomeUiScreen(),
    OnlineOrdersScreen(),
    CatalogueScreen(),
    SettingScreen(),
  ];
}
