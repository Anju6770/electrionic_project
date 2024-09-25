import 'package:electrionic_project/ManageState/order_controller.dart';
import 'package:electrionic_project/model/home.dart';
import 'package:electrionic_project/time_pass/Constant/constants.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
class Cart extends StatefulWidget {
  Cart({super.key});

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
  final OrderController cartController = Get.find<OrderController>();
  bool isExpanded = false;
  @override
  Widget build(BuildContext context) {
    final OrderController orderController = Get.put(OrderController());
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: InkWell(onTap:(){Get.back();}, child: Icon(Icons.arrow_back_ios,color: Colors.black,size: 22,)),
        title: Text("Cart",style: TextStyle(fontSize: 26,fontWeight: FontWeight.bold),),
        centerTitle: true,
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 130,
                    width: MediaQuery.of(context).size.width*0.7,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Delivery Information",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                        Gap(10),
                        Text("You can track your order using the link provided in the email or by entering the tracking number on our website.Once your order has been shipped."),
                      ],
                    ),
                  ),
                  Container(
                    height: 40,
                    width: 100,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(color: Colors.grey),
                      color: Colors.grey.withOpacity(0.2),
                    ),
                    child: Center(child: Text("Change",style: TextStyle(fontSize: 17),)),
                  ),
                ],
              ),
            ),
            Container(
              height: 10,
              width: double.infinity,
              color: Colors.grey.withOpacity(0.2),
            ),
            Gap(20),
            SizedBox(
              height: MediaQuery.of(context).size.height*0.5,
              child:Obx(() {
                return ListView.builder(
                  itemCount: cartController.cartItems.length,
                  itemBuilder: (context, index) {
                    return Container(
                      padding: EdgeInsets.all(5),
                      height: 200,
                      width: double.infinity,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * 0.4,
                            height: 200,
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: NetworkImage(cartController.cartItems[index].image),
                              ),
                            ),
                          ),
                          Gap(5),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    width: MediaQuery.of(context).size.width * 0.4,
                                    child: Text(
                                      cartController.cartItems[index].name,
                                      style: TextStyle(fontSize: 19),
                                      maxLines: 2,
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      cartController.removeFromCart(cartController.cartItems[index]);
                                    },
                                    child: Icon(
                                      Icons.highlight_remove,
                                      size: 30,
                                    ),
                                  ),
                                ],
                              ),
                              Gap(10),
                              Row(
                                children: [
                                  Text(
                                    "\$ ${cartController.cartItems[index].payment}",
                                    style:TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Gap(6),
                                  Text(
                                    "${cartController.cartItems[index].pay}",
                                    style:TextStyle(
                                      fontSize: 17,
                                      color: Colors.grey,
                                      decoration:
                                      TextDecoration.lineThrough,
                                    ),
                                  ),
                                  Gap(5),
                                  Text(
                                    "${cartController.cartItems[index].discount}",
                                    style:TextStyle(
                                        fontSize: 18,
                                        color: Colors.green,fontWeight: FontWeight.bold
                                    ),
                                  ),
                                ],
                              ),
                              Gap(5),
                              Text("${cartController.cartItems[index].only}",style: TextStyle(color: Colors.red,fontSize: 17),),
                              Gap(5),
                              Row(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      cartController.decrementQuantity(
                                          cartController.cartItems[index]);
                                    },
                                    child: Container(
                                      height: 40,
                                      width: 40,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.grey.withOpacity(0.3),
                                      ),
                                      child: Center(
                                        child: Icon(Icons.remove,
                                            color: Colors.black),
                                      ),
                                    ),
                                  ),
                                  Gap(10),
                                  GetBuilder<OrderController>(
                                    builder: (controller) {
                                      return Text(
                                        '${controller.cartItems[index].quantity}',
                                        style: mystyle(18,Colors.black,FontWeight.bold),
                                      );
                                    },
                                  ),
                                  Gap(10),
                                  GestureDetector(
                                    onTap: () {
                                      cartController.incrementQuantity(
                                          cartController.cartItems[index]);
                                    },
                                    child: Container(
                                      height: 40,
                                      width: 40,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.grey.withOpacity(0.3),
                                      ),
                                      child: Center(
                                        child: Icon(Icons.add,
                                            color: Colors.black),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                );
              }),
            ),
            Gap(10),
            Container(
              width: double.infinity,
              height: 10,
              color: Colors.grey.withOpacity(0.2),
            ),
            Gap(10),
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
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.width*0.15,
                    width: MediaQuery.of(context).size.width*0.45,
                    child: GestureDetector(
                      onTap: () {
                        orderController.toggleDelivery(true);
                      },
                      child: Obx(() => Container(
                        padding: EdgeInsets.symmetric(vertical: 12),
                        decoration: BoxDecoration(
                          color: orderController.isDelivery.value
                              ? Colors.black
                              : Colors.white,
                        ),
                        alignment: Alignment.center,
                        child: GetBuilder<OrderController>(builder: (controller) {
                          return Text('Total: \$ ${controller.getTotalPrice().toStringAsFixed(2)}',
                            style: mystyle(20,orderController.isDelivery.value
                                ? Colors.white : Colors.black,FontWeight.bold),
                          );
                        }),
                      )),
                    ),
                  ),
                  Container(
                    height: MediaQuery.of(context).size.width*0.15,
                    width: MediaQuery.of(context).size.width*0.5,
                    child: GestureDetector(
                      onTap: () {
                        Get.toNamed('/delivery');
                        orderController.toggleDelivery(false);
                      },
                      child: Obx(() => Container(
                        padding: EdgeInsets.symmetric(vertical: 12),
                        decoration: BoxDecoration(
                          color: orderController.isDelivery.value
                              ? Colors.white
                              : Colors.black,
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          'Buy Now',
                          style: TextStyle(fontSize: 20,color:  orderController.isDelivery.value
                              ? Colors.black
                              : Colors.white,fontWeight:  FontWeight.bold,
                          ),
                        ),
                      )),
                    ),
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
