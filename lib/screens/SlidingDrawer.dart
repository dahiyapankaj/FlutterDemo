import 'package:flutter/material.dart';

class SlidingDrawer extends StatelessWidget {
  String name;
  SlidingDrawer(this.name);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: Text(name),
            accountEmail: Text("$name@nagarro.com"),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.deepOrange,
              child: Text(
                "P",
                style: TextStyle(fontSize: 40.0, color: Colors.white),

              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.home), title: Text("Home"),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: Icon(Icons.settings), title: Text("Settings"),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: Icon(Icons.contacts), title: Text("Contact Us"),
            onTap: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}

