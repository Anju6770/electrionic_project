import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';


class StoreData {
  Future addTask(String task, String time) async {
    try {
      CollectionReference tasks =
      await FirebaseFirestore.instance.collection("tasker");


      tasks.add({'task': task, 'time': time});
      debugPrint("Task added successfully");
    } catch (e) {
      debugPrint("Error while data storing: $e");
    }
  }


  Stream<QuerySnapshot> fetchData() {
    final Stream<QuerySnapshot> _taskStream;
    _taskStream = FirebaseFirestore.instance.collection('tasker').snapshots();
    return _taskStream;
  }
}
