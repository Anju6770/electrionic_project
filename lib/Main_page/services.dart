import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:electrionic_project/model/home.dart';

class Services {
  // Stream<QuerySnapshot> fetchProducts() {
  //   final Stream<QuerySnapshot> _taskStream;
  //   _taskStream = FirebaseFirestore.instance.collection('home').snapshots();
  //   return _taskStream;
  // }
  Future<void> addPlace(HomeModel place) async {
    final docRef = FirebaseFirestore.instance.collection('places').doc();
    place.id = docRef.id;
    await docRef.set(place.toMap());
  }
  Stream<List<HomeModel>> fetchProducts() {
    return FirebaseFirestore.instance.collection('home').snapshots().map(
            (snapshot) => snapshot.docs
            .map((doc) => HomeModel.fromMap(doc.data()))
            .toList());
  }
}
