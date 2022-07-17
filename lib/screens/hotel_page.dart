import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travel_go/controller/hotel_controller.dart';

import '../widgets/drawer.dart';

class HotelPage extends StatelessWidget {
  const HotelPage({Key? key}) : super(key: key);
  static const String id = "hotel-screen";

  @override
  Widget build(BuildContext context) {
    final data = MediaQuery.of(context);
    return Scaffold(
        appBar: AppBar(
          title: const Text('Hotels'),
          backgroundColor: Colors.deepPurple[900],
        ),
        //bottomNavigationBar: const BottomNavigation(),
        drawer: AppDrawer(),
        body: GetX<HotelController>(
          init: HotelController(),
          autoRemove: false,
          builder: (logic) {
            return logic.loading.value
                ? SizedBox(
                    height: data.size.height,
                    width: data.size.width,
                    child: Stack(children: [
                      logic.hotels.isEmpty
                          ? const Center(
                              child: Text('No hotels founded'),
                            )
                          : ListView.builder(
                              itemCount: logic.hotels.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Card(
                                    elevation: 5,
                                    margin: const EdgeInsets.all(10),
                                    child: ListTile(
                                      title:
                                          Text('${logic.hotels[index].name}'),
                                      leading: CircleAvatar(
                                        child: Text('${index + 1}',
                                            style: const TextStyle(
                                                color: Colors.white)),
                                        backgroundColor: Colors.amber.shade700,
                                      ),
                                      subtitle: Text(
                                          'name: ${logic.hotels[index].name}'
                                          'about: ${logic.hotels[index].about}'),
                                      trailing: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          // IconButton(onPressed: () {}, icon: const Icon(Icons.edit)),
                                          IconButton(
                                            onPressed: () {
                                              logic.deleteHotel(
                                                  logic.hotels[index].id!);
                                            },
                                            icon: const Icon(Icons.delete),
                                            color: Colors.red,
                                          ),
                                        ],
                                      ),
                                    ));
                              },
                            ),
                      Padding(
                        padding: EdgeInsets.only(
                            top: data.size.height / 1.3,
                            left: data.size.width / 3,
                            right: data.size.width / 3),
                        child: MaterialButton(
                          onPressed: () {
                            logic.addHotel(context);
                          },
                          child: const Text("Add Hotel"),
                          minWidth: double.infinity,
                          // padding: EdgeInsets.only(left: data.size.width /2 ,right: data.size.width),
                          height: 52,
                          elevation: 24,
                          color: Colors.amber.shade700,
                          textColor: Colors.black,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(32)),
                        ),
                      ),
                    ]),
                  )
                : SizedBox(
                    height: data.size.height,
                    width: data.size.width,
                    child: const Center(
                      child: CircularProgressIndicator(),
                    ));
          },
        ));
  }
}
