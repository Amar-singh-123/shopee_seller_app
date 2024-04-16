

import 'package:flutter/material.dart';

class AppColor{
  static Color transparent =  Colors.transparent;
  static Color dark = const Color(0xff1F1D2B);
  static Color soft = const Color(0xff252836);
  static Color blueAccent =const Color(0xffa3b7ff);
  static Color green =const Color(0xff24c676);
  static Color darkGreen =const Color(0xff116359);
  static Color darkPurple =const Color(0xff6d4085);
  static Color orange =const Color(0xfff67430);
  // static Color red =const Color(0xffFF7256);
  static Color red = Colors.red;
  static Color black =const Color(0xff171725);
  static Color darkGray =const Color(0xff696974);
  static Color gray =const Color(0xff999999);
  static Color white =const Color(0xffFFFFFF);
  static Color screenBg = const Color(0xfff2f2f2);
  static Color whiteGray =const Color(0xffF1F1F5);
  static Color lineDark =const Color(0xffEAEAEA);
  static Color deepPurple =Colors.deepPurpleAccent;
  // static Color lineDark =const Color(0xffe7e7e7);
  static Color bluesGray =const Color(0xff9FACDC);
  // static Color shadowColor =const Color(0xff9FACDC);
  static Color shadowColor =const Color(0xff8CB9BD);
  static Color lightBlue =const Color(0xffe8ebfc);
  static Color lightOrange =const Color(0xffffeeda);
  static Color lightRed =const Color(0xfffde6ea);
  static Color lightGreen =const Color(0xffe8f7f0);
  static Color lightPurple =const Color(0xfff0ebf2);
  static Color bgSoft =const Color(0xfff3f6fd);
  static Color orangeBtn =const Color(0xffffeded);
  static Color grayBtn =const Color(0xffdee1f4);
  static Color inActiveColor =const Color(0xff5f79cf);
  static Color activeColor =const Color(0xff1641db);
  static Color textSoft =const Color(0xff6b6b6b);
  static Color textLight =const Color(0xff6b6b6b);
  static final List<Color> _colors = [darkGreen,activeColor,darkPurple,orange,red,green,blueAccent];

static List<Color> get randomColor {
  _colors.shuffle();
  _colors.shuffle();
  return _colors;
}
}
