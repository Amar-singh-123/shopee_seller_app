import 'package:flutter/material.dart';
import 'package:shopee_seller_app/views/utils/app_extensions/app_extensions.dart';

class SearchScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight + 2), // Adjust the height as needed
        child: AppBar(
          elevation: 4, // Add elevation for the elevated effect
          title: TextFormField(
            decoration: const InputDecoration(
              hintText: 'Enter Order Number, Customer Name, Mobile',
              border: InputBorder.none,
              focusedBorder: InputBorder.none,
              hintStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.w400),
            ),
            cursorColor: Color(0xff2041a9),
          ),
          backgroundColor: Colors.white,
        ),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/cards.png', width: context.screenWidth*0.48,),
            const Text('No orders in the section.', style: TextStyle(fontSize: 13, color: Colors.black45),),
            SizedBox(height: context.screenHeight*0.2,)
          ],
        ),
      ),
    );
  }
}