import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travel_go/controller/mueseum_controller.dart';

import '../widgets/drawer.dart';

class MuseumPage extends StatelessWidget {
  const MuseumPage({Key? key}) : super(key: key);
  static const String id = "Museum-screen";

  @override
  Widget build(BuildContext context) {
    final data = MediaQuery.of(context);
    return Scaffold(
        appBar: AppBar(
          title: const Text('Museums'),
          backgroundColor: Colors.deepPurple[900],
        ),
        //bottomNavigationBar: const BottomNavigation(),
        drawer: AppDrawer(),
        body: GetX<MuseumController>(
          init: MuseumController(),
          autoRemove: false,
          builder: (logic) {
            return logic.loading.value
                ? SizedBox(
                    height: data.size.height,
                    width: data.size.width,
                    child: Stack(children: [
                      logic.muse.isEmpty
                          ? const Center(
                              child: Text('No Museum founded'),
                            )
                          : ListView.builder(
                              itemCount: logic.muse.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Card(
                                    elevation: 5,
                                    margin: const EdgeInsets.all(10),
                                    child: Column(
                                      children: [
                                        ListTile(
                                          title: Text(
                                              '${logic.muse[index].name} Museum'),
                                          leading: CircleAvatar(
                                            child: Text(
                                              '${index + 1}',
                                              style: const TextStyle(
                                                  color: Colors.white),
                                            ),
                                            backgroundColor:
                                                Colors.amber.shade700,
                                          ),
                                          subtitle: Column(
                                            children: [
                                              Text(
                                                  'Location: ${logic.muse[index].location}'),
                                              Text(
                                                  'About: ${logic.muse[index].about}\$'),
                                            ],
                                          ),
                                          trailing: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              IconButton(
                                                  onPressed: () {
                                                    logic.editMuseum(
                                                        logic.muse[index].id!,
                                                        context,
                                                        logic.muse[index].name!,
                                                        logic.muse[index]
                                                            .location!,
                                                        logic.muse[index]
                                                            .about!);
                                                  },
                                                  icon: const Icon(Icons.edit)),
                                              IconButton(
                                                onPressed: () {
                                                  logic.deleteMuseum(
                                                      logic.muse[index].id!);
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
                            logic.addMuse(context);
                          },
                          child: const Text("Add Museum"),
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
