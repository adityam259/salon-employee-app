import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          ListTile(
            title: Text('Home'),
            onTap: () {
              Navigator.pushNamedAndRemoveUntil(
                context,
                '/dashboard',
                (route) => false,
              );
              // Handle menu item 1 tap
            },
          ),
          ListTile(
            title: Text('Order History'),
            onTap: () {
              Navigator.pushNamedAndRemoveUntil(
                context,
                '/orderHistory',
                (route) => false,
              );
              // Handle menu item 1 tap
            },
          ),
          ListTile(
            title: Text('On-Going / Pending Orders'),
            onTap: () {
              Navigator.pushNamedAndRemoveUntil(
                context,
                '/ongoingOrders',
                (route) => false,
              );
              // Handle menu item 2 tap
            },
          ),
          ListTile(
            title: Text('Logout'),
            onTap: () {
              Navigator.pushNamedAndRemoveUntil(
                context,
                '/logout',
                (route) => false,
              );
              // Handle menu item 2 tap
            },
          )
          // Add more ListTile widgets for additional menu items
        ],
      ),
    );
  }
}
