import 'package:flutter/material.dart';

class TextFormField extends StatelessWidget {
  TextFormField(
      {super.key,
      this.onTap,
      required this.validator,
      required this.controller,
      required this.keyboardType,
      required this.labelText,
      this.prefixIcon,
        this.enabled,
        this.cursorColor,
        this.suffixIcon,
        this.maxLength,
        this.textInputAction,
        this.onSaved,
        this.obscureText,
      });

  Function()? onTap;
  String? Function(String?)? validator;
  TextEditingController? controller;
  TextInputType? keyboardType;

       String? labelText;
      Widget? prefixIcon;
  bool? enabled;
      Color? cursorColor;
  Widget? suffixIcon;
      int? maxLength;
   TextInputAction? textInputAction;
  void Function(String?)? onSaved;
      bool? obscureText = false;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      controller: controller,
      onTap: onTap,
      keyboardType: keyboardType,
      enabled: enabled,
      cursorColor: cursorColor,
      obscureText: obscureText,
      textInputAction: textInputAction,
      onSaved: onSaved,
      maxLength: maxLength,
      labelText: labelText,
      prefixIcon: prefixIcon,
      suffixIcon: suffixIcon,
      // decoration: InputDecoration(
      //     // labelText: labelText,
      //     prefixIcon: prefixIcon,
      //     suffixIcon: suffixIcon,
      //     errorStyle: const TextStyle(fontSize: 13.0),
      //     border: const OutlineInputBorder(
      //         borderSide: BorderSide(color: Colors.red),
      //         borderRadius: BorderRadius.all(Radius.circular(10)))),
    );
  }
}
