import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:electrionic_project/Main_page/services.dart';
import 'package:electrionic_project/ManageState/search_controller.dart';
import 'package:electrionic_project/auth_services/auth.dart';
import 'package:electrionic_project/model/home.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late String image;

  final storage = FirebaseStorage.instance;
  final HomeController homeController = Get.put(HomeController());
  AuthServices _auth = AuthServices();

  @override
  void initState() {
    super.initState();
    image = "";
    getImage();
  }

  Future<void> getImage() async {
    final ref = storage.ref().child("inside_ele-removebg-preview.png");
    final url = await ref.getDownloadURL();
    setState(() {
      image = url;
    });
  }

  @override
  Widget build(BuildContext context) {
    final CollectionReference one = FirebaseFirestore.instance.collection("first");
    final CollectionReference second = FirebaseFirestore.instance.collection("second");
    Services _services = Services();
    return Scaffold(
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
                        Container(
                          height: 50,
                          width: 220,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage(image),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Row(
                          children:[
                            Icon(Icons.notifications, size: 25),
                            Gap(10),
                            Icon(Icons.menu, size: 25),
                          ],
                        ),
                      ],
                    ),
                    Card(
                      elevation: 3.5,
                      child: Container(
                        padding:EdgeInsets.all(6),
                        height: MediaQuery.of(context).size.height * 0.06,
                        width: MediaQuery.of(context).size.width * 0.9,
                        child: TextFormField(
                          style:TextStyle(fontSize: 18),
                          decoration:InputDecoration(
                            hintText: 'Search...',
                            suffixIcon: Icon(Icons.search, size: 30),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ),
                    Gap(10),
                    SizedBox(
                      height: 180,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        itemCount: fir.size,
                        itemBuilder: (context, index) {
                          final firsts = fir.docs[index];
                          return Container(
                            margin: EdgeInsets.all(10),
                            padding:EdgeInsets.all(15),
                            width: MediaQuery.of(context).size.width * 0.65,
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
                                  style:TextStyle(
                                    fontSize: 19,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                Gap(60),
                                Container(
                                  height: 30,
                                  width: 160,
                                  color: Colors.white,
                                  child: Center(
                                    child: Text(
                                      "UP TO ${firsts['payment']}% OFF",
                                      style:TextStyle(
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
                        },
                      ),
                    ),
                    Gap(15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [Text(
                          "Categories",
                          style: TextStyle(
                              fontSize: 25, fontWeight: FontWeight.bold),
                        ),
                        Row(
                          children:[
                            Text("See more", style: TextStyle(fontSize: 18)),
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
                            height: 80,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              shrinkWrap: true,
                              itemCount: sec.size,
                              itemBuilder: (context, index) {
                                final second = sec.docs[index];
                                return InkWell(
                                  onTap: (){
                                    Get.toNamed('/pho');
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
                          style: TextStyle(
                              fontSize: 25, fontWeight: FontWeight.bold),
                        ),
                        Row(
                          children:[
                            Text("See more", style: TextStyle(fontSize: 18)),
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
                              childAspectRatio: 0.53,
                            ),
                            itemBuilder: (context, index) {
                              final product = Products[index];
                              return InkWell(
                                onTap: (){
                                  Get.toNamed('/details', arguments: product);
                                  print("${Products.length}");
                                },
                                child: Container(
                                  height: 500,
                                  width: 400,
                                  child: Column(
                                    children: [
                                      Container(
                                        height: 200,
                                        width: double.infinity,
                                        decoration: BoxDecoration(
                                          image: DecorationImage(
                                            image: NetworkImage(product.image),
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              height: 24,
                                              width: 50,
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(6),
                                                color: Colors.black,
                                              ),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  Text(product.rating, style:TextStyle(color: Colors.white),),
                                                  Gap(4),
                                                  Icon(Icons.star, color: Colors.white, size: 20,),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        padding:EdgeInsets.all(5),
                                        height: 150,
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
                                                    fontSize: 17,
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
