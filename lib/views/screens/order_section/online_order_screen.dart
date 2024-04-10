import 'package:flutter/material.dart';
import 'package:shopee_seller_app/views/screens/order_section/search_screen.dart';
import 'package:shopee_seller_app/views/screens/order_section/tabs/cancelled_screen.dart';
import 'package:shopee_seller_app/views/screens/order_section/tabs/complete_screen.dart';
import 'package:shopee_seller_app/views/screens/order_section/tabs/confirmed_screen.dart';
import 'package:shopee_seller_app/views/screens/order_section/tabs/new_screen.dart';
import 'package:shopee_seller_app/views/screens/order_section/tabs/returns_screen.dart';
import 'package:shopee_seller_app/views/screens/order_section/tabs/shipment_screen.dart';
import 'package:shopee_seller_app/views/screens/order_section/tabs/transit_screen.dart';
import 'package:shopee_seller_app/views/utils/app_extensions/app_extensions.dart';
import 'package:shopee_seller_app/views/utils/app_styles/app_styles.dart';
import 'create_order_screen.dart';

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
    _tabController = TabController(length: 7, vsync: this);
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
            Tab(text: 'Shipment Ready'),
            Tab(text: 'In Transit'),
            Tab(text: 'Complete'),
            Tab(text: 'Returns'),
            Tab(text: 'Cancelled'),
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
          // NewScreen(),
          ConfirmedScreen(),
          ShipmentScreen(),
          TransitScreen(),
          CompleteScreen(),
          ReturnsScreen(),
          CancelledScreen(),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            context.push(CreateOrderScreen());
          },
          label: Text(
            'ORDER',
            style:
                TextStyle(color: Colors.white, letterSpacing: 2, fontSize: 13),
          ),
          icon: Icon(
            Icons.add,
            color: Colors.white,
            size: 20,
          ),
          backgroundColor: Color(0xff1236b1),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(100.0),
          )),
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}
