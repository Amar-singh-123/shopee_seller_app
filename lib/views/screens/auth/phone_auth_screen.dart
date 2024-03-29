import 'package:flutter/material.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:shopee_seller_app/controllers/auth/phone_auth_controller.dart';
import 'package:shopee_seller_app/views/utils/app_extensions/app_extensions.dart';

import '../../utils/app_styles/app_styles.dart';

class PhoneAuthScreen extends StatelessWidget {
  PhoneAuthScreen({super.key});

  String phoneController = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: IntlPhoneField(
              flagsButtonPadding: const EdgeInsets.all(8),
              dropdownIconPosition: IconPosition.trailing,
              decoration: const InputDecoration(
                labelText: 'Phone Number',
                border: OutlineInputBorder(
                  borderSide: BorderSide(),
                ),
              ),
              initialCountryCode: 'IN',
              onChanged: (phone) {
                phoneController = phone.completeNumber;
              },
            ),
          ),
          SizedBox(
            width: context.screenWidth * 0.5,
            height: context.screenHeight * 0.05,
            child: ElevatedButton(
                style: elevatedButtonStyle,
                onPressed: () {
                  AuthController.phoneAuth(phoneController, context);
                },
                child:  Text("Send otp", style: defaultTextStyle,)),
          )
        ],
      ),
    );
  }
}
