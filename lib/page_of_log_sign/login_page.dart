import 'package:electrionic_project/auth_services/auth.dart';
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
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          color: Colors.black,
          width: double.infinity,
          child: Column(
            children: [
              FutureBuilder(
                future: Future.wait([
                  _getImage("ele_cover-removebg-preview.png"),
                ]),
                builder: (BuildContext context, AsyncSnapshot<List<Widget>> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return const Center(child: Text("Error loading images"));
                  } else {
                    return Column(
                      children: snapshot.data!,
                    );
                  }
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
                    Text("Please provide you Email ID and password",style: TextStyle(fontSize: 16,color: Colors.grey),),
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
                              backgroundColor: Colors.white,
                              "Success",
                              "Sign In Successful");
                          Get.offAllNamed('/home');
                        } else {
                          Get.snackbar(
                            backgroundColor: Colors.white,
                            "Sorry",
                            "Your email or Password may be wrong",
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
                          Container(
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(40),
                            ),
                            child: FutureBuilder(
                              future: Future.wait([
                                _getImage("goggle.jpg"),
                              ]),
                              builder: (BuildContext context, AsyncSnapshot<List<Widget>> snapshot) {
                                if (snapshot.connectionState == ConnectionState.waiting) {
                                  return const Center(child: CircularProgressIndicator());
                                } else if (snapshot.hasError) {
                                  return const Center(child: Text("Error loading images"));
                                } else {
                                  return Column(
                                    children: snapshot.data!,
                                  );
                                }
                              },
                            ),
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
