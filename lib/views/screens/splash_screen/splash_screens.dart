import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:shopee_seller_app/controllers/auth/phone_auth_controller.dart';
import 'package:shopee_seller_app/views/screens/auth/email_auth/signing_with_email.dart';
import 'package:shopee_seller_app/views/utils/app_extensions/app_extensions.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  var user = FirebaseAuth.instance.currentUser?.uid;
  @override
  Widget build(BuildContext context) {
    Timer(const Duration(seconds: 3), () {
      if (user != null) {
        AuthController.navigateUser(uid: user);
      } else {
        context.pushReplace(SigningWithEmail());
      }
    });
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
