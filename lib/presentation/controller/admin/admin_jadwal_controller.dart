import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class JadwalController extends GetxController {
  // Collection reference to the "jadwal" collection in Firestore
  final CollectionReference jadwalCollection = FirebaseFirestore.instance.collection('jadwal');

  // Controllers for title and date input fields
  var titleController = TextEditingController();
  var dateController = TextEditingController();

  // Method to add a new "jadwal" to Firestore
  Future<void> addJadwal() async {
    if (titleController.text.isNotEmpty && dateController.text.isNotEmpty) {
      try {
        await jadwalCollection.add({
          'title': titleController.text,
          'date': dateController.text,
        });
        Get.snackbar(
          'Success',
          'Jadwal added successfully!',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
        // Clear text fields after successful addition
        titleController.clear();
        dateController.clear();
      } catch (e) {
        Get.snackbar(
          'Error',
          'Failed to add jadwal: $e',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    } else {
      Get.snackbar(
        'Incomplete',
        'Please fill in all fields',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.orange,
        colorText: Colors.white,
      );
    }
  }
}
