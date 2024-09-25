import 'package:electrionic_project/time_pass/Constant/constants.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
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
        leading: InkWell(onTap: (){Get.back();}, child: Icon(Icons.arrow_back_ios,size: 25,)),
        title: Text("Purchase",style: mystyle(30),),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: [
            Gap(60),
            Lottie.asset('assets/lottie/Animation - 1727244628436.json', height: 200),
            Text("Products is on the way",style: mystyle(30),),
            Gap(30),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Text("Delivery by ",style: TextStyle(fontSize: 18),),
                  Text("Soname Dorji",style: TextStyle(fontSize: 19,fontWeight: FontWeight.bold),),
                  Gap(25),
                  Container(
                    height: 20,
                    width: 2,
                    color: Colors.black,
                  ),
                  Gap(25),
                  Text("Free",style: TextStyle(fontSize: 19,color: Colors.green,fontWeight: FontWeight.bold),),
                  Gap(8),
                  Text("\$ 45",style: TextStyle(fontSize: 18,color: Colors.grey,decoration: TextDecoration.lineThrough),),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
