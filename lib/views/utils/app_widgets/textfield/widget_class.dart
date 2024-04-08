import 'package:flutter/material.dart';

class TextcustomField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final TextInputType keyboardType;
  final Function()? onTap;
  final bool? readOnly;

  const TextcustomField(
      {Key? key,
        required this.controller,
        required this.labelText,
        this.onTap,
        this.readOnly,
        required this.keyboardType})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10),
      child: TextFormField(
        onTap: onTap,
        readOnly: readOnly ?? false,
        controller: controller,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          labelText: labelText,
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.amber),
          ),
        ),
      ),
    );
  }
}