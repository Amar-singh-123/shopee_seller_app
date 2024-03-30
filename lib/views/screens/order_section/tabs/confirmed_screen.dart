import 'package:flutter/material.dart';
import 'package:shopee_seller_app/views/utils/app_extensions/app_extensions.dart';

class ConfirmedScreen extends StatelessWidget {
  const ConfirmedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(constraints: BoxConstraints(maxHeight: 200, maxWidth: 200),child: Image.asset('assets/images/cards.png', width: context.screenWidth*0.48)),
        const Text('No orders in the section.', style: TextStyle(fontSize: 13, color: Colors.black45),),
        SizedBox(height: context.screenHeight*0.2,)
      ],
    );
  }
}
