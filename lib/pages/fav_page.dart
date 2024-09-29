import 'package:electrionic_project/ManageState/fav_controller.dart';
import 'package:electrionic_project/time_pass/Constant/constants.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';

class FavPage extends StatelessWidget {
  FavPage({super.key});

  @override
  Widget build(BuildContext context) {
    final FavController favController = Get.find<FavController>();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(
            color: Colors.black,size: 27
        ),
        title: Text("Favorite",style: mystyle(28),),
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: GetBuilder<FavController>(
          builder: (_) {
            return ListView.builder(
              itemCount: favController.favItems.length,
              itemBuilder: (context, index) {
                final item = favController.favItems[index];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: Material(
                    borderRadius: BorderRadius.circular(10),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white
                      ),
                      child: Row(
                        children: [
                          Container(
                            height: MediaQuery.of(context).size.height*0.2,
                            width: MediaQuery.of(context).size.width*0.3,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.blue.withOpacity(0.1),
                              image: DecorationImage(
                                image: NetworkImage(item['image']),
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 20),
                              child: Column(
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                children: [
                                  Text(item['name'],style: TextStyle(fontSize: 20),),
                                  Gap(5),
                                  Row(
                                    children: [
                                      Text('\$ ${item['payment']}',style: TextStyle(fontSize: 19,fontWeight: FontWeight.bold),),
                                      Gap(6),
                                      Text(
                                        "${item['pay']}",
                                        style:TextStyle(
                                          fontSize: 17,
                                          color: Colors.grey,
                                          decoration:
                                          TextDecoration.lineThrough,
                                        ),
                                      ),
                                      Gap(5),
                                      Text(
                                        "${item['discount']}",
                                        style:TextStyle(
                                            fontSize: 18,
                                            color: Colors.green,fontWeight: FontWeight.bold
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
