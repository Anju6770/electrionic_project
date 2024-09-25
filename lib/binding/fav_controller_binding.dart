import 'package:electrionic_project/ManageState/fav_controller.dart';
import 'package:get/get.dart';

class FavControllerBinding with Bindings {
  @override
  void dependencies() {
    // Initialize CartController
    Get.lazyPut<FavController>(() => FavController());
  }
}
