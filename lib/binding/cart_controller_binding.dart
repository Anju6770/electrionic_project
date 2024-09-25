import 'package:electrionic_project/ManageState/order_controller.dart';
import 'package:get/get.dart';

class CartControllerBinding with Bindings {
  @override
  void dependencies() {
    // Initialize CartController
    Get.lazyPut<OrderController>(() => OrderController());
  }
}
