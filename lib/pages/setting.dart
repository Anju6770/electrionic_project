import 'package:electrionic_project/time_pass/Constant/constants.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class SettingPages extends StatefulWidget {
  const SettingPages({super.key});

  @override
  State<SettingPages> createState() => _SettingPagesState();
}

class _SettingPagesState extends State<SettingPages> {
  bool _darkmood = false;

  void _showSnackbar(BuildContext context, String message) {
    final snackBar = SnackBar(
      content: Text(message),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
            color: Colors.black,size: 27
        ),
        title: Text("Setting", style: mystyle(28)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.all(15),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.all(10),
                    height: MediaQuery.of(context).size.height * 0.3,
                    width: MediaQuery.of(context).size.width * 0.9,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.black.withOpacity(0.2),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Account Settings", style: TextStyle(fontSize: 22,color:  Colors.black,fontWeight:  FontWeight.bold)),
                        Gap(15),
                        Text("Profile Information", style: TextStyle(fontSize: 19,)),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Change your Personal Information", style: TextStyle(fontSize: 16,color:  Colors.black.withOpacity(0.6))),
                            Icon(Icons.arrow_forward_ios, size: 20),
                          ],
                        ),
                        Gap(40),
                        InkWell(
                          onTap: () {
                            _showSnackbar(context, "Your Acc has been deleted");
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Delete Account", style: TextStyle(fontSize: 19,color:  Colors.black,fontWeight:  FontWeight.bold)),
                                  Text("Delete your current Account", style: TextStyle(fontSize: 16,color:  Colors.black.withOpacity(0.6))),
                                ],
                              ),
                              Icon(Icons.arrow_forward_ios, size: 20),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Gap(15),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: EdgeInsets.all(10),
                    height: MediaQuery.of(context).size.height * 0.23,
                    width: MediaQuery.of(context).size.width * 0.9,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.black.withOpacity(0.2),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Theme", style: TextStyle(fontSize: 22,color:  Colors.black,fontWeight:  FontWeight.bold)),
                        Gap(30),
                        Text("Dark Theme", style: TextStyle(fontSize: 19)),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Change your theme to Dark/Light", style: TextStyle(fontSize: 16,color:  Colors.black.withOpacity(0.6))),
                            Switch(
                              value: _darkmood,
                              onChanged: (bool value) {
                                setState(() {
                                  _darkmood = value;
                                });
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}