import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:electrionic_project/time_pass/ManageState/manageStste.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class detailsController extends GetxController{

  final ManageState ms = Get.put(ManageState());

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  String? _editingDocId;

  // Method to clear the text fields
  void _clearFields() {
    _nameController.clear();
    _emailController.clear();
    _locationController.clear();
  }
  
  // Method to enter edit mode
  void _enterEditMode(DocumentSnapshot place) {
    _nameController.text = place['name'];
    _emailController.text = place['email'];
    _locationController.text = place['location'];
    _editingDocId = place.id; // Set the document ID being edited
  }

}
