import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:electrionic_project/time_pass/model.dart';

class PlacesServices {
  ///create
  Future<void> addPlace(BookModel place) async {
    final docRef = FirebaseFirestore.instance.collection('places').doc();
    place.id = docRef.id;
    await docRef.set(place.toMap());
  }
  ///update
  Future<void> updatePlace(BookModel place) async {
    final docRef =
    FirebaseFirestore.instance.collection('places').doc(place.id);
    await docRef.update(place.toMap());
  }

  ///delete
  Future<void> deletePlace(String placeId) async {
    final docRef = FirebaseFirestore.instance.collection('places').doc(placeId);
    await docRef.delete();
  }

  ///read
  Stream<List<BookModel>> fetchPlaces() {
    return FirebaseFirestore.instance.collection('places').snapshots().map(
            (snapshot) => snapshot.docs
            .map((doc) => BookModel.fromMap(doc.data(), doc.id))
            .toList());
  }

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<bool?> fetchThemePreference(String userId) async {
    final doc = await _firestore.collection('users').doc(userId).get();
    if (doc.exists && doc.data()!.containsKey('isLightTheme')) {
      return doc['isLightTheme'] as bool;
    }
    return null;
  }


  final FirebaseFirestore _firestores = FirebaseFirestore.instance;

  Future<void> saveThemePreference(String userId, bool isLightTheme) async {
    await _firestore.collection('users').doc(userId).set({
      'isLightTheme': isLightTheme,
    }, SetOptions(merge: true));
  }
}
