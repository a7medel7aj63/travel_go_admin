import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travel_go/controller/bank_controller.dart';

import '../widgets/drawer.dart';

class BankPage extends StatelessWidget {
  const BankPage({Key? key}) : super(key: key);
  static const String id = "Bank-screen";

  @override
  Widget build(BuildContext context) {
    final data = MediaQuery.of(context);
    return Scaffold(
        appBar: AppBar(
          title: const Text('Bank'),
          backgroundColor: Colors.deepPurple[900],
        ),
        //bottomNavigationBar: const BottomNavigation(),
        drawer: AppDrawer(),
        body: GetX<BankController>(
          init: BankController(),
          autoRemove: false,
          builder: (logic) {
            return logic.loading.value
                ? SizedBox(
                    height: data.size.height,
                    width: data.size.width,
                    child: Stack(children: [
                      logic.banks.isEmpty
                          ? const Center(
                              child: Text('No Bank founded'),
                            )
                          : ListView.builder(
                              itemCount: logic.banks.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Card(
                                    elevation: 5,
                                    margin: const EdgeInsets.all(10),
                                    child: Column(
                                      children: [
                                        ListTile(
                                          title: Text(
                                              '${logic.banks[index].name} bank'),
                                          leading: CircleAvatar(
                                            child: Text(
                                              '${index + 1}',
                                              style: const TextStyle(
                                                  color: Colors.white),
                                            ),
                                            backgroundColor:
                                                Colors.amber.shade700,
                                          ),
                                          subtitle: Text(
                                              'Location: ${logic.banks[index].location} /n About: ${logic.banks[index].about}\$'),
                                          trailing: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              IconButton(
                                                  onPressed: () {
                                                    logic.editBank(
                                                        logic.banks[index].id!,
                                                        context,
                                                        logic
                                                            .banks[index].name!,
                                                        logic.banks[index]
                                                            .location!,
                                                        logic.banks[index]
                                                            .about!);
                                                  },
                                                  icon: const Icon(Icons.edit)),
                                              IconButton(
                                                onPressed: () {
                                                  logic.deleteBank(
                                                      logic.banks[index].id!);
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
                            logic.addBank(context);
                          },
                          child: const Text("Add Bank"),
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
