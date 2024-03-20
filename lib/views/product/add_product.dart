import 'package:flutter/material.dart';

class AddProduct extends StatefulWidget {
  const AddProduct({super.key});

  @override
  State<AddProduct> createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        leading: Icon(Icons.arrow_back_outlined),
        title: Text("Add product"),
      ),
      body: Expanded(
        child: ListView(
          children: [
            Container(
              height: 200,
              width: 200,
              color: Colors.blue,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  Container(
                    height: 100,
                    width: 100,
                    color: Colors.red,
                  ),
                  SizedBox(
                    width: 5,
                  ),
                  Container(
                    height: 100,
                    width: 100,
                    color: Colors.red,
                  ),
                  Container(
                    height: 100,
                    width: 100,
                    color: Colors.red,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
