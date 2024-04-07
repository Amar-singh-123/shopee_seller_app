import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopee_seller_app/models/orders/order_model.dart';
import 'package:shopee_seller_app/views/screens/catalogue/product/add_product.dart';
import 'package:shopee_seller_app/views/screens/seller_profile/manage_seller_profile.dart';
import 'package:shopee_seller_app/views/utils/app_extensions/app_extensions.dart';

class ManageScreen extends StatelessWidget {
  const ManageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Manage",
        ),
      ),
      body: ListView(
        children: <Widget>[
          GestureDetector(
            onTap: () {
              Get.to(ManageProfileScreen());
            },
            child: const ListTile(
              leading: Icon(CupertinoIcons.profile_circled),
              title: Text('Profile'),
              subtitle: Text('Your profile Settings'),
              trailing: Icon(Icons.arrow_forward_ios, size: 13),
            ),
          ),
          const Divider(),
          GestureDetector(
            onTap: () {
              Get.to(OrderStatus());
            },
            child: const ListTile(
              leading: Icon(Icons.production_quantity_limits),
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Order'),
                  Icon(
                    CupertinoIcons.heart_fill,
                    size: 15,
                    color: Colors.red,
                  ),
                ],
              ),
              subtitle: Text('Get store Android App & publish'),
              trailing: Icon(Icons.arrow_forward_ios, size: 13),
            ),
          ),
          const Divider(),
          GestureDetector(
            onTap: () {
              Get.to(AddProductScreen());
            },
            child: const ListTile(
              leading: Icon(Icons.production_quantity_limits_sharp),
              title: Text('Add Products'),
              subtitle: Text('Promote and unlock more features & reports'),
              trailing: Icon(Icons.arrow_forward_ios, size: 13),
            ),
          ),
          const Divider(),
          15.height,
          const Divider(),
          GestureDetector(
            onTap: () {
              // Handle tap actions here
            },
            child: const ListTile(
              title: Text('Shoopy for pc'),
              subtitle: Text('Use shoopy from your laptop & desktop'),
              trailing: Icon(Icons.arrow_forward_ios, size: 13),
            ),
          ),
          const Divider(),
          GestureDetector(
            onTap: () {
              // Handle tap actions here
            },
            child: const ListTile(
              title: Text('About Us'),
              subtitle: Text('About Us,App Version and other information'),
              trailing: Icon(Icons.arrow_forward_ios, size: 13),
            ),
          ),
          10.height,
          const Center(
              child: Text(
            "Logout",
            style: TextStyle(color: Colors.blue),
          )),
          15.height
        ],
      ),
    );
  }
}
