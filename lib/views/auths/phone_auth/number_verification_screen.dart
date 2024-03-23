import 'package:flutter/material.dart';
import 'package:shopee_seller_app/views/utils/app_constants/text_constants.dart';
import 'package:shopee_seller_app/views/utils/app_widgets/app_widgets.dart';

class NumberVerificationScreen extends StatefulWidget {
  const NumberVerificationScreen({super.key});

  @override
  State<NumberVerificationScreen> createState() => _NumberVerificationScreenState();
}

class _NumberVerificationScreenState extends State<NumberVerificationScreen> {
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  final TextEditingController _numberVerificationController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    var view = AppWidgets(context: context);
    return Scaffold(
      appBar: view.appBarView(),
      body: Form(
        key: _globalKey,
        child: ListView(
          children: const [
            Text(enterYour),
            Text(mobileNumber),
            Text(weSendOTPOnThisNumber),




          ],
        ),
      ),

    );
  }
}
