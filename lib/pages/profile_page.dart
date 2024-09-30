import 'dart:io';
import 'package:electrionic_project/data/sign%20in_list.dart';
import 'package:electrionic_project/time_pass/Constant/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';
import 'package:google_sign_in/google_sign_in.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  File? _image;
  User? user;

  @override
  void initState() {
    super.initState();
    user = FirebaseAuth.instance.currentUser;
  }

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
                    icon: Icon(Icons.camera_alt, size: 30),
                    tooltip: 'Take a photo',
                  ),
                  IconButton(
                    onPressed: () {
                      _imageFromGallery();
                      Navigator.pop(context);
                    },
                    icon: Icon(Icons.image, size: 30),
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

  // Sign in with Google
  Future<User?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

      if (googleAuth?.idToken != null && googleAuth?.accessToken != null) {
        final AuthCredential credential = GoogleAuthProvider.credential(
          idToken: googleAuth?.idToken,
          accessToken: googleAuth?.accessToken,
        );
        final UserCredential userCredential = await FirebaseAuth.instance.signInWithCredential(credential);
        setState(() {
          user = userCredential.user;
        });
        return userCredential.user;
      }
    } catch (e) {
      print(e);
      return null;
    }
  }

  // Sign in with email/password
  Future<User?> signInWithEmailPassword(String email, String password) async {
    try {
      final UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      setState(() {
        user = userCredential.user;
      });
      return userCredential.user;
    } catch (e) {
      print(e);
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.black,
          size: 27,
        ),
        title: Text(
          "Profile",
          style: mystyle(28),
        ),
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
                    child: Stack(children: [
                      GestureDetector(
                        child: Container(
                          height: 100,
                          width: 100,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              image: _image != null
                                  ? FileImage(_image!) // If the user picked an image
                                  : (user?.photoURL != null // If the user has a photo URL from Google
                                  ? NetworkImage(user!.photoURL!)
                                  : AssetImage('assets/image/pro.jpg')) as ImageProvider, // Fallback to default image
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: InkWell(
                          onTap: _pickImage,
                          child: Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                                color: Colors.grey,
                                borderRadius: BorderRadius.circular(100)),
                            child: Icon(Icons.linked_camera_outlined),
                          ),
                        ),
                      )
                    ]),
                  ),
                  Gap(10),
                  if (user != null)
                    Column(
                      children: [
                        Text(
                          user?.displayName ?? "${userData[0].firstName}",
                          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                        ),
                        Gap(10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.email_outlined, color: Colors.grey),
                            Gap(10),
                            Container(
                              width: MediaQuery.of(context).size.width*0.7,
                              child: Text(
                                user?.email ?? "No Email",
                                style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                        Divider(),
                        Gap(10),
                        ListTile(
                          leading: Icon(Icons.wallet,color: Colors.grey),
                          title: Text("Billing Details",style: TextStyle(fontSize: 21),),
                          trailing: Container(
                            width: 30,height: 30,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              color: Colors.grey.withOpacity(0.1),
                            ),
                            child: Icon(Icons.arrow_forward_ios_outlined),
                          ),
                        ),
                        Gap(10),
                        ListTile(
                          leading: Icon(Icons.person_add_alt_1_outlined,color: Colors.grey),
                          title: Text("User Management",style: TextStyle(fontSize: 21),),
                          trailing: Container(
                            width: 30,height: 30,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              color: Colors.grey.withOpacity(0.1),
                            ),
                            child: Icon(Icons.arrow_forward_ios_outlined),
                          ),
                        ),
                        Gap(10),
                        ListTile(
                          leading: Icon(Icons.info_outline_rounded,color: Colors.grey),
                          title: Text("Information",style: TextStyle(fontSize: 21),),
                          trailing: Container(
                            width: 30,height: 30,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              color: Colors.grey.withOpacity(0.1),
                            ),
                            child: Icon(Icons.arrow_forward_ios_outlined),
                          ),
                        ),
                        Gap(10),
                        ListTile(
                          leading: Icon(Icons.drive_file_rename_outline_outlined,color: Colors.grey),
                          title: Text("Edit",style: TextStyle(fontSize: 21),),
                          trailing: Container(
                            width: 30,height: 30,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              color: Colors.grey.withOpacity(0.1),
                            ),
                            child: Icon(Icons.arrow_forward_ios_outlined),
                          ),
                        ),
                      ],
                    ),
                  if (user == null)
                    Column(
                      children: [
                        ElevatedButton(
                          onPressed: () async {
                            await signInWithGoogle();
                          },
                          child: Text('Sign in with Google'),
                        ),
                        SizedBox(height: 10),
                        ElevatedButton(
                          onPressed: () async {
                            // Replace with your own email/password logic (get from a form)
                            String email = "user@example.com";
                            String password = "password123";
                            await signInWithEmailPassword(email, password);
                          },
                          child: Text('Sign in with Email'),
                        ),
                      ],
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
