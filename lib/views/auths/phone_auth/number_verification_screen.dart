import 'package:flutter/material.dart';
import 'package:shopee_seller_app/views/utils/app_widgets/app_widgets.dart';

class NumberVerificationScreen extends StatefulWidget {
  const NumberVerificationScreen({super.key});

  @override
  State<NumberVerificationScreen> createState() => _NumberVerificationScreenState();
}

class _NumberVerificationScreenState extends State<NumberVerificationScreen> {
  @override
  Widget build(BuildContext context) {
    var view = AppWidgets(context: context);
    return Scaffold(
      appBar: view.appBarView(),
      body: ListView(
        children: const [
          Text("Enter your"),
          Text("mobile number"),
          Text("We'll send OTP on this number")
        ],
      ),

    );
  }
}
