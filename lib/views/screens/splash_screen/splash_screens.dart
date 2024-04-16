import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:shopee_seller_app/controllers/auth/phone_auth_controller.dart';
import 'package:shopee_seller_app/views/screens/auth/email_auth/signing_with_email.dart';
import 'package:shopee_seller_app/views/utils/app_extensions/app_extensions.dart';

import '../../../controllers/splash/splash_controller.dart';
import '../../utils/app_constants/animation_constants.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  var user = FirebaseAuth.instance.currentUser?.uid;
  @override
  Widget build(BuildContext context) {
    var controller = SplashController(context);
    controller.checkUser();
    return Scaffold(
      body: Container(
        child: Lottie.asset(
          introAnimation,
          width: context.screenWidth,
          height: context.screenHeight,
          fit: BoxFit.fitWidth,
          repeat: true,
          animate: true,
          filterQuality: FilterQuality.high,
        ),
      ),
    );

  }
}
