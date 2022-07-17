import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:travel_go/screens/arch_page.dart';
import 'package:travel_go/screens/bank_page.dart';
import 'package:travel_go/screens/change_password.dart';
import 'package:travel_go/screens/hotel_page.dart';
import 'package:travel_go/screens/rest_screen.dart';
import 'package:travel_go/screens/tourist_page.dart';

import '../controller/auth_controller.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    AuthController controller = Get.find();
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          _createHeader(),
          _createDrawerItem(
            icon: Icons.home_repair_service,
            text: 'Banks',
            onTap: () {
              Get.to(() => BankPage());
            },
          ),
          _createDrawerItem(
            icon: Icons.accessibility,
            text: 'Restaurant',
            onTap: () {
              Get.to(() => RestaurantPage());
            },
          ),
          _createDrawerItem(
            icon: Icons.monetization_on,
            text: 'Hotel',
            onTap: () {
              Get.to(() => HotelPage());
            },
          ),
          _createDrawerItem(
            icon: Icons.home_repair_service,
            text: 'Tourist Area',
            onTap: () {
              Get.to(() => TouristPage());
            },
          ),
          _createDrawerItem(
            icon: Icons.home_repair_service,
            text: 'Arch Area',
            onTap: () {
              Get.to(() => ArchPage());
            },
          ),
          const Divider(),
          _createDrawerItem(
              icon: Icons.help,
              text: 'Change Password',
              onTap: () {
                Get.to(() => const ChangePassword());
              }),
          _createDrawerItem(
              icon: Icons.help, text: 'About Application', onTap: () {}),
          const Divider(),
          _createDrawerItem(
              icon: Icons.logout,
              text: 'SignOut',
              onTap: () {
                controller.signOut();
              }),
        ],
      ),
    );
  }

  Widget _createHeader() {
    return DrawerHeader(
        decoration: BoxDecoration(
          color: Colors.deepPurple[900],
        ),
        margin: EdgeInsets.zero,
        padding: EdgeInsets.zero,
        child: Column(mainAxisAlignment: MainAxisAlignment.start,
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: const <Widget>[
              Image(
                image: AssetImage('images/logo.png'),
                height: 80,
                width: 80,
              ),
              Text("Suda-Tourist",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                      fontWeight: FontWeight.w500)),
            ]));
  }

  Widget _createDrawerItem(
      {required IconData icon,
      required String text,
      required GestureTapCallback onTap}) {
    return ListTile(
      title: Row(
        children: <Widget>[
          Icon(icon),
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Text(text),
          )
        ],
      ),
      onTap: onTap,
    );
  }
}
