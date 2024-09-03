import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ManageState extends GetxController {

  bool _isLightTheme=true;

  bool get isLightTheme=>_isLightTheme;

  void toggletheme(){
    _isLightTheme = !_isLightTheme;
    update();
  }

}