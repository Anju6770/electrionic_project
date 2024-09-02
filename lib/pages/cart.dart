import 'package:electrionic_project/ManageState/order_controller.dart';
import 'package:electrionic_project/model/home.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
class Cart extends StatefulWidget {
  Cart({super.key});
  HomeModel details = Get.arguments;

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> {
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
            Container(
              padding: EdgeInsets.all(5),
              height: 200,
              width: double.infinity,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width*0.4,
                    height: 200,
                    decoration: BoxDecoration(
                      image: DecorationImage(image: NetworkImage("${widget.details.image}")),
                    ),
                  ),
                  Gap(5),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width*0.55,
                        child: Text("${widget.details.name}",style: TextStyle(fontSize: 19),maxLines: 2,),
                      ),
                      Gap(10),
                      Row(
                        children: [
                          Text(
                            "${widget.details.payment}",
                            style:TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                          Gap(6),
                          Text(
                            "${widget.details.pay}",
                            style:TextStyle(
                              fontSize: 17,
                              color: Colors.grey,
                              decoration:
                              TextDecoration.lineThrough,
                            ),
                          ),
                          Gap(5),
                          Text(
                            "${widget.details.discount}",
                            style:TextStyle(
                                fontSize: 18,
                                color: Colors.green,fontWeight: FontWeight.bold
                            ),
                          ),
                        ],
                      ),
                      Gap(5),
                      Text("${widget.details.only}",style: TextStyle(color: Colors.red,fontSize: 17),),
                      Gap(5),
                      Container(
                        height: 35,
                        width: 110,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.grey.withOpacity(0.2),
                        ),
                        child: Row(
                          children: [
                            IconButton(
                              onPressed: orderController.decreaseQuantity,
                              icon: Icon(Icons.remove),
                            ),
                            Obx(() => Text(orderController.quantity.value.toString(),style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),)),
                            IconButton(
                              onPressed: orderController.increaseQuantity,
                              icon: Icon(Icons.add),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
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
                  Text("15 Oct,Wednesday",style: TextStyle(fontSize: 19,fontWeight: FontWeight.bold),),
                  Gap(10),
                  Container(
                    height: 20,
                    width: 2,
                    color: Colors.black,
                  ),
                  Gap(10),
                  Text("Free",style: TextStyle(fontSize: 19,color: Colors.green,fontWeight: FontWeight.bold),),
                  Gap(8),
                  Text("\$ 45",style: TextStyle(fontSize: 18,color: Colors.grey,decoration: TextDecoration.lineThrough),),
                ],
              ),
            ),
            Divider(),
            Text("Products Total",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Total MRP ",style: TextStyle(fontSize: 18,color: Colors.grey),),
                      Text("${widget.details.pay}",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                    ],
                  ),
                  Gap(5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Total Discount ",style: TextStyle(fontSize: 18,color: Colors.grey),),
                      Text("\$ ${widget.details.dispay}",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                    ],
                  ),
                  Gap(5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Selling Price",style: TextStyle(fontSize: 18,color: Colors.grey),),
                      Text("${widget.details.payment}",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                    ],
                  ),
                  Gap(5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Shopping Fee",style: TextStyle(fontSize: 18,color: Colors.grey),),
                      Text("Free",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold,color: Colors.green),),
                    ],
                  ),
                ],
              ),
            ),
            Divider(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Amount Payable",style: TextStyle(fontSize: 18),),
                  Text("${widget.details.payment}",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                ],
              ),
            ),
            Container(
              height: 80,
              width: double.infinity,
              color: Colors.black,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Total Price",style: TextStyle(fontSize: 22,color: Colors.white,fontWeight: FontWeight.bold),),
                  Gap(20),
                  Text("${widget.details.payment}",style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold,color: Colors.white),),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
