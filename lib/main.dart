import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shopee_seller_app/views/screens/auth/otp_verification_screen.dart';
import 'package:shopee_seller_app/views/screens/auth/phone_auth_screen.dart';
import 'package:get/get.dart';
import 'package:shopee_seller_app/views/screens/splash_screen/splash_screens.dart';

import 'firebase_options.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(

    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
        theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const SplashScreen(),
    );
    }
}
