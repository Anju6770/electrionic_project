import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:electrionic_project/model/home.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class HomeController extends GetxController {
  var searchController = TextEditingController();
  RxList<HomeModel> filteredData = <HomeModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchProducts();
  }

  void fetchProducts() async {
    var homeCollection = FirebaseFirestore.instance.collection('home');
    var snapshot = await homeCollection.get();
    var products = snapshot.docs
        .map((doc) => HomeModel.fromMap(doc.data()))
        .toList();

    filteredData.value = products;
  }

  void filterSearchResults(String query) {
    if (query.isEmpty) {
      fetchProducts();
    } else {
      filteredData.value = filteredData
          .where((product) =>
          product.name.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
  }
}


// MaterialButton(
//   minWidth: 300,
//   color: Colors.blue,
//   onPressed: () async {
//      //_auth.logout();
//     _auth.google_signout();
//     Get.offAllNamed('/log');
//   },
//   child: Text(
//     "Logout",
//     style: TextStyle(color: Colors.white),
//   ),
// ),
