import 'package:flutter/material.dart';
import 'package:get/get.dart';

showSnackBar({required String title, required String message, Widget? icon, Widget? messageText}) {
  Get.snackbar(
    title,
    message,

    messageText: messageText,
    // icon: Padding(
    //   padding: const EdgeInsets.only(left: 10.0),
    //   child: Container(
    //     height: (53),
    //     width: (53),
    //     decoration: BoxDecoration(
    //       shape: BoxShape.circle,
    //       boxShadow: [
    //         BoxShadow(
    //           color: Colors.grey.withOpacity(0.4),
    //           spreadRadius: 2,
    //           blurRadius: 8,
    //           offset: const Offset(0, 2), // changes position of shadow
    //         ),
    //       ],
    //       color: Colors.white,
    //     ),
    //     child: icon,
    //   ),
    // ),
    // snackPosition: SnackPosition.TOP,
    // backgroundColor: const Color(0xff235B76),
    borderRadius: (10),
    boxShadows: [
      BoxShadow(
        color: Get.theme.colorScheme.secondary,
        spreadRadius: 0.5,
        blurRadius: 2,
        offset: const Offset(0, 2), // changes position of shadow
      ),
    ],
    margin: const EdgeInsets.all(15),
    // colorText: Get.theme.colorScheme.secondary,
    duration: const Duration(seconds: 4),
    isDismissible: true,
    forwardAnimationCurve: Curves.easeOutBack,
  );
}
