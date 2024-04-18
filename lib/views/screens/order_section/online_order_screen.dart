import 'package:flutter/material.dart';
import 'package:shopee_seller_app/views/screens/order_section/search_screen.dart';
import 'package:shopee_seller_app/views/screens/order_section/tabs/shipping_screen.dart';
import 'package:shopee_seller_app/views/screens/order_section/tabs/picked_up.dart';
import 'package:shopee_seller_app/views/screens/order_section/tabs/confirmed_screen.dart';
import 'package:shopee_seller_app/views/screens/order_section/tabs/delivered_screen.dart';
import 'package:shopee_seller_app/views/screens/order_section/tabs/new_screen.dart';
import 'package:shopee_seller_app/views/screens/order_section/tabs/ready_for_ship.dart';
import 'package:shopee_seller_app/views/screens/order_section/tabs/ready_for_pickup.dart';
import 'package:shopee_seller_app/views/screens/order_section/tabs/out_for_pickup.dart';
import 'package:shopee_seller_app/views/utils/app_extensions/app_extensions.dart';
import 'package:shopee_seller_app/views/utils/app_styles/app_styles.dart';
import 'create_order_screen.dart';
import 'tabs/cancelled.dart';
import 'tabs/out_for_delivery_screen.dart';
import 'tabs/ready_for_delivery_screen.dart';
import 'tabs/returned_screen.dart';
import 'tabs/shipped_screen.dart';

class OnlineOrdersScreen extends StatefulWidget {
  const OnlineOrdersScreen({super.key});

  @override
  _OnlineOrdersScreenState createState() => _OnlineOrdersScreenState();
}

class _OnlineOrdersScreenState extends State<OnlineOrdersScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 13, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Online Orders',
          style: appBarTextStyle,
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              context.push(SearchScreen());
            },
          ),
          IconButton(
            icon: Icon(Icons.more_vert),
            onPressed: () {},
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          isScrollable: true,
          tabs: const [
            Tab(text: 'New'),
            Tab(text: 'Confirmed'),
            Tab(text: 'ReadyForPickUp'),
            Tab(text: 'OutForPickUp'),
            Tab(text: 'PickedUp'),
            Tab(text: 'ReadyForShip'),
            Tab(text: 'Shipping'),
            Tab(text: 'Shipped'),
            Tab(text: 'ReadyForDelivery'),
            Tab(text: 'OutForDelivery'),
            Tab(text: 'Delivered'),
            Tab(text: 'Returned'),
            Tab(text: 'Canceled'),
          ],
          indicatorColor: Color(0xff2041a9),
          indicatorWeight: 2.0,
          indicatorSize: TabBarIndicatorSize.tab,
          labelColor: Color(0xff2041a9),
          unselectedLabelColor: Color(0xff4961b9),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: const [
          NewScreen(),
          ConfirmedScreen(),
          ReadyForPickUp(),
          OutForPickUp(),
          PickedUp(),
          ReadyForShip(),
          Shipping(),
          ShippedScreen(),
          ReadyForDeliveryScreen(),
          OutForDelivery(),
          DeliveredScreen(),
          ReturnedScreen(),
          Cancelled(),

        ],
      ),
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}
