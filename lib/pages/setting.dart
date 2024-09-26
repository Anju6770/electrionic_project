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
        leading: InkWell(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Icon(Icons.arrow_back_ios),
        ),
        title: Text("Setting", style: mystyle(25, Colors.black, FontWeight.bold)),
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
                        Text("Account Settings", style: mystyle(22, Colors.black, FontWeight.bold)),
                        Gap(15),
                        Text("Profile Information", style: mystyle(19, Colors.black, FontWeight.bold)),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Change your Personal Information", style: mystyle(16, Colors.black.withOpacity(0.6))),
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
                                  Text("Delete Account", style: mystyle(19, Colors.black, FontWeight.bold)),
                                  Text("Delete your current Account", style: mystyle(16, Colors.black.withOpacity(0.6))),
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
                    height: MediaQuery.of(context).size.height * 0.2,
                    width: MediaQuery.of(context).size.width * 0.9,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.black.withOpacity(0.2),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Theme", style: mystyle(22, Colors.black, FontWeight.bold)),
                        Gap(30),
                        Text("Dark Theme", style: mystyle(19, Colors.black, FontWeight.bold)),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Change your theme to Dark/Light", style: mystyle(16, Colors.black.withOpacity(0.6))),
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