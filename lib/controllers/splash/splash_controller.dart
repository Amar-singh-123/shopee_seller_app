import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:shopee_seller_app/views/screens/auth/email_auth/signing_with_email.dart';

import '../../views/screens/home/home_screen.dart';
import '../../views/screens/seller_profile/manage_seller_profile.dart';
import '../services/app_firebase/app_firebase_auth.dart';
class SplashController {
  SplashController(this.context);
  BuildContext context;

  void navigateToAnotherPage(Widget screen) {
    Timer(
       const Duration(seconds: 2),
      () {
        Get.off(()=>screen);
      },
    );
  }

  void checkUser() async{
   if( AppAuth.isVerified){
     if(await AppAuth.detailsStatus){
       navigateToAnotherPage( HomeScreen());
     }else{
       navigateToAnotherPage(ManageProfileScreen());
     }
   }else{
     navigateToAnotherPage(SigningWithEmail());
   }
  }
}
