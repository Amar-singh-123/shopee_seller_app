import 'package:flutter/material.dart';

class DefaultButton extends StatelessWidget {
  DefaultButton({super.key, required this.text, required this.onPress});

  String text;
  Function() onPress;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(onPressed: onPress, child: Text(text),style:ElevatedButton.styleFrom(
    ),);
  }
}
