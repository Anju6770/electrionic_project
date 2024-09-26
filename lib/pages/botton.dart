import 'package:electrionic_project/ManageState/fav_controller.dart';
import 'package:electrionic_project/ManageState/order_controller.dart';
import 'package:electrionic_project/pages/cart.dart';
import 'package:electrionic_project/pages/fav_page.dart';
import 'package:electrionic_project/pages/home_page.dart';
import 'package:electrionic_project/time_pass/Constant/constants.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class buttom extends StatelessWidget {
  final OrderController ms = Get.find<OrderController>();
  final FavController cg = Get.find<FavController>();

  final List<Widget> _screens = [HomePage(), FavPage(),Cart(),];

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OrderController>(
      builder: (_) {
        return GetBuilder<FavController>(
          builder: (_){
            return Scaffold(
              body: _screens[ms.currentIndex],
              bottomNavigationBar: BottomNavigationBar(
                currentIndex: ms.currentIndex,
                onTap: (index) {
                  ms.setCurrentIndex(index);
                },
                items: [
                  BottomNavigationBarItem(
                    icon: Icon(
                      Icons.home_filled,size: 30,
                      color: ms.currentIndex == 0 ? Colors.black : Colors.grey,
                    ),
                    label: 'Home',
                  ),
                  BottomNavigationBarItem(
                    icon: Stack(clipBehavior: Clip.none,
                        children:[ Icon(
                          Icons.favorite_outlined,
                          color: cg.currentIndex == 1? Colors.black : Colors.grey,
                        ),
                          Positioned(
                            left: 14,bottom: 15,
                            child: Container(
                              height: 17,
                              width: 17,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  color: Colors.red
                              ),
                              child: Center(
                                child: Text(
                                  '${cg.totalItems.toString()}',  // Update this to show the actual cart count
                                  style: mystyle(12, Colors.white, FontWeight.bold),
                                ),
                              ),
                            ),
                          ),
                        ]),
                    label: 'Favorites',
                  ),
                  BottomNavigationBarItem(
                    icon: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Icon(
                          Icons.shopping_cart,
                          color: ms.currentIndex == 2 ? Colors.black : Colors.grey,
                        ),
                        Positioned(
                          bottom: 15,
                          left: 17,
                          child: Container(
                            height: 17,
                            width: 17,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Colors.red,
                            ),
                            child: Center(
                              child: Text(
                                '${ms.totalItems.toString()}',  // Update this to show the actual cart count
                                style: mystyle(12, Colors.white, FontWeight.bold),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    label: 'Cart',
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
