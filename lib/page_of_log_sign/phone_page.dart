import 'package:electrionic_project/auth_services/auth.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
class PhonePage extends StatefulWidget {
  const PhonePage({super.key});

  @override
  State<PhonePage> createState() => _PhonePageState();
}

class _PhonePageState extends State<PhonePage> {
  TextEditingController _phoneController = TextEditingController();
  AuthServices _auth = AuthServices();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Phone Authentication", style: TextStyle(color: Colors.white),),
        centerTitle: true,
        backgroundColor: Colors.black,
        iconTheme: IconThemeData(
          color: Colors.white
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          children: [
            TextFormField(
              controller: _phoneController,
              decoration: InputDecoration(
                hintText: "Phone Number",
              ),
            ),
            Gap(20),
            MaterialButton(
              minWidth: 300,
              height: 50,
              shape: BeveledRectangleBorder(borderRadius: BorderRadius.circular(3)),
              color: Colors.red,
              onPressed: () async {
                _auth.sendOtp(_phoneController.text);
              },
              child: Text(
                "Send OTP",
                style: TextStyle(color: Colors.white,fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
