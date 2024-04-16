import 'package:get/get.dart';

showSnackBar(String title, {String? body}) {
  Get.snackbar(
    title,
    body ?? "",
    borderRadius: 10,
    animationDuration: const Duration(seconds: 3)
  );
}
