import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/snackbar/snackbar.dart';

void showCustomSnackBar(String? message, {bool isError = true}) {
 Get.snackbar(
   margin: EdgeInsets.all(17),
   isError ? "Error" : "Success",
   dismissDirection: DismissDirection.horizontal,
   message ?? "",
   snackPosition: SnackPosition.TOP,
     boxShadows: [
       BoxShadow(
         color: Colors.black.withOpacity(0.2),
         spreadRadius: 3,
         blurRadius: 6,
         offset: Offset(0, 4), // changes position of shadow
       ),
     ],
   backgroundColor: isError ? Colors.red : Colors.white.withOpacity(0.7),
   colorText: isError ?Colors.white.withOpacity(0.8):Colors.black,
 );
}