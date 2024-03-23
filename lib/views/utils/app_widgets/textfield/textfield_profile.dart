import 'package:flutter/material.dart';

class FormWidget extends StatelessWidget {
  final double? fontSize;
  final int? maxLines;
  final TextEditingController controller;
  final String hintText;
  final FormFieldValidator<String>? validator;
  final InputDecoration decoration;
  final Widget? prefixIcon;

  const FormWidget({
    super.key,
    this.fontSize,
    this.maxLines,
    required this.controller,
    required this.hintText,
    this.validator,
    required this.decoration,
     this.prefixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: maxLines,
      style: TextStyle(fontSize: fontSize),
      controller: controller,
      decoration: decoration.copyWith(
        hintText: hintText,
        border: InputBorder.none,
        prefixIcon: prefixIcon,
      ),
      validator: validator,
    );
  }
}



