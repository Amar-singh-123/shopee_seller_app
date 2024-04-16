import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shopee_seller_app/views/utils/app_extensions/app_extensions.dart';
import '../../../controllers/profile/profile_controller.dart';
import '../../utils/app_widgets/buttons/default_button.dart';
import '../../utils/app_widgets/images/image_picker_widget.dart';
import '../../utils/app_widgets/textfield/default_edit_field.dart';

class ManageProfileScreen extends StatelessWidget {
  ManageProfileScreen({super.key});
  var controller = Get.put(ProfileController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Obx(() => Text(controller.manageProfileAppBarText))),
      body: Obx(
        ()=> Column(
          children: [
            Expanded(child: ListView(
              children: [
                20.height,
                Row(
                  children: [
                    16.width,
                    ImagePickerWidget(imagePath:controller.profileImage.value,onTap: controller.pickProfile,isNetworkImage:controller.isNetworkUrl.value),
                  ],
                ),
                20.height,
                EditField(
                  controller: controller.nameController.value,
                  labelText: "Name",
                  hint: "Enter your name",
                ),
                20.height,

                EditField(
                  controller: controller.emailController.value,
                  labelText: "Email",
                  hint: "Enter your email",
                ),
                20.height,

                EditField(
                  controller: controller.addressController.value,
                  labelText: "Address",
                  hint: "Enter your address",
                ),
                20.height,

                EditField(
                  controller: controller.phoneController.value,
                  labelText: "phone",
                  hint: "Enter your phone",
                ),
                20.height,

                EditField(
                  controller: controller.pinCodeController.value,
                  labelText: "pinCode",
                  hint: "Enter your pinCode",
                ),
                20.height,

              ],
            )),
            Button(
              onPressed: controller.verifyProfile,
              text: controller.manageProfileBtnText,
              isActive: false,
            ),
          ],
        ),
      ),
    );
  }
}
