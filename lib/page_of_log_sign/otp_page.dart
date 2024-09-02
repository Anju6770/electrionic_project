import 'package:electrionic_project/auth_services/auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
class OtpPage extends StatefulWidget {
  OtpPage({super.key});

  String verificationCode = Get.arguments;

  @override
  State<OtpPage> createState() => _OtpPageState();
}

class _OtpPageState extends State<OtpPage> {
  AuthServices _auth = AuthServices();
  TextEditingController _otpController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Phone Authentication", style: TextStyle(color: Colors.white),),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: Column(
        children: [
          TextFormField(
            controller: _otpController,
            decoration: InputDecoration(
              hintText: "Phone Number",
            ),
          ),
          MaterialButton(
            minWidth: 300,
            color: Colors.red,
            onPressed: () async {
              _auth.verifyNumber(widget.verificationCode, _otpController.text);
            },
            child: Text(
              "Verify Me",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
