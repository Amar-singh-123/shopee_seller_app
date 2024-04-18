import 'package:image_picker/image_picker.dart';
class DeviceService{
static Future<String> pickImage({required ImageSource source}) async{
   var pickedImage =await ImagePicker().pickImage(source: source);
   return pickedImage?.path ?? "";
  }
}