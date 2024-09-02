import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
//import 'package:light_dark_mood/Manage_state/manageState.dart';

class LightTheme extends StatelessWidget {
  LightTheme({super.key});

  final ManageState ms = Get.put(ManageState());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GetBuilder<ManageState>(builder: (_) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: ms.isLightTheme ? Colors.white : Colors.black,
            title: Text(
              'Dark & light mode',
              style: TextStyle(
                color: ms.isLightTheme ? Colors.black : Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            actions: [
              IconButton(
                onPressed: () {
                  // Toggle the theme
                  ms.toggletheme();
                },
                icon: Icon(
                  ms.isLightTheme ? Icons.sunny : Icons.nightlight,
                  color: ms.isLightTheme ? Colors.black : Colors.white,
                ),
              ),
            ],
          ),
          backgroundColor: ms.isLightTheme ? Colors.white : Colors.black, // Set Scaffold background color
          body: Center(
            child: Text(
              'homepage!',
              style: TextStyle(
                fontSize: 24,
                color: ms.isLightTheme ? Colors.black : Colors.white,
              ),
            ),
          ),
        );
      }),
    );
  }
}
class ManageState extends GetxController {

  bool _isLightTheme=true;

  bool get isLightTheme=>_isLightTheme;

  void toggletheme(){
    _isLightTheme = !_isLightTheme;
    update();
  }

}
mystyle(
    double fs, [Color ?Clr, FontWeight ?fw ]){
  return GoogleFonts.nunito(
    fontSize: fs,
    color: Clr,
    fontWeight: fw,
  );
}