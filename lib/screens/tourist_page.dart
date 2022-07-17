import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/tourist_controller.dart';

class TouristPage extends StatelessWidget {
  const TouristPage({Key? key}) : super(key: key);
  static const String id = "Tourist-screen";

  @override
  Widget build(BuildContext context) {
    final data = MediaQuery.of(context);
    return GetX<TouristController>(
      init: TouristController(),
      autoRemove: false,
      builder: (logic) {
        return logic.loading.value
            ? SizedBox(
                height: data.size.height,
                width: data.size.width,
                child: Stack(children: [
                  logic.tourist.isEmpty
                      ? const Center(
                          child: Text('No Tourist founded'),
                        )
                      : ListView.builder(
                          itemCount: logic.tourist.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Card(
                                elevation: 5,
                                margin: const EdgeInsets.all(10),
                                child: Column(
                                  children: [
                                    ListTile(
                                      title: Text(
                                          '${logic.tourist[index].name} Tourist'),
                                      leading: CircleAvatar(
                                        child: Text(
                                          '${index + 1}',
                                          style: const TextStyle(
                                              color: Colors.white),
                                        ),
                                        backgroundColor: Colors.amber.shade700,
                                      ),
                                      subtitle: Column(
                                        children: [
                                          Text(
                                              'Location: ${logic.tourist[index].location} '),
                                          Text(
                                              ' About: ${logic.tourist[index].about}\$'),
                                        ],
                                      ),
                                      trailing: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          IconButton(
                                              onPressed: () {
                                                logic.editTourist(
                                                    logic.tourist[index].id!,
                                                    context,
                                                    logic.tourist[index].name!,
                                                    logic.tourist[index]
                                                        .location!,
                                                    logic
                                                        .tourist[index].about!);
                                              },
                                              icon: const Icon(Icons.edit)),
                                          IconButton(
                                            onPressed: () {
                                              logic.deleteTourist(
                                                  logic.tourist[index].id!);
                                            },
                                            icon: const Icon(Icons.delete),
                                            color: Colors.red,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
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
                        logic.addTourist(context);
                      },
                      child: const Text("Add Tourist"),
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
    );
  }
}
