import 'dart:io';
import 'package:flutter/material.dart';
import 'package:shopee_seller_app/views/utils/app_colors/app_colors.dart';

extension Spaces on int {
  Radius get radius => Radius.circular(toDouble());

  EdgeInsets get horizontalPadding =>
      EdgeInsets.symmetric(horizontal: toDouble());

  EdgeInsets get allPadding => EdgeInsets.all(toDouble());

  EdgeInsets get verticalPadding =>
      EdgeInsets.symmetric(horizontal: toDouble());

  BorderRadius get borderRadius => BorderRadius.circular(toDouble());


  RoundedRectangleBorder get shapeBorderRadius =>
      RoundedRectangleBorder(borderRadius: borderRadius);

  SizedBox get height => SizedBox(
        height: toDouble(),
      );
  SizedBox get square => SizedBox(
        height: toDouble(),
        width: toDouble(),
      );

  SizedBox get width => SizedBox(
        width: toDouble(),
      );
}

extension Responsive on BuildContext {

  double get screenWidth => MediaQuery.sizeOf(this).width;

  double get screenHeight => MediaQuery.sizeOf(this).height;

  Size get deviceSize => MediaQuery.of(this).size;

  Orientation get deviceOrientation => MediaQuery.of(this).orientation;

  void push(Widget screen) {
    Navigator.push(
        this,
        MaterialPageRoute(
          builder: (context) => screen,
        ));
  }

  void pushReplace(Widget screen) {
    Navigator.pushReplacement(
        this,
        MaterialPageRoute(
          builder: (context) => screen,
        ));
  }

  void get pop {
    Navigator.pop(this);
  }
}

extension CustomWidgets on StatelessWidget {
  CircularProgressIndicator get progressIndicator => CircularProgressIndicator(
        backgroundColor: AppColor.blueAccent,
        color: AppColor.darkGray,
      );
  // showSnackBar({required String title, required String message, Color? color}) {
  //   Get.showSnackbar(GetSnackBar(
  //     title: title,
  //     borderRadius: 10,
  //     backgroundColor: color ?? AppColor.blueAccent,
  //     margin: const EdgeInsets.symmetric(horizontal: 20),
  //     message: message,
  //     snackPosition: SnackPosition.TOP,
  //     dismissDirection: DismissDirection.up,
  //   ));
  // }

  Text textView({required String text, TextStyle? textStyle}) {
    return Text(
      text,
      style: textStyle ?? TextStyle(color: AppColor.white),
    );
  }

  Widget assetImage(
          {required String path,
          double? scale,
          double? height,
          double? width,
          BoxFit? fit}) =>
      Image.asset(
        path,
        scale: scale ?? 1,
        height: height,
        width: width,
        fit: fit ?? BoxFit.cover,
      );

  Widget networkImage(
          {required String path,
          double? scale,
          double? height,
          double? width,
          BoxFit? fit}) =>
      Image.network(
        path,
        scale: scale ?? 1,
        height: height,
        width: width,
        fit: fit ?? BoxFit.cover,
      );

  Widget fileImage(
          {required File file,
          double? scale,
          double? height,
          double? width,
          BoxFit? fit}) =>
      Image.file(
        file,
        scale: scale ?? 1,
        height: height,
        width: width,
        fit: fit ?? BoxFit.cover,
      );
}

extension CWidgets on StatefulWidget {
  CircularProgressIndicator get progressIndicator => CircularProgressIndicator(
        backgroundColor: AppColor.white,
      );

  // showSnackBar({required String title, required String message, Color? color}) {
  //   Get.showSnackbar(GetSnackBar(
  //     title: title,
  //     borderRadius: 10,
  //     backgroundColor: color ?? AppColor.blueAccent,
  //     margin: const EdgeInsets.symmetric(horizontal: 20),
  //     message: message,
  //     snackPosition: SnackPosition.TOP,
  //     dismissDirection: DismissDirection.up,
  //   ));
  // }

  Text textView({required String text, TextStyle? textStyle}) {
    return Text(
      text,
      style: textStyle ?? TextStyle(color: AppColor.white),
    );
  }

  Widget assetImage(
          {required String path,
          double? scale,
          double? height,
          double? width,
          BoxFit? fit}) =>
      Image.asset(
        path,
        scale: scale ?? 1,
        height: height,
        width: width,
        fit: fit ?? BoxFit.cover,
      );

  Widget networkImage(
          {required String path,
          double? scale,
          double? height,
          double? width,
          BoxFit? fit}) =>
      Image.network(
        path,
        scale: scale ?? 1,
        height: height,
        width: width,
        fit: fit ?? BoxFit.cover,
      );

  Widget fileImage(
          {required File file,
          double? scale,
          double? height,
          double? width,
          BoxFit? fit}) =>
      Image.file(
        file,
        scale: scale ?? 1,
        height: height,
        width: width,
        fit: fit ?? BoxFit.cover,
      );
}

extension CsWidgets on State {
  CircularProgressIndicator get progressIndicator => CircularProgressIndicator(
        backgroundColor: AppColor.white,
      );
  // showSnackBar({required String title, required String message, Color? color}) {
  //   Get.showSnackbar(GetSnackBar(
  //     title: title,
  //     borderRadius: 10,
  //     backgroundColor: AppColor.soft,
  //     margin: const EdgeInsets.symmetric(horizontal: 20),
  //     message: message,
  //     isDismissible: true,
  //     barBlur: 20,
  //     duration: const Duration(seconds: 4),
  //     snackStyle: SnackStyle.FLOATING,
  //     snackPosition: SnackPosition.TOP,
  //     dismissDirection: DismissDirection.up,
  //   ));
  // }
  Text textView({required String text, TextStyle? textStyle}) {
    return Text(
      text,
      style: textStyle ?? TextStyle(color: AppColor.white),
    );
  }

  Widget assetImage(
          {required String path,
          double? scale,
          double? height,
          double? width,
          BoxFit? fit}) =>
      Image.asset(
        path,
        scale: scale ?? 1,
        height: height,
        width: width,
        fit: fit ?? BoxFit.cover,
      );

  Widget networkImage(
          {required String path,
          double? scale,
          double? height,
          double? width,
          BoxFit? fit}) =>
      Image.network(
        path,
        scale: scale ?? 1,
        height: height,
        width: width,
        fit: fit ?? BoxFit.cover,
      );

  Widget fileImage(
          {required File file,
          double? scale,
          double? height,
          double? width,
          BoxFit? fit}) =>
      Image.file(
        file,
        scale: scale ?? 1,
        height: height,
        width: width,
        fit: fit ?? BoxFit.cover,
      );
}

extension Dates on DateTime {
  String get formateDate {
    return "$day-$month-$year";
  }
}

extension Ext on String{
int   toInt() =>int.parse(this);
}


