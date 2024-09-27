import 'dart:io';
import 'package:electrionic_project/data/sign%20in_list.dart';
import 'package:electrionic_project/time_pass/Constant/constants.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  File? _image;

  Future<void> _pickImage() async {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Select an option',
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                    onPressed: () {
                      _imageFromCamera();
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.camera_alt,size: 30,),
                    tooltip: 'Take a photo',
                  ),
                  IconButton(
                    onPressed: () {
                      _imageFromGallery();
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.image,size: 30,),
                    tooltip: 'Choose from gallery',
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _imageFromGallery() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile == null) return;
    setState(() {
      _image = File(pickedFile.path);
    });
  }

  Future<void> _imageFromCamera() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.camera);
    if (pickedFile == null) return;
    setState(() {
      _image = File(pickedFile.path);
    });
  }
  bool _isEditing = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
            color: Colors.black,size: 27
        ),
        title: Text("Profile",style: mystyle(30),),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(30),
              child: Column(
                children: [
                  Center(
                    child: Stack(
                        children:[ GestureDetector(
                          child: CircleAvatar(
                            radius: 80,
                            backgroundImage: _image != null
                                ? FileImage(_image!):AssetImage('assets/image/pro.jpg'),
                          ),
                        ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: InkWell(
                              onTap: _pickImage,
                              child: Container(
                                width: 40,height: 40,
                                decoration: BoxDecoration(
                                    color: Colors.grey,
                                    borderRadius: BorderRadius.circular(100)),
                                child: Icon(Icons.linked_camera_outlined),
                              ),
                            ),
                          )
                        ]
                    ),
                  ),
                  Gap(10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          Text(
                            '${userData[0].firstName}',
                            style: mystyle(25,Colors.black,FontWeight.bold),
                          ),
                          Gap(10),
                          Text(
                            '${userData[0].lastName}',
                            style: mystyle(25,Colors.black,FontWeight.bold),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Gap(10),
                  Divider(),
                  Gap(10),
                  Row(
                    children: [
                      Icon(Icons.email_outlined,color: Colors.grey,),
                      Gap(10),
                      Text('${userData[0].email}', style: TextStyle(fontSize: 20,color:  Colors.black,fontWeight:  FontWeight.bold),),
                    ],
                  ),
                  Gap(10),
                  Row(
                    children: [
                      Icon(Icons.call_sharp,color: Colors.grey,),
                      Gap(10),
                      Text('${userData[0].number}', style: TextStyle(fontSize: 20,color:  Colors.black,fontWeight:  FontWeight.bold),),
                    ],
                  ),
                  Gap(10),
                  Row(
                    children: [
                      Icon(Icons.location_city_outlined,color: Colors.grey,),
                      Gap(10),
                      Text('${userData[0].location}', style: TextStyle(fontSize: 20,color:  Colors.black,fontWeight:  FontWeight.bold),),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      )
    );
  }
}
