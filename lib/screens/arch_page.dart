import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travel_go/controller/arch_controller.dart';
import 'package:travel_go/widgets/drawer.dart';

class ArchPage extends StatelessWidget {
  const ArchPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final data = MediaQuery.of(context);
    ArchController controller = Get.find();
    return Scaffold(
        appBar: AppBar(
          title: const Text('Arch Area'),
          backgroundColor: Colors.deepPurple[900],
        ),
        drawer: AppDrawer(),
        body: GetX<ArchController>(
          autoRemove: false,
          init: ArchController(),
          builder: (logic) {
            return logic.loading.value
                ? SizedBox(
                    height: data.size.height,
                    width: data.size.width,
                    child: Stack(children: [
                      logic.archs.isEmpty
                          ? const Center(
                              child: Text('No Arch founded'),
                            )
                          : ListView.builder(
                              itemCount: logic.archs.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Card(
                                    elevation: 5,
                                    margin: const EdgeInsets.all(10),
                                    child: ListTile(
                                      title: Text('${logic.archs[index].name}'),
                                      leading: CircleAvatar(
                                        child: Text('${index + 1}',
                                            style: const TextStyle(
                                                color: Colors.white)),
                                        backgroundColor: Colors.amber.shade700,
                                      ),
                                      subtitle: Text(
                                          'name: ${logic.archs[index].name}'
                                          'about: ${logic.archs[index].about}'),
                                      trailing: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          // IconButton(onPressed: () {}, icon: const Icon(Icons.edit)),
                                          IconButton(
                                            onPressed: () {
                                              logic.deleteArch(
                                                  logic.archs[index].id!);
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
                            logic.addArch(context);
                          },
                          child: const Text("Add Arch"),
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
