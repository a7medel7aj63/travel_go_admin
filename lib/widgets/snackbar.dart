import 'package:flutter/material.dart';
import 'package:get/get.dart';

void showbar(String title, subtitle, desc, bool color) {
  Get.snackbar(title, subtitle,
      backgroundColor: color ? Colors.indigoAccent : Colors.cyan,
      snackPosition: SnackPosition.TOP,
      messageText: Text(desc, style: const TextStyle(color: Colors.white)));
}
