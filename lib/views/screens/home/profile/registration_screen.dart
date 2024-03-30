import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shopee_seller_app/controllers/app_controller.dart';
import 'package:shopee_seller_app/views/utils/app_extensions/app_extensions.dart';
import '../../../../models/profile_model.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({super.key});
  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController genderController = TextEditingController();

  File? pickedImage;
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registrations'),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView(
          children: [
            Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () {
                      showAlertBox();
                    },
                    child: pickedImage != null
                        ? CircleAvatar(
                            radius: 70,
                            backgroundImage: FileImage(pickedImage!),
                          )
                        : const CircleAvatar(
                            radius: 70,
                            child: Icon(Icons.person, size: 80),
                          ),
                  ),
                  10.height,
                  TextFormField(
                    controller: nameController,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.person),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                      hintText: 'Enter your name',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Enter your name';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.text,
                  ),
                  10.height,
                  TextFormField(
                    controller: emailController,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.email),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                      hintText: 'Enter your email',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Enter your email';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.text,
                  ),
                  10.height,
                  TextFormField(
                    controller: addressController,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.location_on),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                      hintText: 'Enter your address',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Enter your address';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.text,
                  ),
                  10.height,
                  TextFormField(
                    controller: ageController,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.calendar_today_outlined),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                      hintText: 'Enter your Age',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Enter your Age';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.number,
                  ),
                  10.height,
                  TextFormField(
                    controller: genderController,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.transgender),
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                      hintText: 'Enter your Gender',
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Enter your Gender';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.text,
                  ),
                  const SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      height: 50,
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            setState(() {
                              _isLoading = true;
                            });
                            ProfileModel userDetails = ProfileModel(
                              name: nameController.text,
                              email: emailController.text,
                              address: addressController.text,
                              age: int.parse(ageController.text),
                              gender: genderController.text,
                              imageUrl:
                                  pickedImage != null ? pickedImage!.path : '',
                            );

                            AppController(context: context)
                                .upload(userDetails)
                                .then((_) {
                              // Data upload completed
                              setState(() {
                                _isLoading = false; // Set loading state to false
                              });
                            });
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                        ),
                        child: _isLoading
                            ? const SizedBox(
                                width: 20,
                                height: 20,
                                child: CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                      Colors.white),
                                ),
                              )
                            : const Text("Submit"),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  pickImage(ImageSource imageSource) async {
    try {
      final photo = await ImagePicker().pickImage(source: imageSource);
      if (photo == null) return;
      final tempImage = File(photo.path);
      setState(() {
        pickedImage = tempImage;
      });
    } catch (ex) {
      print(ex.toString());
    }
  }

  showAlertBox() {
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
                  pickImage(ImageSource.camera);
                  Navigator.pop(context);
                },
                leading: const Icon(Icons.camera_alt),
                title: const Text("Camera"),
              ),
              ListTile(
                onTap: () {
                  pickImage(ImageSource.gallery);
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
}
