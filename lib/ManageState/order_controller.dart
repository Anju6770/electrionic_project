import 'package:electrionic_project/model/home.dart';
import 'package:get/get.dart';

class OrderController extends GetxController {
  var cartItems = <HomeModel>[].obs;
  var totalPrice = 0.0.obs;

  bool addToCart(HomeModel product) {
    if (product.id == null) {
      print('Product does not have an ID');
      return false;
    }

    bool exists = cartItems.any((item) => item.id == product.id);

    if (!exists) {
      cartItems.add(
          product);
      return true;
    } else {
      return false;
    }
  }

  void removeFromCart(HomeModel product) {
    cartItems.removeWhere((item) => item.id == product.id);
    update();
  }

  int get totalItems => cartItems.length;

  void incrementQuantity(HomeModel product) {
    product.quantity++;
    update();
  }

  void decrementQuantity(HomeModel product) {
    if (product.quantity > 0) {
      product.quantity--;
      update();
    }
  }

  double getTotalPrice() {
    return cartItems.fold(0, (total, item) {
      return total + (item.payment*item.quantity);
    });
  }

  var isDelivery = true.obs;
  var quantity = 1.obs;

  void toggleDelivery(bool value) {
    isDelivery.value = value;
  }

  int currentIndex = 0;

  void setCurrentIndex(int index) {
    currentIndex = index;
    update(); // Notify listeners to rebuild
  }
}
