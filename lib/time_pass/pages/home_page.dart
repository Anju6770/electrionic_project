import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:electrionic_project/time_pass/ManageState/manageStste.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:gap/gap.dart';

class BookThing extends StatelessWidget {
  BookThing({super.key});

  final ManageState ms = Get.put(ManageState());

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  String? _editingDocId;

  void _addOrUpdateItem() async {
    if (_nameController.text.isNotEmpty &&
        _emailController.text.isNotEmpty &&
        _locationController.text.isNotEmpty) {
      if (_editingDocId == null) {
        // Add a new item
        await _firestore.collection('places').add({
          'name': _nameController.text,
          'email': _emailController.text,
          'location': _locationController.text,
          'timestamp': FieldValue.serverTimestamp(),
        });
      } else {
        // Update the existing item
        await _firestore.collection('places').doc(_editingDocId).update({
          'name': _nameController.text,
          'email': _emailController.text,
          'location': _locationController.text,
        });
        _editingDocId = null; // Reset edit mode
      }
      _clearFields();
    }
  }

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

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GetBuilder<ManageState>(builder: (ms) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: ms.isLightTheme ? Colors.white : Colors.black,
            title: Text(
              'Chabilal Pradhan',
              style: TextStyle(
                color: ms.isLightTheme ? Colors.black : Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            centerTitle: true,
            actions: [
              IconButton(
                onPressed: () {
                  // Toggle the theme
                  ms.toggletheme();
                },
                icon: Icon(
                  ms.isLightTheme ? Icons.sunny : Icons.nightlight,
                  color: ms.isLightTheme ? Colors.black : Colors.white,
                ),
              ),
            ],
          ),
          backgroundColor: ms.isLightTheme ? Colors.white : Colors.black,
          body: Column(
            children: [
              Expanded(
                child: StreamBuilder<QuerySnapshot>(
                  stream: _firestore
                      .collection('places')
                      .orderBy('timestamp', descending: true)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return Center(child: Text('Error: ${snapshot.error}'));
                    }
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    }

                    final data = snapshot.requireData;

                    return ListView.builder(
                      itemCount: data.size,
                      itemBuilder: (context, index) {
                        final place = data.docs[index];
                        return Container(
                          margin: EdgeInsets.symmetric(vertical: 10),
                          padding: EdgeInsets.all(10),
                          height: 150,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: ms.isLightTheme
                                  ? Colors.grey
                                  : Colors.white24,
                            ),
                            color: ms.isLightTheme
                                ? Colors.white
                                : Colors.black54,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                place['name'],
                                style: TextStyle(
                                  color: ms.isLightTheme
                                      ? Colors.black
                                      : Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Row(
                                children: [
                                  Text(
                                    place['email'],
                                    style: TextStyle(
                                      color: ms.isLightTheme
                                          ? Colors.black
                                          : Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Spacer(),
                                  IconButton(
                                    icon: Icon(
                                      Icons.delete,
                                      size: 30,
                                      color: ms.isLightTheme
                                          ? Colors.black
                                          : Colors.white,
                                    ),
                                    onPressed: () {
                                      _firestore
                                          .collection('places')
                                          .doc(place.id)
                                          .delete();
                                    },
                                  ),
                                ],
                              ),
                              Text(
                                place['location'],
                                style: TextStyle(
                                  color: ms.isLightTheme
                                      ? Colors.black
                                      : Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  IconButton(
                    onPressed: _addOrUpdateItem,
                    icon: Icon(
                      _editingDocId == null ? Icons.add : Icons.edit,
                      size: 30,
                      color: ms.isLightTheme ? Colors.black : Colors.white,
                    ),
                  ),
                  Container(
                    height: 200,
                    width: 250,
                    color: ms.isLightTheme ? Colors.white : Colors.black54,
                    child: Column(
                      children: [
                        TextFormField(
                          controller: _nameController,
                          style: TextStyle(
                            color: ms.isLightTheme
                                ? Colors.black
                                : Colors.white,
                          ),
                          decoration: InputDecoration(
                            hintText: "Name",
                            hintStyle: TextStyle(
                              color: ms.isLightTheme
                                  ? Colors.black54
                                  : Colors.white70,
                            ),
                            border: OutlineInputBorder(),
                          ),
                        ),
                        Gap(10),
                        TextFormField(
                          controller: _emailController,
                          style: TextStyle(
                            color: ms.isLightTheme
                                ? Colors.black
                                : Colors.white,
                          ),
                          decoration: InputDecoration(
                            hintText: "Email",
                            hintStyle: TextStyle(
                              color: ms.isLightTheme
                                  ? Colors.black54
                                  : Colors.white70,
                            ),
                            border: OutlineInputBorder(),
                          ),
                        ),
                        Gap(10),
                        TextFormField(
                          controller: _locationController,
                          style: TextStyle(
                            color: ms.isLightTheme
                                ? Colors.black
                                : Colors.white,
                          ),
                          decoration: InputDecoration(
                            hintText: "Location",
                            hintStyle: TextStyle(
                              color: ms.isLightTheme
                                  ? Colors.black54
                                  : Colors.white70,
                            ),
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: _addOrUpdateItem,
                    icon: Icon(
                      Icons.send,
                      size: 25,
                      color: ms.isLightTheme ? Colors.black : Colors.white,
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      }),
    );
  }
}
