import 'package:flutter/material.dart';
import 'package:shopee_seller_app/views/utils/app_extensions/app_extensions.dart';

import '../../app_colors/app_colors.dart';

class EditField extends StatelessWidget {
  const EditField({
    required this.controller,
    this.onTap,
    this.keyboardType,
    this.maxLength,
    this.enabled,
    super.key,
    this.labelText,
    this.hint,
    this.prefixIcon,
    this.suffixIcon,
    this.onChanged,
  });

  final void Function()? onTap;
  final TextEditingController controller;
  final TextInputType? keyboardType;
  final int? maxLength;
  final bool? enabled;
  final String? labelText;
  final String? hint;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
final void Function(String)? onChanged;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: 13.verticalPadding,
        padding: prefixIcon != null ? 0.allPadding : 16.horizontalPadding,
        constraints: const BoxConstraints(minHeight: 60),
        child: TextFormField(
          controller: controller,
          onTap: onTap,
          onChanged: onChanged,
          keyboardType: keyboardType ?? TextInputType.text,
          maxLength: maxLength,
          enabled: enabled,
          decoration: InputDecoration(
            labelText: labelText,
            border: const OutlineInputBorder(),
            hintText: hint,
            isDense: true,
            hintStyle: TextStyle(
                color: AppColor.activeColor, fontWeight: FontWeight.w400),
            // labelStyle: TextStyle(color:AppColor.gray,fontWeight: FontWeight.w300),
            floatingLabelBehavior: FloatingLabelBehavior.auto,
             floatingLabelStyle: TextStyle(color:AppColor.activeColor),

            prefixIcon: prefixIcon != null
                ? Icon(
                    prefixIcon,
                    size: 25,
                     color:  AppColor.textSoft,
                  )
                : null,
            suffixIcon: suffixIcon != null
                ? Icon(
              suffixIcon,
              size: 25,
            )
                : null,
            enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: AppColor.gray,
                  width: 0.8,
                  style: BorderStyle.solid,
                )),
            focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: AppColor.activeColor,
                  width: 1.6,
                  style: BorderStyle.solid,
                )),
          ),
        ),
      ),
    );
  }
}
