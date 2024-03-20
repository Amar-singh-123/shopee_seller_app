import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:shopee_seller_app/views/utils/app_constants/image_constants.dart';
import 'package:shopee_seller_app/views/utils/app_extensions/app_extensions.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  var user = FirebaseAuth.instance.currentUser?.uid;

  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      if (user != null) {

      } else {}
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Lottie.asset(
              "assets/images/splash_animation.json",
              height: context.screenHeight * 0.1,
              width: double.infinity,
            ),
            60.height,
            const CircularProgressIndicator(
              backgroundColor: Colors.blueAccent,
              valueColor: AlwaysStoppedAnimation(Colors.green),
              strokeWidth: 5,
            ),
          ],
        ),
      ),
    );
    ;
  }
}
