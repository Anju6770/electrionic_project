import 'package:electrionic_project/Main_page/services.dart';
import 'package:electrionic_project/auth_services/auth.dart';
import 'package:electrionic_project/model/cover_last.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final storage = FirebaseStorage.instance;

  Future<Widget> _getImage(String imageName) async {
    final ref = storage.ref().child(imageName);
    final url = await ref.getDownloadURL();
    return Image.network(url);
  }
  AuthServices _auth = AuthServices();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  bool _isPasswordObscured = true;
  @override
  Widget build(BuildContext context) {
    Services _services = Services();
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          color: Colors.black,
          width: double.infinity,
          child: Column(
            children: [
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Log In",style: TextStyle(fontSize: 26,fontWeight: FontWeight.bold),),
                    Gap(10),
                    Text("Please provide your Email ID and password",style: TextStyle(fontSize: 16,color: Colors.grey),),
                    Gap(10),
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
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          hintText: "Enter your email",
                          border: InputBorder.none,
                          suffixIcon: Icon(Icons.email_outlined),
                        ),
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
                          hintText: "Enter your password",
                          border: InputBorder.none,
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
                      ),
                    ),
                    Gap(20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        InkWell(
                          onTap: () async {
                            Get.toNamed('/phone');
                          },
                          child: Text(
                            "Forgot Password?",
                            style: TextStyle(fontSize: 14.5, color: Colors.blue),
                          ),
                        ),
                      ],
                    ),
                    Gap(20),
                    MaterialButton(
                      minWidth: double.infinity,
                      height: 50,
                      shape: BeveledRectangleBorder(borderRadius: BorderRadius.circular(3)),
                      color: Colors.black,
                      onPressed: () async {
                        User? user = await _auth.signInWithEmailAndPassword(
                            _emailController.text, _passwordController.text);
                        if (user != null) {
                          Get.snackbar(
                            "Success",
                            "Sign In Successful",
                            backgroundColor: Colors.black,
                            titleText: Text(
                              "Success",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                            messageText: Text(
                              "Sign In Successful",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                            colorText: Colors.white,
                          );
                          Get.offAllNamed('/button');
                        } else {
                          Get.snackbar(
                            "Sorry",
                            "Your email or Password may be wrong",
                            backgroundColor: Colors.black,
                            titleText: Text(
                              "Sorry",
                              style: TextStyle(
                                color: Colors.red,
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                            messageText: Text(
                              "Your email or Password may be wrong",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                            colorText: Colors.white,
                          );

                        }
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Sign In",
                            style: TextStyle(color: Colors.white,fontSize: 19),),
                          Icon(Icons.arrow_forward,size: 22,color: Colors.white,),
                        ],
                      ),
                    ),
                    SizedBox(height: 20,),
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
                    Gap(10),
                    MaterialButton(
                      minWidth: double.infinity,
                      height: 50,
                      shape: BeveledRectangleBorder(borderRadius: BorderRadius.circular(3)),
                      color: Colors.grey,
                      onPressed: ()  {
                        Get.offAllNamed('/signup');
                      },
                      child: Text(
                        "Create an Account",
                        style: TextStyle(color: Colors.white,fontSize: 18),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
