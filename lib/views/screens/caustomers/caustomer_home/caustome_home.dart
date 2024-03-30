import 'package:flutter/material.dart';
import 'package:shopee_seller_app/views/utils/app_extensions/app_extensions.dart';

import 'caustomer_form.dart';

class Caustomer_Home extends StatefulWidget {
  const Caustomer_Home({Key? key}) : super(key: key);

  @override
  State<Caustomer_Home> createState() => _Caustomer_HomeState();
}

bool _switchValue = true;

class _Caustomer_HomeState extends State<Caustomer_Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Customers"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            // Add back arrow functionality here
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              // Add search icon functionality here
            },
          ),
          IconButton(
            icon: Icon(Icons.menu),
            onPressed: () {
              // Add menu icon functionality here
            },
          ),
          IconButton(
            icon: Icon(Icons.more_vert),
            onPressed: () {
              // Add right arrow icon functionality here
            },
          ),
        ],
        bottom: PreferredSize(
          preferredSize: Size(context.screenWidth, 50),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(onPressed: () {}, child: Text("Due")),
                  ElevatedButton(onPressed: () {}, child: Text("Advance")),
                  Text("Address Book"),
                  Switch(
                    value: _switchValue,
                    onChanged: (bool value) {
                      setState(() {
                        _switchValue = value;
                      });
                    },
                  )
                ],
              )
            ],
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: 100, // Example item count
              itemBuilder: (context, index) {
                return ListTile(
                  // leading: Card(
                  //   elevation: 4, // Controls the size of the shadow below the card
                  //   shape: RoundedRectangleBorder(
                  //     borderRadius: BorderRadius.circular(12.0), // Controls the roundness of the card corners
                  //   ),
                  //     child: Text("K",style: TextStyle(backgroundColor: Colors.redAccent,fontSize: 20),),
                  //   // shape: OutlineInputBorder(),
                  // ),
                   leading:  Card(
                      elevation: 4, // Shadow effect
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0), // Rounded corners
                      ),
                      margin: EdgeInsets.all(8), // Margin around the card
                      child: Container(
                        width: 50, // Manually set width
                        height: 170, // Manually set height
                        padding: EdgeInsets.all(16), // Padding inside the card
                      ),
                     
                    ),

                    title: Text('pawan kuamrs $index'),
                  subtitle: Text("955146444 $index"),
                  trailing: Icon(Icons.account_circle_rounded),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // Add functionality for the floating action button here
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => Customer_form(),
              ));
        },
        backgroundColor: Colors.blue,
        icon: Icon(
          Icons.person_add,
          color: Colors.white,
        ),
        label: Text("Caustomer", style: TextStyle(color: Colors.white)),
      ),
    );
  }
}
