import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:shopee_seller_app/views/utils/app_extensions/app_extensions.dart';
import 'package:shopee_seller_app/views/utils/app_styles/app_styles.dart';
import '../../../controllers/auth/phone_auth_controller.dart';

class OtpVerificationScreen extends StatelessWidget {
  final String verificationId;
   OtpVerificationScreen({super.key, required this.verificationId});

 final TextEditingController pinController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Pinput(
            controller: pinController,
            focusNode: FocusNode(),
            length: 6,
            androidSmsAutofillMethod:
            AndroidSmsAutofillMethod.smsUserConsentApi,
            listenForMultipleSmsOnAndroid: true,
            separatorBuilder: (index) => const SizedBox(width: 8),),
          40.height,
          SizedBox(
            width: context.screenWidth * 0.5,
            height: context.screenHeight * 0.05,
            child: ElevatedButton(onPressed: () {
              AuthController.otpVerification(context: context, smsCode: pinController.text, verificationId: verificationId);
            }, child:  Text("Verify", style: defaultTextStyle,)),
          )
        ],
      )

    );
  }
}
