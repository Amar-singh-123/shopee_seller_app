import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:shopee_seller_app/views/utils/app_extensions/app_extensions.dart';
import 'package:shopee_seller_app/views/utils/app_styles/app_styles.dart';
import '../../../../controllers/auth/phone_auth_controller.dart';

class OtpVerificationScreen extends StatelessWidget {
  final String verificationId;

  OtpVerificationScreen({super.key, required this.verificationId});

  final TextEditingController pinController = TextEditingController();

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
                Pinput(
                  controller: pinController,
                  focusNode: FocusNode(),
                  length: 6,
                  androidSmsAutofillMethod:
                      AndroidSmsAutofillMethod.smsUserConsentApi,
                  listenForMultipleSmsOnAndroid: true,
                  separatorBuilder: (index) => const SizedBox(width: 8),
                ),
              ],
            ),
            SizedBox(
              width: context.screenWidth,
              height: context.screenHeight * 0.06,
              child: ElevatedButton(
                  style: elevatedButtonStyle,
                  onPressed: () {
                    AuthController.otpVerification(
                        context: context,
                        smsCode: pinController.text,
                        verificationId: verificationId);
                  },
                  child: Text(
                    "Verify",
                    style: defaultTextStyle,
                  )),
            )
          ],
        ),
      ),
    );
  }
}
