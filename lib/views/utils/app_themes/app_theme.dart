import 'package:flutter/material.dart';
import 'package:shopee_seller_app/views/utils/app_colors/app_colors.dart';

class AppTheme {
  static ThemeData dayTheme = ThemeData(
    colorScheme: ColorScheme.light(onPrimary: AppColor.white),
    scaffoldBackgroundColor: AppColor.dark,
    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(backgroundColor: AppColor.blueAccent)),
    textTheme:  const TextTheme().copyWith(bodyLarge: TextStyle(color: AppColor.white),bodyMedium:TextStyle( color: AppColor.white) )
  );
}
