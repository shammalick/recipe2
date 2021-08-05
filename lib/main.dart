import 'dart:io';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:recipe2/Utils/root.dart';
import 'package:recipe2/controllers/userController.dart';
import 'Screen/explore.dart';
import 'Screen/signUp.dart';
import 'controllers/bindings/bindings.dart';

void main() async {
  // Get.put<AuthController>(AuthController());
  Get.put(UserController());
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  MobileAds.instance.initialize();
  // Admob.initialize();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialBinding: AuthBinding(),
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        textTheme: GoogleFonts.montserratTextTheme(),
      ),
      debugShowCheckedModeBanner: false,
      home: Root(),
      routes: {
        '/signup': (_) => SignUp(),
        '/homepage': (_) => Explore(),
      },
    );
  }
}
