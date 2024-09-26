import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:electrionic_project/model/cover_first.dart';
import 'package:electrionic_project/model/cover_last.dart';
import 'package:electrionic_project/model/home.dart';
import 'package:electrionic_project/model/inside_logo.dart';

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
    return FirebaseFirestore.instance
        .collection('home')
        .snapshots() // Fetch the snapshots as a stream
        .map((snapshot) => snapshot.docs
        .map((doc) => HomeModel.fromMap(doc.data(), doc.id))
        .toList());
  }

  Stream<List<CoverFirst>> fetchsign() {
    return FirebaseFirestore.instance
        .collection('CoverFirst')
        .snapshots() // Fetch the snapshots as a stream
        .map((snapshot) => snapshot.docs
        .map((doc) => CoverFirst.fromMap(doc.data(), doc.id))
        .toList());
  }
  Stream<List<CoverLast>> fetchlog() {
    return FirebaseFirestore.instance
        .collection('CoverLast')
        .snapshots() // Fetch the snapshots as a stream
        .map((snapshot) => snapshot.docs
        .map((doc) => CoverLast.fromMap(doc.data(), doc.id))
        .toList());
  }
  Stream<List<InsideLogo>> fetchinside() {
    return FirebaseFirestore.instance
        .collection('InsideLogo')
        .snapshots() // Fetch the snapshots as a stream
        .map((snapshot) => snapshot.docs
        .map((doc) => InsideLogo.fromMap(doc.data(), doc.id))
        .toList());
  }
}
