import 'dart:ui';

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
      body: Padding(
        padding:
            const EdgeInsets.only(left: 20, right: 20, bottom: 30, top: 50),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                RichText(
                  text: const TextSpan(
                    children: [
                      TextSpan(
                        text: 'Register using\n',
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 20,
                            color: Colors.black87),
                      ),
                      TextSpan(
                        text: 'your mobile number\n',
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 20,
                            color: Colors.black87),
                      ),
                      TextSpan(
                        text: "We'll send OTP on this number",
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                            color: Colors.black87),
                      ),
                    ],
                  ),
                ),
                30.height,
                IntlPhoneField(
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
              ],
            ),
            Column(
              children: [
                SizedBox(
                  width: context.screenWidth,
                  height: context.screenHeight * 0.06,
                  child: ElevatedButton(
                      style: elevatedButtonStyle,
                      onPressed: () {
                        AuthController.phoneAuth(phoneController, context);
                      },
                      child: Text(
                        "Get OTP",
                        style: defaultTextStyle,
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 10, top: 18),
                  child: RichText(
                    text: const TextSpan(
                      children: <TextSpan>[
                        TextSpan(
                          text: "Don't have an account? ",
                          style: TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 14,
                              color: Colors.black87),
                        ),
                        TextSpan(
                          text: "Register",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                              color: Colors.deepPurpleAccent),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
