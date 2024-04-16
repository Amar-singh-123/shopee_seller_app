import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopee_seller_app/views/screens/auth/phone_auth/otp_verification_screen.dart';
import 'package:shopee_seller_app/views/screens/home/home_screen.dart';
import 'package:shopee_seller_app/views/utils/app_colors/app_colors.dart';
import 'package:shopee_seller_app/views/utils/app_extensions/app_extensions.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../../views/screens/seller_profile/manage_seller_profile.dart';

class AuthController {
  static phoneAuth(String number, BuildContext context) {
    FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: number,
      verificationCompleted: (c) {
        context.showSnackBar(
            title: "Otp: ",
            message: 'verificationCompleted',
            color: AppColor.dark);
      },
      verificationFailed: (f) {
        context.showSnackBar(
            title: "Otp: ",
            message: 'verificationFailed',
            color: AppColor.dark);
      },
      codeSent: (verificationId, forceResendingToken) {
        context.showSnackBar(
            title: "Otp: ", message: 'otp sent', color: AppColor.dark);
        context
            .pushReplace(OtpVerificationScreen(verificationId: verificationId));
      },
      codeAutoRetrievalTimeout: (v) {
        context.showSnackBar(
            title: "Otp: ",
            message: 'codeAutoRetrievalTimeout',
            color: AppColor.dark);
      },
    );
  }

  static otpVerification(
      {required BuildContext context,
      required String smsCode,
      required String verificationId}) {
    PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId, smsCode: smsCode);
    FirebaseAuth.instance.signInWithCredential(credential).whenComplete(() {
      if(FirebaseAuth.instance.currentUser?.uid != null){
        context.showSnackBar(title: "Otp: ", message: ' verification completed', color: AppColor.dark);
       navigateUser(uid: FirebaseAuth.instance.currentUser?.uid);
      }
    });
  }

  static void navigateUser({String? uid}) async{
   var data = await FirebaseFirestore.instance.collection('seller_profile').doc(uid).get();
   if(data.exists){
     Get.offAll(()=>HomeScreen());
   }else{
     Get.offAll(()=>ManageProfileScreen());
    }
  }


 static Future<void> signInWithGoogle(BuildContext context) async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    var res = await FirebaseAuth.instance.signInWithCredential(credential);
    if(FirebaseAuth.instance.currentUser?.uid != null){
      context.showSnackBar(title: "Google Sign in: ", message: 'verification completed', color: AppColor.dark);
      navigateUser(uid: FirebaseAuth.instance.currentUser?.uid);
    }
  }
}
