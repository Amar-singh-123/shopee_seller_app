import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shopee_seller_app/views/screens/auth/otp_verification_screen.dart';
import 'package:shopee_seller_app/views/screens/home/home_screen.dart';
import 'package:shopee_seller_app/views/utils/app_colors/app_colors.dart';
import 'package:shopee_seller_app/views/utils/app_extensions/app_extensions.dart';

class AuthController {
  static phoneAuth(String number, BuildContext context) {
    FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: number,
      verificationCompleted: (c) {},
      verificationFailed: (f) {},
      codeSent: (verificationId, forceResendingToken) {
        context
            .pushReplace(OtpVerificationScreen(verificationId: verificationId));
      },
      codeAutoRetrievalTimeout: (v) {},
    );
  }

  static otpVerification(
      {required BuildContext context,
      required String smsCode,
      required String verificationId}) {
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId, smsCode: smsCode);
    FirebaseAuth.instance.signInWithCredential(credential).whenComplete(() {
      if (FirebaseAuth.instance.currentUser?.uid != null) {
        context.pushReplace(HomeScreen());
        context.showSnackBar(
            title: "Otp: ",
            message: ' verification completed',
            color: AppColor.dark);
      }
    });
  }
}
