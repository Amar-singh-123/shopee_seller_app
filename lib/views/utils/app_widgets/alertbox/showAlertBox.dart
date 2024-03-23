import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Alert extends StatelessWidget {
  const Alert({Key? key}) : super(key: key);

  void showAlertBox(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Pick Image From"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                onTap: () {
                  pickImage(context, ImageSource.camera);
                  Navigator.pop(context);
                },
                leading: const Icon(Icons.camera_alt),
                title: const Text("Camera"),
              ),
              ListTile(
                onTap: () {
                  pickImage(context, ImageSource.gallery);
                  Navigator.pop(context);
                },
                leading: const Icon(Icons.image),
                title: const Text("Gallery"),
              ),
            ],
          ),
        );
      },
    );
  }

  void pickImage(BuildContext context, ImageSource source) async {
    try {
      final pickedImage = await ImagePicker().pickImage(source: source);
      if (pickedImage == null) return;
      // Do something with the picked image
    } catch (ex) {
      print(ex.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // Your UI implementation here
      child: ElevatedButton(
        onPressed: () {
          showAlertBox(context);
        },
        child: Text("Show Alert"),
      ),
    );
  }
}
