import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:get/get.dart';
import 'package:shopee_seller_app/controllers/home/home_controller.dart';
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
  var _isOnline = true;
  var homeController = Get.put(HomeController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.white,
        shape: LinearBorder.bottom(
            side: BorderSide(
                width: 2, color: AppColor.lineDark, style: BorderStyle.solid)),
        title: const Text('home'),
        // actions: [
        //   SizedBox(
        //     width: 100,
        //     height: 50,
        //     child: FlutterSwitch(
        //       value: _isOnline,
        //       onToggle: (bool value) {
        //         setState(() {
        //           _isOnline = value;
        //         });
        //       },
        //       height: 27,
        //       width: 80,
        //       showOnOff: true,
        //       activeText: "Online",
        //       inactiveText: "Offline",
        //       activeColor: AppColor.green,
        //       inactiveColor: AppColor.red,
        //       inactiveTextColor: AppColor.white,
        //       activeTextColor: AppColor.white,
        //       activeTextFontWeight: FontWeight.w500,
        //       inactiveTextFontWeight: FontWeight.w500,
        //       toggleSize: 20,
        //       valueFontSize: 13,
        //       padding: 3,
        //     ),
        //   ),
        // ],
        centerTitle: true,
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
                  // context.pop;
                  // FirebaseAuth.instance.signOut;
                  // Get.offAll(() => PhoneAuthScreen());
                  _signOut(context);
                },
                horizontalTitleGap: 50,
                shape: 10.shapeBorderRadius,
              ),
            ],
          ),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await Future.delayed(
            Duration(seconds: 2),
            () {
              setState(() {});
            },
          );
        },
        child: ListView(
          shrinkWrap: true,
          physics: BouncingScrollPhysics(),
          children: [
            Card(
              color: AppColor.white,
              surfaceTintColor: AppColor.white,
              shape: 5.shapeBorderRadius,
              elevation: 0.3,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 20),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: ListTile(
                            contentPadding: 0.allPadding,
                            title: const Text('Business Summery'),
                            subtitle: Text('Complete Business summery in glance', style: TextStyle(color: AppColor.textSoft, fontSize: 11),),),
                        ),
                        InkWell(
                          borderRadius: 5.borderRadius,
                          splashColor: AppColor.lightBlue,
                          highlightColor: AppColor.lightBlue,
                          onTap: () {},
                          child: Container(
                            padding: 5.horizontalPadding,
                            height: 30,
                            decoration: BoxDecoration(
                              color: AppColor.lightGreen,
                              borderRadius: 5.borderRadius,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                5.width,
                                Text(
                                  "view",
                                  style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w400),
                                ),
                                5.width,
                                Icon(
                                  Icons.arrow_drop_down,
                                  size: 15,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    Obx(
                      ()=> GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: homeController.businessSummeryList.length,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                childAspectRatio: 200 / 80,
                                crossAxisSpacing: 20,
                                mainAxisSpacing: 20),
                        itemBuilder: (context, index) {
                          var currentItem = homeController.businessSummeryList[index];
                          return InkWell(
                            borderRadius: 8.borderRadius,
                            splashColor: AppColor.lightBlue,
                            highlightColor: AppColor.lightBlue,
                            onTap: currentItem.onTap,
                            child: Container(
                              padding: 5.allPadding,
                              decoration: BoxDecoration(
                                  borderRadius: 8.borderRadius,
                                  border: Border.all(
                                      width: 1,
                                      style: BorderStyle.solid,
                                      color: AppColor.lightBlue)),
                              child: Row(
                                children: [
                                  Container(
                                    padding: 10.allPadding,
                                    decoration: BoxDecoration(
                                        color: AppColor.lightGreen,
                                        borderRadius: 5.borderRadius),
                                    child:  Center(
                                      child: Icon(currentItem.icon,color: AppColor.darkPurple,),
                                    ),
                                  ),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(currentItem.amount),
                                        Text(currentItem.title)
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Card(
              color: AppColor.white,
              surfaceTintColor: AppColor.white,
              shape: 5.shapeBorderRadius,
              elevation: 0.3,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 20),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: ListTile(
                            title: Text('Manage Business'),
                            contentPadding: 0.allPadding,
                            subtitle: Text(
                              'Manage your business with different structures',
                              style: TextStyle(
                                  color: AppColor.textSoft, fontSize: 11),
                            ),
                          ),
                        ),
                        InkWell(
                          borderRadius: 5.borderRadius,
                          splashColor: AppColor.lightBlue,
                          highlightColor: AppColor.lightBlue,
                          onTap: () {},
                          child: Container(
                            padding: 4.horizontalPadding,
                            height: 30,
                            decoration: BoxDecoration(
                              color: AppColor.lightGreen,
                              borderRadius: 5.borderRadius,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                5.width,
                                Text(
                                  "view all",
                                  style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w400),
                                ),
                                5.width,
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    GridView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: homeController.manageBusinessList.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 4,
                              childAspectRatio: 80 / 100,
                              crossAxisSpacing: 10,
                              mainAxisSpacing: 10),
                      itemBuilder: (context, index) {
                        var currentItem = homeController.manageBusinessList[index];
                        return InkWell(
                          borderRadius: 8.borderRadius,
                          splashColor: AppColor.lightBlue,
                          highlightColor: AppColor.lightBlue,
                          onTap: currentItem.onTap,
                          child: Container(
                            padding: 5.allPadding,
                            decoration: BoxDecoration(
                                borderRadius: 8.borderRadius,
                                border: Border.all(
                                    width: 1,
                                    style: BorderStyle.solid,
                                    color: AppColor.lightBlue)),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  width: 50,
                                  height: 50,
                                  padding: 10.allPadding,
                                  decoration: BoxDecoration(
                                      color: AppColor.randomColor[index],
                                      borderRadius: 5.borderRadius),
                                  child: Center(
                                    child: Icon(
                                      currentItem.icon,
                                      color: AppColor.white,
                                    ),
                                  ),
                                ),
                                Text(
                                  currentItem.title,
                                  style: TextStyle(fontSize: 12),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
            Card(
              color: AppColor.white,
              surfaceTintColor: AppColor.white,
              shape: 5.shapeBorderRadius,
              elevation: 0.3,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 20),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: ListTile(
                            title: Text('Grow Business'),
                            contentPadding: 0.allPadding,
                            subtitle: Text(
                              'Grow Business with Online website, Social Selling',
                              style: TextStyle(
                                  color: AppColor.textSoft, fontSize: 11),
                            ),
                          ),
                        ),
                        InkWell(
                          borderRadius: 5.borderRadius,
                          splashColor: AppColor.lightBlue,
                          highlightColor: AppColor.lightBlue,
                          onTap: () {},
                          child: Container(
                            padding: 5.horizontalPadding,
                            height: 30,
                            decoration: BoxDecoration(
                              color: AppColor.lightGreen,
                              borderRadius: 5.borderRadius,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                5.width,
                                Text(
                                  "view all",
                                  style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w400),
                                ),
                                5.width,
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    GridView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: homeController.growBusinessList.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 4,
                              crossAxisSpacing: 5,
                              childAspectRatio: 80 / 100,
                              mainAxisSpacing: 10),
                      itemBuilder: (context, index) {
                        var currentItem = homeController.growBusinessList[index];
                        return InkWell(
                          borderRadius: 8.borderRadius,
                          splashColor: AppColor.lightBlue,
                          highlightColor: AppColor.lightBlue,
                          onTap: currentItem.onTap,
                          child: Container(
                            padding: 4.allPadding,
                            decoration: BoxDecoration(
                                borderRadius: 8.borderRadius,
                                border: Border.all(
                                    width: 1,
                                    style: BorderStyle.solid,
                                    color: AppColor.lightBlue)),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(
                                  width: 50,
                                  height: 50,
                                  decoration: BoxDecoration(
                                      color: AppColor.randomColor.first,
                                      borderRadius: 5.borderRadius),
                                  child: Center(
                                    child: Icon(
                                      currentItem.icon,
                                      color: AppColor.white,
                                    ),
                                  ),
                                ),
                                Text(
                                  currentItem.title,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(fontSize: 13),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


Future<void> _signOut(context) async {
  try {
    await FirebaseAuth.instance.signOut();
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => PhoneAuthScreen(),));
  } catch (e) {
    print("Error signing out: $e");
  }
}