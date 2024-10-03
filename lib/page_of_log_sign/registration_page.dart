import 'package:dotted_line/dotted_line.dart';
import 'package:electrionic_project/Main_page/services.dart';
import 'package:electrionic_project/auth_services/auth.dart';
import 'package:electrionic_project/data/sign%20in_list.dart';
import 'package:electrionic_project/model/cover_first.dart';
import 'package:electrionic_project/model/cover_last.dart';
import 'package:electrionic_project/model/sign%20In.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {

  AuthServices _auth = AuthServices();

  final TextEditingController _firstNameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _locationController = TextEditingController();
  TextEditingController _numberController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  bool _isPasswordObscured = true;
  @override
  Widget build(BuildContext context) {
    Services _services = Services();
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Column(
          children: [
            StreamBuilder<List<CoverFirst>>(
              stream: _services.fetchsign(),
              builder: (context,snapshot){
                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                }
                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(color: Colors.white,),
                  );
                }
                final logo = snapshot.data!;
                return SizedBox(
                  height: MediaQuery.of(context).size.height * 0.45,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    shrinkWrap: true,
                    itemCount: logo.length,
                    itemBuilder: (context, index) {
                      final logos = logo[index];
                      return Column(
                        children: [
                          Image(image: NetworkImage("${logos.image}"),fit: BoxFit.cover,),

                        ],
                      );
                    },
                  ),
                );
              },
            ),
            Container(
              padding: EdgeInsets.all(20),
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(topRight: Radius.circular(30),topLeft: Radius.circular(30)),
                color: Colors.white,
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Create Account",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
                    Gap(10),
                    InkWell(
                      onTap: (){
                        Get.offAllNamed('/log');
                      },
                      child: Row(
                        children: [
                          Text("Already have an account?",style: TextStyle(fontSize: 17),),
                          Text("Sign In",style: TextStyle(fontSize: 17,fontWeight: FontWeight.bold),),
                        ],
                      ),
                    ),
                    Gap(20),
                    Container(
                      padding: EdgeInsets.all(10),
                      height: 55,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.grey.withOpacity(0.2),
                      ),
                      child: TextFormField(
                        controller: _firstNameController,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Full Name",
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Enter first name";
                          }
                          return null;
                        },
                      ),
                    ),
                    Gap(20),
                    Container(
                      padding: EdgeInsets.all(10),
                      height: 55,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.grey.withOpacity(0.2),
                      ),
                      child: TextFormField(
                        controller: _locationController,
                        decoration: InputDecoration( fillColor: Colors.blue,
                          border: InputBorder.none,
                          hintText: "Location",
                          suffixIcon: Icon(Icons.location_city),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please enter location";
                          }
                          return null;
                        },
                      ),
                    ),
                    Gap(20),
                    Container(
                      padding: EdgeInsets.all(10),
                      height: 55,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.grey.withOpacity(0.2),
                      ),
                      child: TextFormField(
                        controller: _numberController,
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration( fillColor: Colors.blue,
                          border: InputBorder.none,
                          hintText: "+975- Phone Number",
                          suffixIcon: Icon(Icons.call_sharp),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please enter phone number";
                          }
                          if (!value.contains("+975-")) {
                            return "Should contain +975-";
                          }
                          return null;
                        },
                      ),
                    ),
                    Gap(20),
                    Container(
                      padding: EdgeInsets.all(10),
                      height: 55,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.grey.withOpacity(0.2),
                      ),
                      child: TextFormField(
                        controller: _emailController,
                        decoration: InputDecoration( fillColor: Colors.blue,
                          border: InputBorder.none,
                          hintText: "Email",
                          suffixIcon: Icon(Icons.email_outlined),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please enter email";
                          }
                          if (!value.contains("@")) {
                            return "Enter a valid email address";
                          }
                          if (!value.contains("gmail.com")) {
                            return "Email should contain 'gmail.com'";
                          }
                          return null;
                        },
                      ),
                    ),
                    Gap(20),
                    Container(
                      padding: EdgeInsets.all(10),
                      height: 55,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.grey.withOpacity(0.2),
                      ),
                      child: TextFormField(
                        controller: _passwordController,
                        obscureText: _isPasswordObscured,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Password",
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                _isPasswordObscured = !_isPasswordObscured;
                              });
                            },
                            icon: Icon(
                              _isPasswordObscured ? Icons.visibility_off : Icons.visibility,
                            ),
                          ),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Please enter password";
                          }
                          if (value.length < 6) {
                            return "Password must be at least 8 characters";
                          }
                          return null;
                        },
                      ),
                    ),
                    Gap(20),
                    MaterialButton(
                      minWidth: double.infinity,
                      height: 50,
                      shape: BeveledRectangleBorder(borderRadius: BorderRadius.circular(3)),
                      color: Colors.black,
                      onPressed: () async {
                        User? user = await _auth.signUpWithEmailAndPassword(
                            _emailController.text, _passwordController.text,
                          _firstNameController.text,
                          _locationController.text,);
                        if (_formKey.currentState?.validate() ?? false) {
                          userData.add(
                            Register(
                              email: _emailController.text.toString(),
                              password: _passwordController.text.toString(),
                              firstName: _firstNameController.text.toString(),
                              location: _locationController.text.toString(),
                              number: _numberController.text.toString(),
                            ),
                          );
                        }
                        if (user != null) {
                          Get.bottomSheet(
                            Container(
                              height: 320,
                              width: double.infinity,  // Ensures full-width
                              padding: EdgeInsets.all(16.0),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(20.0),
                                  topRight: Radius.circular(20.0),
                                ),
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    height: 120,
                                    width: 120,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(40),
                                      image: DecorationImage(image: AssetImage("assets/image/complete.png"),fit: BoxFit.cover),
                                    ),
                                  ),
                                  Text(
                                    "Registration Successful",
                                    style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(height: 10),
                                  Text("By tap sign in, you have accept the terms and policy of the app",style: TextStyle(fontSize: 20),),
                                  SizedBox(height: 20),
                                  InkWell(
                                      onTap: (){
                                        Get.offAllNamed('/log');
                                      },
                                      child: Text("Sign In",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),)),
                                ],
                              ),
                            ),
                            isScrollControlled: true,
                          );
                        } else {
                          Get.bottomSheet(
                            Container(
                              height: 300,
                              width: double.infinity,  // Ensures full-width
                              padding: EdgeInsets.all(30),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(20.0),
                                  topRight: Radius.circular(20.0),
                                ),
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Sorry",
                                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold,color: Colors.red),
                                  ),
                                  SizedBox(height: 10),
                                  Text("There has been a problem, try again.",style: TextStyle(fontSize: 23),),
                                  SizedBox(height: 20),
                                  Center(
                                    child: ElevatedButton(
                                      onPressed: () {
                                        Get.back();
                                      },
                                      child: Container(
                                          height: MediaQuery.of(context).size.height*0.1,
                                          width: MediaQuery.of(context).size.width*0.8,
                                          child: Center(child: Text("Try Again",style: TextStyle(color: Colors.black,fontSize: 20)))),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            isScrollControlled: true,
                          );
                        }
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Sign UP",
                            style: TextStyle(color: Colors.white,fontSize: 19),),
                          Icon(Icons.arrow_forward,size: 22,color: Colors.white,),
                        ],
                      ),
                    ),
                    Gap(15),
                    InkWell(
                      onTap:  () async {
                        _auth.signInWithGoogle();
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Or Sign In with goggle",style: TextStyle(fontSize: 14),),
                          Gap(10),
                          StreamBuilder<List<CoverLast>>(
                            stream: _services.fetchlog(),
                            builder: (context,snapshot){
                              if (snapshot.hasError) {
                                return Center(child: Text('Error: ${snapshot.error}'));
                              }
                              if (!snapshot.hasData) {
                                return Center(child: CircularProgressIndicator());
                              }
                              final logo = snapshot.data!;
                              return SizedBox(
                                height: MediaQuery.of(context).size.height * 0.05,
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  shrinkWrap: true,
                                  itemCount: logo.length,
                                  itemBuilder: (context, index) {
                                    final logos = logo[index];
                                    return Container(
                                      height: 50,
                                      width: 50,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(40),
                                          image: DecorationImage(image: NetworkImage("${logos.image1}"),fit: BoxFit.fill,)),
                                    );
                                  },
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                    Center(
                      child: Container(
                          width: MediaQuery.of(context).size.width*0.6,
                          child: Text("By tap sign in, you have accept the terms and policy of the app",style: TextStyle(fontSize: 14,color: Colors.black),)),
                    ),
                    Gap(20),
                    DottedLine(
                      dashLength: 4.0,
                      dashColor: Colors.grey,
                      dashGapLength: 8.0,
                      lineThickness: 2.0,
                      direction: Axis.horizontal,
                    ),
                    Gap(20),
                    TextButton(onPressed: (){
                      Get.offAllNamed('/cover');
                    },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.arrow_back,size: 22,color: Colors.black,),
                            Gap(20),
                            Text("Back to Sing In page",style: TextStyle(fontSize: 20,color: Colors.black),),
                          ],
                        ))
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
