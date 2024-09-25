import 'package:get/get.dart';

class FavController extends GetxController {
  // var favItems = <Map<String, dynamic>>[].obs;
  var favItems = [].obs;

  var wishlist = <String, bool>{}.obs;

  void toggleWishlist(String productId, Map<String, dynamic> product) {
    print('Toggle Wishlist Called - Product ID: $productId');
    if (wishlist.containsKey(productId)) {
      if (wishlist[productId]!) {
        removeFromWishlist(productId);
      } else {
        wishlist[productId] = true;
        addToFav(product);
      }
    } else {
      wishlist[productId] = true;
      addToFav(product);
    }
    print(
        'Wishlist Updated - Product ID: $productId, In Wishlist: ${wishlist[productId]}');
  }

  void addToFav(Map<String, dynamic> product) {
    String productId = product['id'];
    if (productId == null) {
      throw Exception('Product does not have an ID');
    }

    bool exists = favItems.any((item) => item['id'] == productId);
    if (!exists) {
      favItems.add(product);
      print('Product added to favItems: $productId');
    }
  }

  bool isInWishlist(String productId) {
    return wishlist[productId] ?? false;
  }

  void removeFromWishlist(String productId) {
    print('Remove from Wishlist Called - Product ID: $productId');
    favItems.removeWhere((item) => item['id'] == productId);
    wishlist.remove(productId);
    print('Removed from Wishlist - Product ID: $productId');
    print('Current favItems length: ${favItems.length}');
  }

  String get totalItems => favItems.length.toString();
}
