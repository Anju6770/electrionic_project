import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:electrionic_project/Main_page/services.dart';
import 'package:electrionic_project/data/sign%20in_list.dart';
import 'package:electrionic_project/model/home.dart';
import 'package:electrionic_project/model/inside_logo.dart';
import 'package:electrionic_project/pages/phone.dart';
import 'package:electrionic_project/pages/search_product.dart';
import 'package:electrionic_project/time_pass/Constant/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_picker/image_picker.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  User? user;
  File? _image;

  @override
  void initState() {
    super.initState();
    user = FirebaseAuth.instance.currentUser;
  }
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
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
    final CollectionReference one = FirebaseFirestore.instance.collection("first");
    final CollectionReference second = FirebaseFirestore.instance.collection("second");
    Services _services = Services();
    return Scaffold(
      key: _scaffoldKey,
      endDrawer: Drawer(
        child: Column(
          children: [
            UserAccountsDrawerHeader(
              accountName: Text(
                user?.displayName ?? "${userData[0].firstName}",
                style: mystyle(25, Colors.white, FontWeight.bold),
              ),
              accountEmail: Text(
                user?.email ?? "${userData[0].email}",
                style: mystyle(25, Colors.white, FontWeight.bold),
              ),
              currentAccountPicture: Container(
                margin: EdgeInsets.all(5),
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
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.8),
              ),
            ),
            Gap(5),
            Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                children: [
                  ListTile(
                    onTap: (){
                      Get.toNamed('/profile');
                    },
                    leading: Icon(
                      Icons.portrait_rounded,
                      size: 35,
                    ),
                    title: Text(
                      "My Profile",
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                  ListTile(
                    onTap: (){
                      Get.toNamed('/setting');
                    },
                    leading: Icon(
                      Icons.settings_outlined,
                      size: 35,
                    ),
                    title: Text(
                      "Settings",
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.lock_outline,
                      size: 35,
                    ),
                    title: Text(
                      "Privacy and Security",
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.question_answer_outlined,
                      size: 35,
                    ),
                    title: Text(
                      "Help and Feedback",
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                ],
              ),
            ),
            MaterialButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return Container(
                        height: MediaQuery.of(context).size.height*0.5,
                        width: MediaQuery.of(context).size.width*0.9,
                        child: AlertDialog(
                          backgroundColor: Colors.black,
                          title: Text("Do you want to Log Out?",style: TextStyle(color: Colors.white,fontSize: 20),),
                          actions: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                TextButton(
                                    onPressed: () {
                                      Get.offAllNamed('/log');
                                    },
                                    child: Text(
                                      "Yes",
                                      style: mystyle(19,Colors.white),
                                    )),
                                TextButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    child: Text(
                                      "No",
                                      style: mystyle(19,Colors.white),
                                    )),
                              ],
                            )
                          ],
                        ),
                      );
                    });
              },
              child: ListTile(
                leading: Icon(
                  Icons.logout,
                  size: 35,color: Colors.red,
                ),
                title: Text(
                  "Log Out",
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ),
          ],
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: one.snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }
          final fir = snapshot.requireData;
          return SingleChildScrollView(
              child: Padding(
                padding:EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Gap(20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        StreamBuilder<List<InsideLogo>>(
                          stream: _services.fetchinside(),
                          builder: (context,snapshot){
                            if (snapshot.hasError) {
                              return Center(child: Text('Error: ${snapshot.error}'));
                            }
                            if (!snapshot.hasData) {
                              return Center(child: CircularProgressIndicator());
                            }
                            final logo = snapshot.data!;
                            return SizedBox(
                              height: MediaQuery.of(context).size.height * 0.06,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                shrinkWrap: true,
                                itemCount: logo.length,
                                itemBuilder: (context, index) {
                                  final logos = logo[index];
                                  return Container(
                                    width: MediaQuery.of(context).size.width * 0.6,
                                    decoration: BoxDecoration(
                                        image: DecorationImage(image: NetworkImage("${logos.image}"),fit: BoxFit.cover,)),
                                  );
                                },
                              ),
                            );
                          },
                        ),
                        Row(
                          children:[
                            Gap(10),
                            Icon(Icons.notifications, size: 25),
                            Gap(10),
                            InkWell(
                                onTap: () {
                                  _scaffoldKey.currentState!.openEndDrawer();
                                },
                                child: Icon(Icons.menu, size: 25)),
                          ],
                        ),
                      ],
                    ),
                    InkWell(
                      onTap: (){
                        Get.to(SearchDoc(),transition: Transition.downToUp);
                      },
                      child: Card(
                        elevation: 3.5,
                        child: Container(
                          padding:EdgeInsets.all(10),
                          height: MediaQuery.of(context).size.height * 0.06,
                          width: MediaQuery.of(context).size.width * 0.9,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Search...",style: TextStyle(fontSize: 20,color: Colors.black54),),
                              Icon(Icons.search,size: 25,color: Colors.black54,)
                            ],
                          )
                        ),
                      ),
                    ),
                    Gap(10),
                    CarouselSlider(
                      options: CarouselOptions(
                        height: MediaQuery.of(context).size.height * 0.3,
                        enlargeCenterPage: true,
                        autoPlay: true,
                        aspectRatio: 16 / 9,
                        autoPlayCurve: Curves.fastOutSlowIn,
                        enableInfiniteScroll: true,
                        autoPlayAnimationDuration: Duration(milliseconds: 900),
                        viewportFraction: 0.8,
                      ),
                      items: fir.docs.map((firsts) {
                        return Container(
                          margin: EdgeInsets.all(10),
                          padding: EdgeInsets.all(15),
                          width: MediaQuery.of(context).size.width * 0.8,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(
                              image: NetworkImage("${firsts["image"]}"),
                              fit: BoxFit.fill,
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${firsts['name']}",
                                style: TextStyle(
                                  fontSize: 23,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              Gap(40),
                              Container(
                                height: MediaQuery.of(context).size.height * 0.05,
                                width: MediaQuery.of(context).size.width * 0.6,
                                color: Colors.white,
                                child: Center(
                                  child: Text(
                                    "UP TO ${firsts['payment']}% OFF",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                    ),
                    Gap(15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [Text(
                          "Categories",
                          style: mystyle(26),
                        ),
                        Row(
                          children:[
                            Text("See more", style: TextStyle(fontSize: 16)),
                            Gap(6),
                            Icon(Icons.arrow_forward_ios, size: 16),
                          ],
                        ),
                      ],
                    ),
                    Gap(15),
                    StreamBuilder<QuerySnapshot>(
                      stream: second.snapshots(),
                      builder: (context, snapshot) {
                        if (snapshot.hasError) {
                          return Center(child: Text('Error: ${snapshot.error}'));
                        }
                        if (!snapshot.hasData) {
                          return Center(child: CircularProgressIndicator());
                        }
                        final sec = snapshot.requireData;
                        return SizedBox(
                            height: MediaQuery.of(context).size.height * 0.11,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              shrinkWrap: true,
                              itemCount: sec.size,
                              itemBuilder: (context, index) {
                                final second = sec.docs[index];
                                return InkWell(
                                  onTap: (){
                                    Get.to(Phone(),transition: Transition.leftToRightWithFade);
                                  },
                                  child: Container(
                                    margin:EdgeInsets.all(6),
                                    width: 80,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      image: DecorationImage(
                                        image: NetworkImage("${second['image']}"),
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          );
                      },
                    ),
                    Gap(12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Top Electronics",
                          style: mystyle(26),
                        ),
                        Row(
                          children:[
                            Text("See more", style: TextStyle(fontSize: 16)),
                            Gap(6),
                            Icon(Icons.arrow_forward_ios, size: 16),
                          ],
                        ),
                      ],
                    ),
                    Gap(15),
                    StreamBuilder<List<HomeModel>>(
                      stream: _services.fetchProducts(),
                      builder: (context,snapshot){
                        if (snapshot.hasError) {
                          return Center(child: Text('Error: ${snapshot.error}'));
                        }
                        if (!snapshot.hasData) {
                          return Center(child: CircularProgressIndicator());
                        }
                        final Products = snapshot.data!;
                        return GridView.builder(
                            shrinkWrap: true,
                            physics:NeverScrollableScrollPhysics(),
                            itemCount: Products.length,
                            gridDelegate:SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 5,
                              mainAxisSpacing: 5,
                              childAspectRatio: 0.54,
                            ),
                            itemBuilder: (context, index) {
                              final product = Products[index];
                              return InkWell(
                                onTap: (){
                                  Get.toNamed('/details', arguments: product);
                                },
                                child: Column(
                                  children: [
                                    Stack(
                                      children:[ Hero(
                                        tag:product.image,
                                        child: Container(
                                          height: MediaQuery.of(context).size.height * 0.2,
                                          width: double.infinity,
                                          decoration: BoxDecoration(
                                            image: DecorationImage(
                                              image: NetworkImage(product.image),
                                              fit: BoxFit.fill,
                                            ),
                                          ),
                                        ),
                                      ),
                                        Positioned(
                                          left: 9,
                                          top: 2,
                                          child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              height: MediaQuery.of(context).size.height * 0.05,
                                              width: MediaQuery.of(context).size.width * 0.13,
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(6),
                                                color: Colors.black,
                                              ),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  Text(product.rating, style: TextStyle(color: Colors.white)),
                                                  Gap(4),
                                                  Icon(Icons.star, color: Colors.white, size: 20),
                                                ],
                                              ),
                                            )
                                          ],
                                        ),)
                                      ]
                                    ),
                                    Container(
                                      padding:EdgeInsets.all(5),
                                      height: MediaQuery.of(context).size.height * 0.2,
                                      width: double.infinity,
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            product.name,
                                            style:TextStyle(fontSize: 20),
                                            maxLines: 2,
                                          ),
                                          Gap(4),
                                          Row(
                                            children: [
                                              Text(
                                                product.pay,
                                                style:TextStyle(
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.bold),
                                              ),
                                              Gap(6),
                                              Text(
                                                product.pay,
                                                style:TextStyle(
                                                  fontSize: 15,
                                                  color: Colors.grey,
                                                  decoration:
                                                  TextDecoration.lineThrough,
                                                ),
                                              ),
                                              Gap(5),
                                              Text(
                                                product.discount,
                                                style:TextStyle(
                                                  fontSize: 16,
                                                  color: Colors.green,fontWeight: FontWeight.bold
                                                ),
                                              ),
                                            ],
                                          ),
                                          Gap(5),
                                          Row(
                                            children: [
                                              Icon(Icons.discount),
                                              Gap(5),
                                              Text("Exchange Offers",style: TextStyle(fontSize: 16),),
                                            ],
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          );
                      },
                    ),
                  ],
                ),
              ),
            );
        },
      ),
    );
  }
}
