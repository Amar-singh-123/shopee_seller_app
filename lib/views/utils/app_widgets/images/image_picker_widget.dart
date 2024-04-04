import 'dart:io';

import 'package:flutter/material.dart';

import 'package:shopee_seller_app/views/utils/app_extensions/app_extensions.dart';

import '../../app_colors/app_colors.dart';

class ImagePickerWidget extends StatelessWidget {
  const ImagePickerWidget({
    super.key,
    required this.imagePath,
    this.onTap,
    required this.isNetworkImage,
  });
  final String imagePath;
  final void Function()? onTap;
  final bool isNetworkImage;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: 16.allPadding,
      child: InkWell(
        borderRadius: 10.borderRadius,
        onTap: onTap,
        child: Container(
          constraints: const BoxConstraints(minWidth: 100, minHeight: 100),
          decoration: BoxDecoration(
              borderRadius: 10.borderRadius,
              border: imagePath.isEmpty
                  ? Border.all(
                      color: AppColor.gray, width: 1, style: BorderStyle.solid)
                  : null),
          child: Center(
            child: imagePath.isNotEmpty
                ? ClipRRect(
                    borderRadius: 10.borderRadius,
                    child: isNetworkImage
                        ? Image.network(
                             imagePath,
                            width: 100,
                            height: 100,
                            fit: BoxFit.cover,
                          )
                        : Image.file(
                            File(imagePath),
                            fit: BoxFit.cover,
                            width: 100,
                            height: 100,
                          ),
                  )
                : Column(
                    children: [
                      Icon(
                        Icons.add_a_photo_outlined,
                        color: AppColor.blueAccent,
                        size: 40,
                      ),
                      Text(
                        "add photo",
                        style: TextStyle(color: AppColor.blueAccent),
                      )
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}
