import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:recipe2/Screen/login.dart';
import 'package:recipe2/Screen/splashScreen.dart';
import 'package:recipe2/controllers/authController.dart';


class Root extends GetWidget<AuthController> {
  @override
  Widget build(BuildContext context) {
 
    return Obx((){
return (Get.find<AuthController>().user != null) ?Splash():Login();
    });
  }
}