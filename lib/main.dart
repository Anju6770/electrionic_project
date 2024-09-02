import 'dart:async';
import 'package:electrionic_project/firebase_options.dart';
import 'package:electrionic_project/page_of_log_sign/login_page.dart';
import 'package:electrionic_project/page_of_log_sign/otp_page.dart';
import 'package:electrionic_project/page_of_log_sign/phone_page.dart';
import 'package:electrionic_project/page_of_log_sign/registration_page.dart';
import 'package:electrionic_project/pages/cart.dart';
import 'package:electrionic_project/pages/cover_page.dart';
import 'package:electrionic_project/pages/home_details.dart';
import 'package:electrionic_project/pages/home_page.dart';
import 'package:electrionic_project/pages/phone.dart';
import 'package:electrionic_project/partice.dart';
import 'package:electrionic_project/time_pass/light_dark_theme.dart';
import 'package:electrionic_project/time_pass/user_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Future <void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
   options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      initialRoute: '/cover',
      getPages: [
        GetPage(name: '/signup', page: ()=> RegistrationPage()),
        GetPage(name: '/log', page: ()=> LoginPage()),
        GetPage(name: '/cover', page: ()=> CoverPage()),
        GetPage(name: '/phone', page: ()=> PhonePage()),
        GetPage(name: '/otp', page: ()=> OtpPage()),
        GetPage(name: '/home', page: ()=> HomePage()),
        GetPage(name: '/par', page: ()=> PlacesListScreen()),
        GetPage(name: '/details', page: ()=> HomeDetails()),
        GetPage(name: '/pho', page: ()=> Phone()),
        GetPage(name: '/cart', page: ()=> Cart()),
        /// Time_pass
        GetPage(name: '/book', page: ()=> Book()),
        GetPage(name: '/theme', page: ()=> LightTheme()),
      ],
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      //home:MyHomePage(),
    );
  }
}


