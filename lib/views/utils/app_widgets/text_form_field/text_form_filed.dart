import 'package:flutter/material.dart';

class TextFormFieldWidget extends StatelessWidget {
  const TextFormFieldWidget({
    Key? key,
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
    required this.textInputAction,
    this.onSaved,
    required this.obscureText,
  }) : super(key: key);

  final Function()? onTap;
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final String? labelText;
  final Widget? prefixIcon;
  final bool? enabled;
  final Color? cursorColor;
  final Widget? suffixIcon;
  final int? maxLength;
  final TextInputAction? textInputAction;
  final void Function(String?)? onSaved;
  final bool obscureText;

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
      decoration: InputDecoration(
        labelText: labelText,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        errorStyle: const TextStyle(fontSize: 13.0),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    );
  }
}
