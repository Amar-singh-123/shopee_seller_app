import 'package:flutter/material.dart';
import 'package:shopee_seller_app/controllers/banner_controller.dart';
import 'package:shopee_seller_app/views/utils/app_extensions/app_extensions.dart';
import '../../../../screens/shopee_ui/store_banner/edit_screen.dart';

class PopUpMenuButtonWidget extends StatelessWidget {
   PopUpMenuButtonWidget({super.key,required this.id});

  var id;

  @override
  Widget build(BuildContext context) {
    return
      PopupMenuButton<int>(
        iconSize: 30,
      iconColor: Colors.white,
      itemBuilder: (context) => [
        // const PopupMenuItem(
        //   value: 1,
        //   child: Row(
        //     children: [
        //       Icon(Icons.edit),
        //       SizedBox(
        //         width: 10,
        //       ),
        //       Text("Edit")
        //     ],
        //   ),
        // ),
        const PopupMenuItem(
          value: 2,
          child: Row(
            children: [
              Icon(Icons.delete),
              SizedBox(
                width: 10,
              ),
              Text("Delete")
            ],
          ),
        ),
      ],
      offset: const Offset(0, 50),
      color: Colors.grey,
      elevation: 2,
      onSelected: (value) {
        // if (value == 1) {
        //   context.push(UpdateTabBarWidget());
        // }
         if (value == 2) {
          BannerController(context: context).deleteBanner(id: id);
        }
      },
    );
  }
}
