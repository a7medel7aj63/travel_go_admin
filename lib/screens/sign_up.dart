import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/auth_controller.dart';
import 'background-image.dart';

class SignUp extends StatelessWidget {
  SignUp({Key? key}) : super(key: key);

  final AuthController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    final data = MediaQuery.of(context);

    final width = data.size.width;
    final height = data.size.height;
    return Scaffold(
      appBar: AppBar(
        title: const Text('sign up'),
        backgroundColor: Colors.deepPurple[900],
      ),
      body: Container(
        color: Colors.blue,
        child: Stack(
          children: [
            BackgroundImage(image: 'assets/images/back.jpg'),
            Form(
              key: controller.formKey2,
              child: ListView(
                padding: EdgeInsets.only(top: height * 0.05),
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: Container(
                      padding:
                          EdgeInsets.only(right: width / 8, left: width / 8),
                      height: height * 0.1,
                      width: width * 1.0,
                      child: TextFormField(
                        controller: controller.name,
                        validator: (val) {
                          return controller.validate(val!);
                        },
                        decoration: InputDecoration(
                          errorBorder: OutlineInputBorder(
                            borderSide:
                                const BorderSide(color: Colors.red, width: 3.0),
                            borderRadius: BorderRadius.circular(13),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Colors.white, width: 2.0),
                            borderRadius: BorderRadius.circular(13),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.white70.withOpacity(.7),
                                width: 1.0),
                            borderRadius: BorderRadius.circular(13),
                          ),
                          prefixIcon: const Icon(
                            Icons.person,
                            size: 24,
                            color: Colors.white,
                          ),

                          labelText: 'Name',

                          labelStyle: const TextStyle(color: Colors.white),
                          hintStyle: const TextStyle(color: Colors.white),

                          // hintText: hint,
                          //  hintStyle: kBodyText,
                        ),
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: Container(
                      padding:
                          EdgeInsets.only(right: width / 8, left: width / 8),
                      height: height * 0.1,
                      width: width * 1.0,

                      // decoration: BoxDecoration(
                      //   color: Colors.grey[500].withOpacity(0.5),
                      //   borderRadius: BorderRadius.circular(16),
                      // ),
                      child: TextFormField(
                        controller: controller.email,
                        validator: (val) {
                          return controller.validateEmail(val!);
                        },
                        decoration: InputDecoration(
                          errorBorder: OutlineInputBorder(
                            borderSide:
                                const BorderSide(color: Colors.red, width: 3.0),
                            borderRadius: BorderRadius.circular(13),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Colors.white, width: 2.0),
                            borderRadius: BorderRadius.circular(13),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.white70.withOpacity(.7),
                                width: 1.0),
                            borderRadius: BorderRadius.circular(13),
                          ),
                          prefixIcon: const Icon(
                            Icons.email,
                            size: 24,
                            color: Colors.white,
                          ),

                          labelText: 'Email',

                          labelStyle: const TextStyle(color: Colors.white),
                          hintStyle: const TextStyle(color: Colors.white),

                          // hintText: hint,
                          //  hintStyle: kBodyText,
                        ),
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: Container(
                      padding:
                          EdgeInsets.only(right: width / 8, left: width / 8),
                      height: height * 0.1,
                      width: width * 1.0,

                      // decoration: BoxDecoration(
                      //   color: Colors.grey[500].withOpacity(0.5),
                      //   borderRadius: BorderRadius.circular(16),
                      // ),
                      child: TextFormField(
                        controller: controller.number,
                        validator: (val) {
                          return controller.validateNumber(val!);
                        },
                        decoration: InputDecoration(
                          errorBorder: OutlineInputBorder(
                            borderSide:
                                const BorderSide(color: Colors.red, width: 3.0),
                            borderRadius: BorderRadius.circular(13),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Colors.white, width: 2.0),
                            borderRadius: BorderRadius.circular(13),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                                color: Colors.white70.withOpacity(.7),
                                width: 1.0),
                            borderRadius: BorderRadius.circular(13),
                          ),
                          prefixIcon: const Icon(
                            Icons.phone,
                            size: 28,
                            color: Colors.white,
                          ),

                          labelText: 'Phone number',

                          labelStyle: const TextStyle(color: Colors.white),
                          // hintText: hint,
                          hintStyle: const TextStyle(color: Colors.white),
                        ),
                        style: const TextStyle(color: Colors.white),

                        //  style: kBodyText,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: Container(
                      padding:
                          EdgeInsets.only(right: width / 8, left: width / 8),
                      height: height * 0.1,
                      width: width * 1.0,

                      // decoration: BoxDecoration(
                      //   color: Colors.grey[500].withOpacity(0.5),
                      //   borderRadius: BorderRadius.circular(16),
                      // ),
                      child: GetBuilder<AuthController>(
                        builder: (logic) {
                          return TextFormField(
                            controller: logic.password,
                            obscureText: logic.obscureTextSignup,
                            validator: (val) {
                              return logic.validatePassword(val!);
                            },
                            decoration: InputDecoration(
                              suffixIcon: IconButton(
                                  onPressed: () {
                                    logic.toggleSignup();
                                  },
                                  icon: Icon(
                                    // Based on passwordVisible state choose the icon
                                    logic.obscureTextSignup
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                    color: Theme.of(context).primaryColorDark,
                                  )),
                              errorBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Colors.red, width: 3.0),
                                borderRadius: BorderRadius.circular(13),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Colors.white, width: 2.0),
                                borderRadius: BorderRadius.circular(13),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.white70.withOpacity(.7),
                                    width: 1.0),
                                borderRadius: BorderRadius.circular(13),
                              ),
                              prefixIcon: const Icon(
                                Icons.lock,
                                size: 24,
                                color: Colors.white,
                              ),

                              labelText: 'Password',

                              labelStyle: const TextStyle(color: Colors.white),
                              hintStyle: const TextStyle(color: Colors.white),

                              // hintText: hint,
                              //  hintStyle: kBodyText,
                            ),
                            style: const TextStyle(color: Colors.white),
                          );
                        },
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: Container(
                      padding:
                          EdgeInsets.only(right: width / 8, left: width / 8),
                      height: height * 0.1,
                      width: width * 1.0,

                      // decoration: BoxDecoration(
                      //   color: Colors.grey[500].withOpacity(0.5),
                      //   borderRadius: BorderRadius.circular(16),
                      // ),
                      child: GetBuilder<AuthController>(
                        builder: (logic) {
                          return TextFormField(
                            controller: logic.repassword,
                            obscureText: logic.obscureTextSignupConfirm,
                            validator: (val) {
                              return logic.validateRePassword(val!);
                            },
                            decoration: InputDecoration(
                              suffixIcon: IconButton(
                                  onPressed: () {
                                    logic.toggleSignupConfirm();
                                  },
                                  icon: Icon(
                                    // Based on passwordVisible state choose the icon
                                    logic.obscureTextSignupConfirm
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                    color: Theme.of(context).primaryColorDark,
                                  )),
                              errorBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Colors.red, width: 3.0),
                                borderRadius: BorderRadius.circular(13),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    color: Colors.white, width: 2.0),
                                borderRadius: BorderRadius.circular(13),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.white70.withOpacity(.7),
                                    width: 1.0),
                                borderRadius: BorderRadius.circular(13),
                              ),
                              prefixIcon: const Icon(
                                Icons.lock,
                                size: 24,
                                color: Colors.white,
                              ),

                              labelText: 'Retype Password',

                              labelStyle: const TextStyle(color: Colors.white),
                              hintStyle: const TextStyle(color: Colors.white),

                              // hintText: hint,
                              //  hintStyle: kBodyText,
                            ),
                            style: const TextStyle(color: Colors.white),
                          );
                        },
                      ),
                    ),
                  ),
                  Center(
                    child: TextButton(
                      style: ButtonStyle(
                          padding: MaterialStateProperty.all(EdgeInsets.only(
                              top: height / 45,
                              bottom: height / 45,
                              left: width / 10,
                              right: width / 10)),
                          backgroundColor:
                              MaterialStateProperty.all(Colors.deepPurple[900]),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(13),
                                      side: BorderSide(
                                          color: Colors.deepPurple[900]!)))),
                      onPressed: () async {
                        controller.register();
                      },
                      child: const Text(
                        "sign up",
                        style: TextStyle(fontSize: 20.0, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void showBar(BuildContext context, String msg, int ch) {
    var bar = SnackBar(
      backgroundColor: ch == 0 ? Colors.cyanAccent : Colors.deepPurple,
      content: Text(msg),
    );
    ScaffoldMessenger.of(context).showSnackBar(bar);
  }
}
