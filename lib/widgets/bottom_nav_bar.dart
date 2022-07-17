import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travel_go/screens/arch_page.dart';
import 'package:travel_go/screens/bank_page.dart';
import 'package:travel_go/screens/home_page.dart';
import 'package:travel_go/screens/hotel_page.dart';
import 'package:travel_go/screens/rest_screen.dart';
import 'package:travel_go/screens/tourist_page.dart';

import '../screens/museum_page.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({Key? key}) : super(key: key);

  @override
  _BottomNavigationTravelkuyState createState() =>
      _BottomNavigationTravelkuyState();
}

class _BottomNavigationTravelkuyState extends State<BottomNavigation> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    _selectedIndex = index;
    if (index == 0) {
      Get.to(() => HomePage());
    } else if (index == 1) {
      Get.to(() => ArchPage());
    } else if (index == 2) {
      Get.to(() => BankPage());
    } else if (index == 3) {
      Get.to(() => RestaurantPage());
    } else if (index == 4) {
      Get.to(() => TouristPage());
    } else if (index == 5) {
      Get.to(() => HotelPage());
    } else if (index == 6) {
      Get.to(() => MuseumPage());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        color: Colors.deepPurple[900],
        boxShadow: [
          BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 6,
              blurRadius: 15,
              offset: const Offset(0, 5))
        ],
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      child: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.tour),
            label: 'Arch ',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.food_bank),
            label: 'Banks',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.restaurant),
            label: 'Restaurants',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.tour),
            label: 'Tourist Area',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.hotel_outlined),
            label: 'Hotels',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.transparent,
        onTap: _onItemTapped,
        backgroundColor: Colors.transparent,
        type: BottomNavigationBarType.fixed,
        selectedFontSize: 12,
        showUnselectedLabels: true,
        elevation: 0,
      ),
    );
  }
}
