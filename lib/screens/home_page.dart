// import 'package:flutter/material.dart';
// import 'package:flutter_admin_scaffold/admin_scaffold.dart';
// import 'package:get/get.dart';
// import 'package:travel_go/screens/bank_page.dart';
// import 'package:travel_go/screens/change_password.dart';
// import 'package:travel_go/screens/hotel_page.dart';
// import 'package:travel_go/screens/museum_page.dart';
// import 'package:travel_go/screens/rest_screen.dart';
// import 'package:travel_go/screens/tourist_page.dart';
//
// import '../controller/auth_controller.dart';
//
// class HomePage extends StatefulWidget {
//   const HomePage({Key? key}) : super(key: key);
//
//   @override
//   State<HomePage> createState() => _HomePageState();
// }
//
// class _HomePageState extends State<HomePage> {
//   Widget _selectedScreen = const BankPage();
//   final AuthController controller = Get.put(AuthController());
//
//   currentScreen(item) {
//     switch (item.route) {
//       case BankPage.id:
//         setState(() {
//           _selectedScreen = const BankPage();
//         });
//         break;
//       case HotelPage.id:
//         setState(() {
//           _selectedScreen = const HotelPage();
//         });
//         break;
//       case RestaurantPage.id:
//         setState(() {
//           _selectedScreen = const RestaurantPage();
//         });
//         break;
//
//       case TouristPage.id:
//         setState(() {
//           _selectedScreen = const RestaurantPage();
//         });
//         break;
//
//       case MuseumPage.id:
//         setState(() {
//           _selectedScreen = const RestaurantPage();
//         });
//         break;
//
//       case ChangePassword.id:
//         setState(() {
//           _selectedScreen = const ChangePassword();
//         });
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return AdminScaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         backgroundColor: Colors.amber.shade700,
//         title: const Text('Admin Panel'),
//       ),
//       sideBar: SideBar(
//         textStyle: const TextStyle(color: Colors.white),
//         activeTextStyle: const TextStyle(color: Colors.white),
//         iconColor: Colors.amber.shade700,
//         activeIconColor: Colors.amber.shade700,
//         backgroundColor: Colors.black12,
//         activeBackgroundColor: Colors.black12,
//         items: const [
//           AdminMenuItem(
//             title: 'Bank Page',
//             route: BankPage.id,
//             icon: Icons.room,
//           ),
//           AdminMenuItem(
//             title: 'hotel Page ',
//             route: HotelPage.id,
//             icon: Icons.person,
//           ),
//           AdminMenuItem(
//             title: 'Mueseum Page ',
//             route: MuseumPage.id,
//             icon: Icons.museum,
//           ),
//           AdminMenuItem(
//             title: 'Tourist Page ',
//             route: TouristPage.id,
//             icon: Icons.tour,
//           ),
//           AdminMenuItem(
//             title: 'Restaurant Page ',
//             route: RestaurantPage.id,
//             icon: Icons.restaurant,
//           ),
//         ],
//         footer: GestureDetector(
//           onTap: () {
//             controller.signOut();
//           },
//           child: Container(
//             width: double.infinity,
//             alignment: Alignment.topLeft,
//             color: Colors.amber.shade700,
//             child: Row(
//               children: const [
//                 Icon(Icons.logout),
//                 SizedBox(
//                   width: 10,
//                 ),
//                 Text('LogOut'),
//               ],
//             ),
//           ),
//         ),
//         selectedRoute: BankPage.id,
//         onSelected: (item) {
//           currentScreen(item);
//           // if (item.route != null) {
//           //   Navigator.of(context).pushNamed(item.route!);
//           // }
//         },
//       ),
//       body: SingleChildScrollView(child: _selectedScreen),
//     );
//   }
// }
//

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travel_go/controller/arch_controller.dart';
import 'package:travel_go/controller/auth_controller.dart';
import 'package:travel_go/screens/arch_page.dart';
import 'package:travel_go/screens/bank_page.dart';
import 'package:travel_go/screens/hotel_page.dart';
import 'package:travel_go/screens/museum_page.dart';
import 'package:travel_go/screens/rest_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    Get.put(ArchController());
    final data = MediaQuery.of(context);
    final width = data.size.width;
    final height = data.size.height;
    return Scaffold(
      appBar: AppBar(title: Text('Admin Page'), actions: [
        IconButton(
            onPressed: () {
              AuthController auth = AuthController();
              auth.signOut();
            },
            icon: Icon(Icons.logout))
      ]),
      body: Container(
        alignment: Alignment.center,
        margin: EdgeInsets.only(
          top: height / 7,
        ),
        padding: EdgeInsets.only(left: width / 8, right: width / 8),
        child: Center(
          child: GridView.count(
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              crossAxisCount: 2,
              childAspectRatio: .90,
              children: const [
                Card_d(
                  icon: Icon(Icons.person, size: 30, color: Colors.white),
                  title: 'Arch Page',
                  nav: ArchPage(),
                ),
                Card_d(
                  icon: Icon(Icons.person, size: 30, color: Colors.white),
                  title: 'Bank Page',
                  nav: BankPage(),
                ),
                Card_d(
                  icon: Icon(Icons.person, size: 30, color: Colors.white),
                  title: 'Hotel Page',
                  nav: HotelPage(),
                ),
                Card_d(
                  icon: Icon(Icons.person, size: 30, color: Colors.white),
                  title: 'Restaurant Page',
                  nav: RestaurantPage(),
                ),
                Card_d(
                  icon: Icon(Icons.person, size: 30, color: Colors.white),
                  title: 'Museum Page',
                  nav: MuseumPage(),
                ),
              ]),
        ),
      ),
    );
  }
}

class Card_d extends StatefulWidget {
  const Card_d(
      {Key? key, required this.title, required this.icon, required this.nav})
      : super(key: key);
  final String title;
  final dynamic icon;
  final dynamic nav;

  @override
  State<Card_d> createState() => _Card_dState();
}

// ignore: camel_case_types
class _Card_dState extends State<Card_d> {
  void showBar(BuildContext context, String msg) {
    var bar = SnackBar(
      content: Text(msg),
    );
    ScaffoldMessenger.of(context).showSnackBar(bar);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => widget.nav));
      },
      child: Card(
        color: Colors.blueAccent,
        elevation: 2,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        child: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Center(child: widget.icon),
              const SizedBox(
                height: 10,
              ),
              Text(widget.title, style: const TextStyle(color: Colors.white)),
            ],
          ),
        ),
      ),
    );
  }
}
