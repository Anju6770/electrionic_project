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
        leading: InkWell(onTap: (){Get.back();}, child: Icon(Icons.arrow_back_ios)),
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
              minWidth: MediaQuery.of(context).size.width*0.6,
              height: MediaQuery.of(context).size.height*0.06,
              shape: BeveledRectangleBorder(borderRadius: BorderRadius.circular(3)),
              color: Colors.black,
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
