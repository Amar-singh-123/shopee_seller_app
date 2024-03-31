import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shopee_seller_app/models/orders/order_model.dart';
import 'package:shopee_seller_app/views/utils/app_extensions/app_extensions.dart';
import 'package:shopee_seller_app/views/utils/app_styles/app_styles.dart';

class CreateOrderScreen extends StatefulWidget {
  const CreateOrderScreen({Key? key}) : super(key: key);

  @override
  State<CreateOrderScreen> createState() => _CreateOrderScreenState();
}

class _CreateOrderScreenState extends State<CreateOrderScreen> {
  DateTime selectedDate = DateTime.now();
  String invoice = '0001';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Order',
          style: appBarTextStyle,
        ),
        leading: IconButton(
          icon: Icon(Icons.close),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.settings,
              color: Color(0xff2041a9),
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: Container(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Order Date',
                  style: TextStyle(fontSize: 14, color: Colors.black54),
                ),
                Row(
                  children: [
                    Text(
                      '${digitToMonth(selectedDate.month)} ${selectedDate.day}, ${selectedDate.year}',
                      style: TextStyle(fontSize: 15, color: Colors.black87),
                    ),
                    IconButton(
                      icon: Icon(
                        Icons.date_range,
                        color: Color(0xff2041a9),
                      ),
                      onPressed: () async {
                        await showDatePicker(context);
                      },
                    ),
                  ],
                )
              ],
            ),
            Divider(
              color: Colors.black26,
              height: 2,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Invoice #',
                  style: TextStyle(fontSize: 13, color: Colors.black45),
                ),
                Text(
                  'Auto Assigned (INV-$invoice)',
                  style: TextStyle(
                    fontSize: 13,
                    color: Color(0xff2041a9),
                  ),
                ),
              ],
            ),
            ElevatedButton(
                onPressed: () {
                  OrderModel orderModel = OrderModel(
                    categoryId: "1",
                    categoryName: "Shirt",
                    customerId: "1",
                    customerAddress: "Lachhi",
                    customerEmail: "raushansingh@gmail.com",
                    customerName: "Raushan Singh",
                    customerPhone: "+919060911045",
                    deliveryTime:
                        '${selectedDate.hour}:${selectedDate.minute} Am',
                    deliveryDate:
                        '${digitToMonth(selectedDate.month)} ${selectedDate.day + 1}, ${selectedDate.year}',
                    orderId: "second_order",
                    orderStatus: OrderStatus(),
                    productDescription: "this jeans is very smart for men.",
                    productId: '1',
                    productImages: null,
                    productName: "Shirt",
                    productQuantity: '1',
                    productTotalPrice: '70',
                  );
                  FirebaseFirestore.instance
                      .collection('Orders')
                      .doc('second_order')
                      .set(orderModel.toJson());
                },
                child: Text("Add"))
          ],
        ),
      ),
    );
  }

  showDatePicker(BuildContext context) async {
    await showCupertinoModalPopup<void>(
      context: context,
      builder: (_) {
        return Container(
          height: context.screenHeight * 0.31,
          decoration: const BoxDecoration(
            color: Colors.white,
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text(
                        'Cancel',
                        style: TextStyle(fontSize: 14, color: Colors.black45),
                      )),
                  TextButton(
                      onPressed: () {
                        setState(() {});
                        Navigator.pop(context);
                      },
                      child: const Text(
                        'Done',
                        style:
                            TextStyle(fontSize: 14, color: Colors.blueAccent),
                      ))
                ],
              ),
              SizedBox(
                height: context.screenHeight * 0.25,
                child: CupertinoDatePicker(
                  dateOrder: DatePickerDateOrder.ymd,
                  initialDateTime: selectedDate,
                  minimumDate: DateTime(2020, 1, 1),
                  maximumDate: DateTime(2049, 12, 31),
                  mode: CupertinoDatePickerMode.date,
                  onDateTimeChanged: (value) {
                    selectedDate = value;
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  String digitToMonth(int monthDigit) {
    switch (monthDigit) {
      case 1:
        return 'Jan';
      case 2:
        return 'Feb';
      case 3:
        return 'Mar';
      case 4:
        return 'Apr';
      case 5:
        return 'May';
      case 6:
        return 'Jue';
      case 7:
        return 'Jul';
      case 8:
        return 'Aug';
      case 9:
        return 'Sep';
      case 10:
        return 'Oct';
      case 11:
        return 'Nov';
      case 12:
        return 'Dec';
      default:
        return 'Invalid Month';
    }
  }
}
