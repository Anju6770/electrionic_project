import 'package:electrionic_project/Main_page/details_services.dart';
import 'package:electrionic_project/ManageState/fav_controller.dart';
import 'package:electrionic_project/ManageState/order_controller.dart';
import 'package:electrionic_project/model/home.dart';
import 'package:electrionic_project/pages/fav_page.dart';
import 'package:electrionic_project/time_pass/Constant/constants.dart';
import 'package:badges/badges.dart' as badges;
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
class HomeDetails extends StatefulWidget {
   HomeDetails({super.key});
   HomeModel details = Get.arguments;
  @override
  State<HomeDetails> createState() => _HomeDetailsState();
}

class _HomeDetailsState extends State<HomeDetails> {
  bool isExpanded = false;
  bool favorite = false;
  @override
  Widget build(BuildContext context) {
    final OrderController cartController = Get.find<OrderController>();
    final FavController favController = Get.find<FavController>();
    DetailsServices _services = DetailsServices();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(
            color: Colors.black,size: 27
        ),
        actions: [
          Obx(() => InkWell(
            onTap: () {
              Get.to(FavPage());
            },
            child: badges.Badge(
              badgeStyle: badges.BadgeStyle(badgeColor: Colors.red),
              position: badges.BadgePosition.topEnd(top: -13, end: -8),
              badgeContent: Text(favController.totalItems.toString(),style: TextStyle(color: Colors.white),),
              child: Icon(Icons.favorite),
            ),
          )),
          const Gap(16),
          Obx(() => InkWell(
            onTap: () {
              Get.toNamed('/cart');
            },
            child: badges.Badge(
              badgeStyle: badges.BadgeStyle(badgeColor: Colors.red,),
              position: badges.BadgePosition.topEnd(top: -13, end: -8),
              badgeContent: Text(cartController.totalItems.toString(),style: TextStyle(color: Colors.white),),
              child: Icon(Icons.shopping_cart),
            ),
          )),
          const SizedBox(width: 16),
        ],
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Hero(
              tag: widget.details.image,
              child: Container(
                  height: MediaQuery.of(context).size.height*0.4,
                  width: double.infinity,
                  child: Image.network("${widget.details.image}",fit: BoxFit.fill,)),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    isExpanded
                        ? widget.details.name
                        : widget.details.name.substring(0,35) + '...',
                    style: TextStyle(fontSize: 20,),
                  ),
                  Gap(8),
                  InkWell(
                    onTap: () {
                      setState(() {
                        isExpanded = !isExpanded;
                      });
                    },
                    child: Text(
                      isExpanded ? "Show Less" : "Read More",
                      style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold,),
                    ),
                  ),
                  Gap(20),
                  Row(
                    children: [
                      Container(
                          height: MediaQuery.of(context).size.height*0.04,
                          width: MediaQuery.of(context).size.width*0.15,
                          decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("${widget.details.rating}",style: TextStyle(color: Colors.white,fontSize: 18),),
                              Gap(5),
                              Icon(Icons.star,color: Colors.white,size: 20,),
                            ],
                          )
                      ),
                      Gap(5),
                      Text("(90 Rating)",style: TextStyle(fontSize: 15,color: Colors.grey),),
                    ],
                  ),
                  Gap(10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("\$ ${widget.details.payment}",style: TextStyle(fontSize: 27,fontWeight: FontWeight.bold),),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Obx(() => GestureDetector(
                          onTap: () {
                            favController.toggleWishlist(widget.details.id, widget.details.toMap()); // Assuming widget.details.toMap() exists
                            if (favController.isInWishlist(widget.details.id)) {
                              Get.snackbar('Success', 'Product added to Favorite',
                                  snackPosition: SnackPosition.BOTTOM,
                                  backgroundColor: Colors.black87,
                                  colorText: Colors.white,
                                  duration: Duration(seconds: 2));
                            } else {
                              Get.snackbar('Removed', 'Product removed from Favorite',
                                  snackPosition: SnackPosition.BOTTOM,
                                  backgroundColor: Colors.black87,
                                  colorText: Colors.white,
                                  duration: Duration(seconds: 2));
                            }
                          },
                          child: Icon(
                            favController.isInWishlist(widget.details.id) ? Icons.favorite : Icons.favorite_border,
                            color: favController.isInWishlist(widget.details.id) ? Colors.red : Color(0xff000814),
                          ),
                        )),
                      ),
                    ],
                  ),
                  Divider(color: Colors.grey,),
                  Text("Available Offers",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
                  Gap(6),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(Icons.discount,size: 20,),
                      Gap(8),
                      Container(
                          width: MediaQuery.of(context).size.width*0.85,
                          child: Text("${widget.details.brief1}",maxLines: 3,)),
                    ],
                  ),
                  Gap(10),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(Icons.discount,size: 20,),
                      Gap(8),
                      Container(
                          width: MediaQuery.of(context).size.width*0.85,
                          child: Text("${widget.details.brief2}",maxLines: 3,)),
                    ],
                  ),
                  Gap(10),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(Icons.discount,size: 20,),
                      Gap(8),
                      Container(
                          width: MediaQuery.of(context).size.width*0.85,
                          child: Text("${widget.details.brief3}",maxLines: 3,)),
                    ],
                  ),
                  Divider(color: Colors.grey,),
                  Gap(10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.height*0.08,
                        width: MediaQuery.of(context).size.width*0.3,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.grey),
                          color: Colors.grey.withOpacity(0.2),
                        ),
                        child: Center(child: Text("Free Delivery")),
                      ),
                      Container(
                        padding: EdgeInsets.all(6),
                        height: MediaQuery.of(context).size.height*0.08,
                        width: MediaQuery.of(context).size.width*0.3,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.grey),
                          color: Colors.grey.withOpacity(0.2),
                        ),
                        child: Center(child: Text("No Cost \$200/month")),
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height*0.08,
                        width: MediaQuery.of(context).size.width*0.3,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.grey),
                          color: Colors.grey.withOpacity(0.2),
                        ),
                        child: Center(child: Text("Exchange")),
                      ),
                    ],
                  ),
                 Gap(20),
                 Container(
                   width: double.infinity,
                   height: 1.2,
                   color: Colors.grey,
                 ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.share),
                          Gap(5),
                          Text("Share",style: TextStyle(fontSize: 17)),
                        ],
                      ),
                      Container(
                        height: 40,
                        width: 1.2,
                        color: Colors.grey,
                      ),
                      Row(
                        children: [
                          Icon(Icons.add_to_home_screen),
                          Gap(5),
                          Text("Add to Compare",style: TextStyle(fontSize: 16),),
                        ],
                      ),
                    ],
                  ),
                  Container(
                    width: double.infinity,
                    height: 10,
                    color: Colors.grey.withOpacity(0.2),
                  ),
                  Gap(20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text("Deliver Ahmedabad - 756467",style: TextStyle(fontSize: 18),),
                      Container(
                        height: MediaQuery.of(context).size.height*0.05,
                        width: MediaQuery.of(context).size.width*0.3,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(color: Colors.grey),
                          color: Colors.grey.withOpacity(0.2),
                        ),
                        child: Center(child: Text("Change",style: TextStyle(fontSize: 17),)),
                      ),
                    ],
                  ),
                  Divider(),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Delivery by",style: TextStyle(fontSize: 18),),
                        Row(
                          children: [
                            Text("15 Oct,Wednesday",style: TextStyle(fontSize: 19,fontWeight: FontWeight.bold),),
                            Gap(20),
                            Container(
                              height: 20,
                              width: 2,
                              color: Colors.black,
                            ),
                            Gap(20),
                            Text("Free",style: TextStyle(fontSize: 19,color: Colors.green,fontWeight: FontWeight.bold),),
                            Gap(8),
                            Text("\$ 45",style: TextStyle(fontSize: 18,color: Colors.grey,decoration: TextDecoration.lineThrough),),
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
                        Text("View More",style: TextStyle(fontSize: 17)),
                        Icon(Icons.arrow_forward_ios_outlined,size: 20,color: Colors.black,),
                      ],
                    ),
                  ),
                  Divider(),
                  Gap(5),
                  Text("Shipping Methods",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                  Gap(10),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(Icons.fiber_manual_record,size: 15,),
                      Gap(10),
                      Container(
                          width: MediaQuery.of(context).size.width*0.8,
                          child: Text("5-7 business days. Costs \$5.99",style: TextStyle(fontSize: 18),)),
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(Icons.fiber_manual_record,size: 15,),
                      Gap(10),
                      Container(
                          width: MediaQuery.of(context).size.width*0.8,
                          child: Text("2-3 business days. Costs \$12.99",style: TextStyle(fontSize: 18),)),
                    ],
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(Icons.fiber_manual_record,size: 15,),
                      Gap(10),
                      Container(
                          width: MediaQuery.of(context).size.width*0.8,
                          child: Text(" Next business day. Costs \$24.99.",style: TextStyle(fontSize: 18),)),
                    ],
                  ),
                  Divider(),
                  Gap(5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("View More",style: TextStyle(fontSize: 17)),
                      Icon(Icons.arrow_forward_ios_outlined,size: 20,color: Colors.black,),
                    ],
                  ),
                  Gap(10),
                  Container(
                    width: double.infinity,
                    height: 10,
                    color: Colors.grey.withOpacity(0.2),
                  ),
                  Gap(10),
                  Text("Delivery Areas",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold)),
                  Gap(10),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(Icons.fiber_manual_record,size: 15,),
                      Gap(10),
                      Container(
                          width: MediaQuery.of(context).size.width*0.8,
                          child: Text(" We currently ship to addresses within the Bhutan. International shipping is not available at this time.",style: TextStyle(fontSize: 18),)
                      ),
                    ],
                  ),
                  Divider(),
                  Gap(5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("View More",style: TextStyle(fontSize: 17)),
                      Icon(Icons.arrow_forward_ios_outlined,size: 20,color: Colors.black,),
                    ],
                  ),
                  Gap(5),
                  Container(
                    width: double.infinity,
                    height: 10,
                    color: Colors.grey.withOpacity(0.2),
                  ),
                  Gap(10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text("Rating & Reviews",style: TextStyle(fontSize: 19,fontWeight: FontWeight.bold),),
                      Container(
                          height: MediaQuery.of(context).size.height*0.05,
                          width: MediaQuery.of(context).size.width*0.3,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          border: Border.all(color: Colors.grey),
                          color: Colors.grey.withOpacity(0.2),
                        ),
                        child: Center(child: Text("Change",style: TextStyle(fontSize: 17),)),
                      ),
                    ],
                  ),
                  Gap(15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Text("${widget.details.rating}",style: TextStyle(fontSize: 50),),
                          Gap(10),
                          Icon(Icons.star,size: 50,),
                        ],
                      ),
                      Row(
                        children: [
                          Container(
                              width: MediaQuery.of(context).size.width*0.6,
                              child: Text("60 ratings and 11 views",style: TextStyle(fontSize: 19,color: Colors.grey),maxLines: 2,)
                          ),
                        ],
                      ),
                    ],
                  ),
                  Gap(20),
                  Divider(),
                  Gap(20),
                  Row(
                    children: [
                      Container(
                          height: MediaQuery.of(context).size.height*0.04,
                          width: MediaQuery.of(context).size.width*0.15,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Colors.black
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("4.3",style: TextStyle(fontSize: 18,color: Colors.white),),
                              Icon(Icons.star,color: Colors.white,size: 18,),
                            ],
                          )
                      ),
                      Gap(20),
                      Text("One of the Best Products",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                    ],
                  ),
                  Gap(10),
                  Text("Factors like frequency response, impedance, and driver size influence sound quality. Higher impedance headphones generally offer better sound quality but may require more powerful audio sources."),
                  Gap(10),
                  Container(
                    height: MediaQuery.of(context).size.height*0.4,
                    width: MediaQuery.of(context).size.width*0.9,
                    decoration: BoxDecoration(
                      image: DecorationImage(image: NetworkImage("${widget.details.image}"),fit: BoxFit.fill),
                    ),
                  ),
                  Gap(10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Jabra Headset",style: TextStyle(fontSize: 18,color: Colors.grey),),
                      Row(
                        children: [
                          Row(
                            children: [
                              Icon(Icons.thumb_up,size: 20,color: Colors.grey,),
                              Gap(10),
                              Text("100",style: TextStyle(fontSize: 16,color: Colors.grey),),
                            ],
                          ),
                          Gap(20),
                          Row(
                            children: [
                              Icon(Icons.thumb_down,size: 20,color: Colors.grey,),
                              Gap(10),
                              Text("10",style: TextStyle(fontSize: 16,color: Colors.grey),),
                            ],
                          ),
                          Gap(20),
                          Icon(Icons.more_vert),
                        ],
                      ),
                    ],
                  ),
                  Gap(5),
                  Row(
                    children: [
                      Icon(Icons.check_circle,color: Colors.grey,size: 18,),
                      Gap(10),
                      Text("Buyer - 3 months",style: TextStyle(fontSize: 18,color: Colors.grey),),
                    ],
                  ),
                  Divider(),
                  Row(
                    children: [
                      Container(
                          height: MediaQuery.of(context).size.height*0.04,
                          width: MediaQuery.of(context).size.width*0.15,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Colors.black
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text("4.3",style: TextStyle(fontSize: 18,color: Colors.white),),
                              Icon(Icons.star,color: Colors.white,size: 18,),
                            ],
                          )
                      ),
                      Gap(20),
                      Text("Comfort",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
                    ],
                  ),
                  Gap(10),
                  Text("Padding, adjustability, and the material of the ear cups and headband affect comfort. For in-ear models, various ear tip sizes and materials can enhance comfort and fit."),
                  Gap(10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Leistungs starke",style: TextStyle(fontSize: 18,color: Colors.grey),),
                      Row(
                        children: [
                          Row(
                            children: [
                              Icon(Icons.thumb_up,size: 20,color: Colors.grey,),
                              Gap(10),
                              Text("90",style: TextStyle(fontSize: 16,color: Colors.grey),),
                            ],
                          ),
                          Gap(20),
                          Row(
                            children: [
                              Icon(Icons.thumb_down,size: 20,color: Colors.grey,),
                              Gap(10),
                              Text("11",style: TextStyle(fontSize: 16,color: Colors.grey),),
                            ],
                          ),
                          Gap(20),
                          Icon(Icons.more_vert),
                        ],
                      ),
                    ],
                  ),
                  Gap(5),
                  Row(
                    children: [
                      Icon(Icons.check_circle,color: Colors.grey,size: 18,),
                      Gap(10),
                      Text("Buyer - 3 months",style: TextStyle(fontSize: 18,color: Colors.grey),),
                    ],
                  ),
                  Gap(10),
                  GestureDetector(
                    onTap: () {
                      bool added = cartController.addToCart(widget.details);
                      if (added) {
                        Get.snackbar(
                          'Added to Cart',
                          'Product added to cart successfully',
                          snackPosition: SnackPosition.BOTTOM,
                          backgroundColor: Colors.black87,
                          colorText: Colors.white,
                          duration: Duration(seconds: 2),
                        );
                      } else {
                        Get.snackbar(
                          'Product exist',
                          'Product is already in the cart',
                          snackPosition: SnackPosition.BOTTOM,
                          backgroundColor: Colors.black87,
                          colorText: Colors.white,
                          duration: Duration(seconds: 2),
                        );
                      }
                    },
                    child: Container(
                      height: MediaQuery.of(context).size.height*0.06,
                      width: MediaQuery.of(context).size.width*0.99,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.black,
                      ),
                      child:Center(child: Text("ADD TO CART",style: mystyle(18,Colors.white,FontWeight.bold),))
                    ),
                  ),
                  Gap(6),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

