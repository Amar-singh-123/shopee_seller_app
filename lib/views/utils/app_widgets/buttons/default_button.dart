import 'package:flutter/material.dart';
import 'package:shopee_seller_app/views/utils/app_extensions/app_extensions.dart';

import '../../app_colors/app_colors.dart';

class Button extends StatelessWidget {
  const Button({
    super.key,
    required this.onPressed,
    required this.text,
    this.bgColor,
    this.size,
    required this.isActive,
  });

  final void Function()? onPressed;
  final String text;
  final Color? bgColor;
  final Size? size;
final bool isActive;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: bgColor == null && isActive ? AppColor.activeColor :AppColor.inActiveColor ,
            fixedSize: size ?? Size(context.screenWidth*0.9, 50),
            shape: 8.shapeBorderRadius,
            elevation: 0,
          ),
          child: Text(text,style: const TextStyle(color: Colors.white,fontSize: 16),),
        ),
      ),
    );
  }
}
