import 'package:electrionic_project/time_pass/Constant/constants.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:url_launcher/url_launcher.dart';
class PurchasePage extends StatefulWidget {
  const PurchasePage({super.key});

  @override
  State<PurchasePage> createState() => _PurchasePageState();
}

class _PurchasePageState extends State<PurchasePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: InkWell(onTap: (){Get.offAllNamed('button');}, child: Icon(Icons.arrow_back,size: 27,)),
        title: Text("Order Tracking",style: mystyle(30),),
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Center(
            child: Column(
              children: [
                Text("ORDER PLACED",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                Text("Your order is placed sucessfully",style: TextStyle(color: Colors.grey,fontSize: 18),),
                Gap(4),
                Container(
                  height: MediaQuery.of(context).size.height*0.13,
                  width: MediaQuery.of(context).size.width*0.4,
                  decoration: BoxDecoration(
                    image: DecorationImage(image: AssetImage("assets/image/gift.png"))
                  ),
                ),
                Gap(20),
                Text("ON THE WAY",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                Text("Soon the products will be Delivered",style: TextStyle(color: Colors.grey,fontSize: 18),),
                Container(
                  height: MediaQuery.of(context).size.height*0.15,
                  width: MediaQuery.of(context).size.width*0.4,
                  decoration: BoxDecoration(
                      image: DecorationImage(image: AssetImage("assets/image/car.png"),fit: BoxFit.cover)
                  ),
                ),
                Gap(20),
                Text("PRODUCT DELIVERED",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                Text("We will deliver your product",style: TextStyle(color: Colors.grey,fontSize: 18),),
                Gap(4),
                Container(
                  height: MediaQuery.of(context).size.height*0.13,
                  width: MediaQuery.of(context).size.width*0.4,
                  decoration: BoxDecoration(
                      image: DecorationImage(image: AssetImage("assets/image/opened_gift.png"))
                  ),
                ),
                Gap(20),
                InkWell(
                    onTap:(){
                      launchUrl(
                        Uri.parse("tel: +975-77665544"),
                      );
                    },
                    child: Text("HELP LINE: +975-77665544",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
