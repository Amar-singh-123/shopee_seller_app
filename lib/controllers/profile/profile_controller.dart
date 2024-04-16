import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shopee_seller_app/views/screens/home/home_screen.dart';
import '../../models/profile/profile_model.dart';
import '../../views/utils/app_widgets/snakebars/default_snake_bar.dart';
import '../services/app_firebase/app_firebase_auth.dart';
import '../services/app_firebase/firestore_db.dart';
import '../services/app_firebase/storage_db.dart';
import '../services/device_services/device_storage.dart';

class ProfileController extends GetxController {
  Rx<TextEditingController> nameController = TextEditingController().obs;
  Rx<TextEditingController> emailController = TextEditingController().obs;
  Rx<TextEditingController> addressController = TextEditingController().obs;
  Rx<ProfileModel> profileDetails = ProfileModel().obs;
  RxString profileImage = "".obs;
  final _profileDb = AppFireStoreDatabase(collection: 'seller_profile');
  final _profileStorage = AppFirebaseStorage(storageCollection: 'seller_profile');

  RxBool updateStatus = false.obs;
  RxBool isNetworkUrl = false.obs;

  String get manageProfileAppBarText {
    return updateStatus.value ? "Manage Your Profile" : "Add Your Profile";
  }

  String get manageProfileBtnText {
    return updateStatus.value ? "Update" : "Add";
  }

  Future<void> uploadProfile() async {
    var resp = await _profileDb.set(
      data: profileDetails.value.toJson(),
      doc: AppAuth.userId ?? "",
    );
    if (resp.success) {
      if (updateStatus.value) {
        showSnackBar('profile updated successful');
        Get.offAll(HomeScreen());
      } else {
        showSnackBar('profile Added successful');
        Get.offAll(HomeScreen());
      }
    }else{
      showSnackBar('profile Added failed:${resp.error}');
    }
  }

  Future<void> verifyProfile() async {
    profileDetails.value = ProfileModel(
      sellerId: AppAuth.userId,
      sellerName: nameController.value.text,
      sellerEmail: emailController.value.text,
      sellerAddress: addressController.value.text,
      sellerPhone: AppAuth.currentUser?.phoneNumber,
      sellerImage: profileImage.value,
    );
    if (profileDetails.value.sellerName?.isEmpty == true) {
      showSnackBar('Please enter your name');
    } else if (profileDetails.value.sellerEmail?.isEmpty == true) {
      showSnackBar(
        'Please enter your email',
      );
    } else if (profileDetails.value.sellerAddress?.isEmpty == true) {
      showSnackBar(
        'Please enter your address',
      );
    } else if (profileImage.value.isEmpty) {
      showSnackBar(
        'Please select profile Image',
      );
    } else {
      if(isNetworkUrl.value == false){
        await uploadImage();
      }
      await uploadProfile();
    }
  }
  pickProfile() async {
    var pickedImage =
    await DeviceService.pickImage(source: ImageSource.gallery);
    if (pickedImage.isNotEmpty) {
      profileImage.value = pickedImage;
      isNetworkUrl.value = false;
    }
  }

  Future<void> uploadImage() async {
    var image = await _profileStorage.insertFile(
        file: File(profileImage.value), filename: '${AppAuth.userId}.jpeg');
    profileImage.value = image.url ?? "";
    profileDetails.value.sellerImage = image.url ?? "";
    isNetworkUrl.value = true;
  }

  @override
  void onInit() {
    getProfileData();
    super.onInit();
  }

  void getProfileData() async {
    _profileDb
        .getOneAsStream(doc: AppAuth.userId ?? "")
        .streamOneData
        ?.listen((event) {
      if (event.data() != null) {
        profileDetails.value = ProfileModel.fromJson(event.data()!);
        assignValue();
      }
    });
  }

  void assignValue() {
    profileImage.value = profileDetails.value.sellerImage ?? "";
    nameController.value.text = profileDetails.value.sellerName ?? "";
    addressController.value.text = profileDetails.value.sellerAddress ?? "";
    emailController.value.text = profileDetails.value.sellerEmail ?? "";
    isNetworkUrl.value = true;
    updateStatus.value = true;
  }
}
