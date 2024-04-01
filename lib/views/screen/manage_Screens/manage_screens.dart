import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ManageScreen extends StatelessWidget {
  const ManageScreen({super.key});

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 10,
        backgroundColor: Colors.white,
        title: Text(
          "Manage",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
      ),
      body: ListView(
        children: const <Widget>[
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Account'),
            subtitle: Text('Online Store Settings'),
            trailing: Icon(Icons.arrow_forward_ios, size: 13),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.color_lens),
            title: Text('Profile'),
            subtitle: Text('Set invoice color, prefix & format'),
            trailing: Icon(
              Icons.arrow_forward_ios,
              size: 13,
            ),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.apps),
            title: Text('Setting'),
            subtitle: Text('Unlock free & premium tools'),
            trailing: Icon(Icons.arrow_forward_ios, size: 13),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.android),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Order'),
                Icon(
                  CupertinoIcons.heart_fill,
                  size: 15,
                  color: Colors.red,
                ),
              ],
            ),
            subtitle: Text('Get store Android App & publish'),
            trailing: Icon(Icons.arrow_forward_ios, size: 13),
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.share),
            title: Text('Promote Shoopy & Earn'),
            subtitle: Text('Promote and unlock more features & reports'),
            trailing: Icon(Icons.arrow_forward_ios, size: 13),
          ),
          Divider(),
          SizedBox(
            height: 5,
          ),
          ListTile(
            title: Text('Profile Details'),
            subtitle: Text('Set name,phone number,languages & email '),
            trailing: Icon(Icons.arrow_forward_ios, size: 13),
          ),
          Divider(),
          ListTile(
            title: Text('Shoopy for pc'),
            subtitle: Text('Use shoopy from your laptop & desktop'),
            trailing: Icon(Icons.arrow_forward_ios, size: 13),
          ),
          Divider(),
          ListTile(
            title: Text('QR Code'),
            subtitle: Text('Download QR Code'),
            trailing: Icon(Icons.arrow_forward_ios, size: 13),
          ),
          Divider(),
          ListTile(
            title: Text('About Us'),
            subtitle: Text('About Us,App Version and other information'),
            trailing: Icon(Icons.arrow_forward_ios, size: 13),
          ),
          SizedBox(
            height: 10,
          ),
          Center(
              child: Text(
                "Logout",
                style: TextStyle(color: Colors.blue),
              )),
          SizedBox(
            height: 15,
          )
        ],
      ),
    );
  }
}
