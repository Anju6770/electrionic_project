import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:electrionic_project/model/Third_model.dart';

class DetailsServices{
  Stream<List<ThirdModel>> fetchItems() {
    return FirebaseFirestore.instance.collection('third').snapshots().map(
            (snapshot) => snapshot.docs
            .map((doc) => ThirdModel.fromMap(doc.data()))
            .toList());
  }
}