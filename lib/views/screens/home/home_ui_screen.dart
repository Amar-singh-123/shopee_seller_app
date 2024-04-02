import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopee_seller_app/views/screens/profile/profile_screen.dart';
import 'package:shopee_seller_app/views/utils/app_extensions/app_extensions.dart';

import '../../utils/app_colors/app_colors.dart';
import '../auth/phone_auth/phone_auth_screen.dart';
import '../seller_profile/manage_seller_profile.dart';

class HomeUiScreen extends StatefulWidget {
  const HomeUiScreen({super.key});

  @override
  State<HomeUiScreen> createState() => _HomeUiScreenState();
}

class _HomeUiScreenState extends State<HomeUiScreen> {
  var _isOnline = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('home'),
        actions: [
          SizedBox(
            width: 100,
            height: 50,
            child: Switch(
              inactiveTrackColor: AppColor.red,
              activeTrackColor: AppColor.green,
              dragStartBehavior: DragStartBehavior.start,
              value: _isOnline,
              onChanged: (value) => setState(() {
                _isOnline = value;
              }),
            ),
          )
        ],
      ),
      drawer: Drawer(
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  children: [
                    10.height,
                    ListTile(
                      tileColor: AppColor.lightBlue,
                      leading: Icon(CupertinoIcons.profile_circled),
                      title: Text('profile'),
                      onTap: () {
                        context.pop;
                         Get.to(() => ManageProfileScreen());
                      },
                      horizontalTitleGap: 50,
                      shape: 10.shapeBorderRadius,
                    ),
                  ],
                ),
              ),
              ListTile(
                tileColor: AppColor.lightBlue,
                leading: Icon(CupertinoIcons.arrow_clockwise_circle_fill),
                title: Text('Logout'),
                onTap: () {
                  context.pop;
                  FirebaseAuth.instance.signOut;
                  Get.offAll(() => PhoneAuthScreen());
                },
                horizontalTitleGap: 50,
                shape: 10.shapeBorderRadius,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
