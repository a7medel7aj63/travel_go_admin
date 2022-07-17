import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travel_go/controller/all_data_controller.dart';

class Details extends StatelessWidget {
  const Details({
    Key? key,
    this.data1,
  }) : super(key: key);
  final dynamic data1;

  @override
  Widget build(BuildContext context) {
    final AllData controller = Get.put(AllData());
    final data = MediaQuery.of(context);
    final width = data.size.width;
    final height = data.size.height;
    return Scaffold(
        body: ListView(
      children: [
        Stack(
          children: [
            Hero(
              tag: Image.network(
                'src',
                fit: BoxFit.fill,
              ),
              child: Stack(
                children: [
                  /*Container(
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(17),
                            bottomRight: Radius.circular(17)),
                        */ /*image: DecorationImage(
                          image: NetworkImage(data1.image),
                          fit: BoxFit.fill,
                        )*/ /*),
                    height: data.size.height * 0.5,
                    // child: Image.network(
                    //
                    // ),
                  ),*/
                  SizedBox(
                    height: data.size.height * 0.5,
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(17),
                            bottomRight: Radius.circular(17)),
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.transparent,
                            Colors.black.withOpacity(0.7),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: data.size.height * 0.50,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: width * 0.07, vertical: height * .07),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Get.back();
                          },
                          child: const Icon(
                            Icons.arrow_back_ios,
                            color: Colors.white,
                            size: 24,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Spacer(),
                  Padding(
                    padding: const EdgeInsets.only(
                      left: 24,
                      right: 24,
                      top: 0,
                      bottom: 16,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            // ignore: prefer_adjacent_string_concatenation
                            "Title: ${data1.title}",
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Subtitle: ${data1.subtitle}\$  ",
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "subject: ${data1.subject}",
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        /*Padding(
          // alignment: Alignment.bottomCenter,
          padding: const EdgeInsets.all(15),
          child: Container(
            // height: data.size.height,
            decoration: const BoxDecoration(
              color: Colors.white,
            ),
            child: Center(
              child: Form(
                // key: logic.formKey2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomTextField(
                        controller: controller.title,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'please add filed';
                          }
                          return null;
                        },
                        lable: 'Resrvation by ',
                        icon: const Icon(Icons.person),
                        input: TextInputType.text),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomTextField(
                        controller: controller.subtitle,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'please add filed';
                          }
                          return null;
                        },
                        lable: 'Number Of Days',
                        icon: const Icon(Icons.title),
                        input: TextInputType.text),
                    const SizedBox(
                      height: 10,
                    ),

                    CustomTextButton(
                      lable: 'Reservation',
                      ontap: () {
                        // controller.makeResrviation(
                        //     data1.type, data1.number, data1.price,data1.id);
                      },
                      color: Colors.yellow[900]!,
                    )
                  ],
                ),
              ),
            ),
          ),
        ),*/
      ],
    ));
  }
}
