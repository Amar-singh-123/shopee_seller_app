import 'package:flutter/material.dart';
import 'package:shopee_seller_app/views/screens/catalogue/product/view_product.dart';

import 'category/show_category.dart';

class CatalogueScreen extends StatefulWidget {
   CatalogueScreen({super.key, this.selectedTab});
int? selectedTab;
  @override
  State<CatalogueScreen> createState() => _CatalogueScreenState();
}

class _CatalogueScreenState extends State<CatalogueScreen> {
  var _initialIndex = 0;

  @override
  void initState() {
    _initialIndex = widget.selectedTab ?? 0;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2, initialIndex: _initialIndex, child: Scaffold(
      appBar: AppBar(
        title:Text('Catelogue'),
        bottom: TabBar(
            tabs: [
              Tab(text:'Products' ,),
              Tab(text:'Category' ,),
            ]),
      ),
      body: TabBarView(
        children: [
          ViewProducts(),
          ShowCategory(),
        ],
      ),
    ),

    );
  }
}
