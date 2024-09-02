import 'package:electrionic_project/model/home.dart';
import 'package:get/get.dart';

class OrderController extends GetxController {

  var isDelivery = true.obs;
  var quantity = 1.obs;

  void toggleDelivery(bool value) {
    isDelivery.value = value;
  }

  void increaseQuantity() {
    quantity.value++;
  }

  void decreaseQuantity() {
    if (quantity.value > 1) {
      quantity.value--;
    }
  }
  //
  // double calculateTotal() {
  //   double total = 0;
  //   for (var product in ) {
  //     total += product.payment * product.quantity;
  //   }
  //   return total;
  // }
}
