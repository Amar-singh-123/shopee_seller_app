import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class TabBarWidget extends StatefulWidget {
  const TabBarWidget({Key? key}) : super(key: key);

  @override
  _TabBarWidgetState createState() => _TabBarWidgetState();
}

class _TabBarWidgetState extends State<TabBarWidget> {
  File? _image;

  Future<void> _pickImage(ImageSource source) async {
    final pickedImage = await ImagePicker().pickImage(source: source);
    if (pickedImage != null) {
      setState(() {
        _image = File(pickedImage.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Banner', style: TextStyle(fontWeight: FontWeight.bold)),
          backgroundColor: Colors.white,
          elevation: 0,
          bottom: TabBar(
            unselectedLabelColor: Colors.pink,
            indicatorSize: TabBarIndicatorSize.label,
            indicator: BoxDecoration(
              borderRadius: BorderRadius.circular(50),
              color: Colors.white,
            ),
            tabs: [
              Tab(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    border: Border.all(color: Colors.red, width: 1),
                  ),
                  child: Align(
                    alignment: Alignment.center,
                    child: Text('Mobile'),
                  ),
                ),
              ),
              Tab(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    border: Border.all(color: Colors.yellow, width: 1),
                  ),
                  child: Align(
                    alignment: Alignment.center,
                    child: Text('Desktop'),
                  ),
                ),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            Center(
              child: InkWell(
                onTap: () {
                  _bottomSheet();
                },
                child: _image == null ? Text("No Image Selected") : Image.file(_image!),
              ),
            ),
            Center(
              child: InkWell(
                onTap: () {
                  _bottomSheet();
                },
                child: Expanded(

                  child: _image == null ? Text("No Image Selected") : Image.file(_image!),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _bottomSheet() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              onTap: () => _pickImage(ImageSource.camera),
              leading: Icon(Icons.camera_alt_outlined),
              title: Text("Camera"),
            ),
            ListTile(
              onTap: () => _pickImage(ImageSource.gallery),
              leading: Icon(Icons.photo_library_outlined),
              title: Text("Gallery"),
            ),
          ],
        );
      },
    );
  }
}
