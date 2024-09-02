import 'package:carousel_slider/carousel_slider.dart';
import 'package:electrionic_project/Main_page/details_services.dart';
import 'package:electrionic_project/Main_page/services.dart';
import 'package:electrionic_project/ManageState/order_controller.dart';
import 'package:electrionic_project/model/Third_model.dart';
import 'package:electrionic_project/model/home.dart';
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
  final List<String> imageUrls = [
    'https://i.pinimg.com/236x/26/ea/50/26ea5063cbe4d6ccd123f9ab207a1f24.jpg',
    'https://i.pinimg.com/236x/81/ea/23/81ea2336b52355455f05518292bf76be.jpg',
    'https://i.pinimg.com/236x/c9/26/64/c92664b7a33d9c0d8babdd0e1a77336b.jpg',
    'https://i.pinimg.com/236x/67/c3/22/67c3228c2f79710f391c02182d224438.jpg',
    'https://i.pinimg.com/236x/68/79/6d/68796df5a7d46dd889deb346b89550b4.jpg'
  ];
  @override
  Widget build(BuildContext context) {
    final OrderController orderController = Get.put(OrderController());
    DetailsServices _services = DetailsServices();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: InkWell(onTap:(){Get.back();}, child: Icon(Icons.arrow_back_ios,color: Colors.black,size: 22,)),
        actions: [
          Icon(Icons.search,color: Colors.black,size: 24,),
          Gap(20),
          InkWell(
              onTap: (){
                Get.toNamed('/cart',arguments: widget.details);
              },
              child: Icon(Icons.shopping_cart,color: Colors.black,size: 22,),
          )
        ],
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
                height: 300,
                width: double.infinity,
                child: Image.network("${widget.details.image}",fit: BoxFit.fill,)),
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
                          height: 25,
                          width: 50,
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
                      InkWell(
                        onTap: () {
                          setState(() {
                            favorite = !favorite;
                          });
                        },
                        child: Container(
                          height: 30,
                          width: 30,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.grey.withOpacity(0.2),
                          ),
                          child: Icon(
                            favorite ? Icons.favorite : Icons.favorite_border,
                            size: 23,
                          ),
                        ),
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
                        height: 60,
                        width: 110,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.grey),
                          color: Colors.grey.withOpacity(0.2),
                        ),
                        child: Center(child: Text("Free Delivery")),
                      ),
                      Container(
                        padding: EdgeInsets.all(6),
                        height: 60,
                        width: 110,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.grey),
                          color: Colors.grey.withOpacity(0.2),
                        ),
                        child: Center(child: Text("No Cost \$200/month")),
                      ),
                      Container(
                        height: 60,
                        width: 110,
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
                  Gap(10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text("Rating & Reviews",style: TextStyle(fontSize: 19,fontWeight: FontWeight.bold),),
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
                  Gap(15),
                  Row(
                    children: [
                      Text("${widget.details.rating}",style: TextStyle(fontSize: 50),),
                      Icon(Icons.star,size: 50,),
                    ],
                  ),
                  Container(
                      width: MediaQuery.of(context).size.width*0.3,
                      child: Text("60 ratings and 11 views",style: TextStyle(fontSize: 19,color: Colors.grey),maxLines: 2,)
                  ),
                  Gap(20),
                  CarouselSlider(
                    options: CarouselOptions(
                      height: 200,
                      enlargeCenterPage: true,
                      enlargeFactor: 0.8,
                    ),
                    items: imageUrls.map((imageUrl) {
                      return Builder(
                        builder: (BuildContext context) {
                          return Container(
                            width: MediaQuery.of(context).size.width,
                            margin: EdgeInsets.symmetric(horizontal: 5.0),
                            decoration: BoxDecoration(
                              color: Colors.white,
                            ),
                            child: Container(
                              height: 250,
                              width: 180,
                              decoration: BoxDecoration(
                                image: DecorationImage(image: NetworkImage(imageUrl),fit: BoxFit.cover,)
                              ),
                            ),
                          );
                        },
                      );
                    }).toList(),
                  ),
                  Divider(),
                  Gap(20),
                  Row(
                    children: [
                      Container(
                          height: 25,
                          width: 50,
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
                    height: 150,
                    width: 100,
                    decoration: BoxDecoration(
                      image: DecorationImage(image: NetworkImage("${widget.details.image}"),fit: BoxFit.cover),
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
                          height: 25,
                          width: 50,
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
                  Gap(5),
                  Container(
                    width: double.infinity,
                    height: 1,
                    color: Colors.grey,
                  ),
                  Row(
                    children: [
                      Container(
                        height: 50,
                        width: 190,
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
                            child: Text(
                              'Add To Cart',
                              style: TextStyle(fontSize: 17,color:  orderController.isDelivery.value
                                  ? Colors.white : Colors.black,fontWeight:  FontWeight.bold
                              ),
                            ),
                          )),
                        ),
                      ),
                      Container(
                        height: 50,
                        width: 185,
                        child: GestureDetector(
                          onTap: () {
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
                              style: TextStyle(fontSize: 17,color:  orderController.isDelivery.value
                                  ? Colors.black
                                  : Colors.white,fontWeight:  FontWeight.bold,
                              ),
                            ),
                          )),
                        ),
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
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Similar Products",style: TextStyle(fontSize: 24),),
                    ],
                  ),
                  Gap(40),
                  Container(
                    width: double.infinity,
                    height: 1,
                    color: Colors.grey,
                  ),
                  StreamBuilder<List<ThirdModel>>(
                    stream: _services.fetchItems(),
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
                          crossAxisSpacing: 0,
                          mainAxisSpacing: 0,
                          childAspectRatio: 0.52,
                        ),
                        itemBuilder: (context, index) {
                          final product = Products[index];
                          return Container(
                            padding: EdgeInsets.all(3),
                            height: 500,
                            width: 340,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.grey)
                            ),
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
                                            product.payment,
                                            style:TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Text(
                                            product.pay,
                                            style:TextStyle(
                                              fontSize: 15,
                                              color: Colors.grey,
                                              decoration:
                                              TextDecoration.lineThrough,
                                            ),
                                          ),
                                          Gap(3),
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
                          );
                        },
                      );
                    },
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

