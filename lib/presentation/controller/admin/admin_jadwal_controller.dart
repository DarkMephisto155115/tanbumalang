import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class JadwalController extends GetxController {
  final CollectionReference jadwalCollection = FirebaseFirestore.instance.collection('jadwal');

  var titleController = TextEditingController();
  var dateController = TextEditingController();
  var descriptionController = TextEditingController();

  Future<void> addJadwal() async {
    if (titleController.text.isNotEmpty &&
        dateController.text.isNotEmpty &&
        descriptionController.text.isNotEmpty) {
      try {
        await jadwalCollection.add({
          'title': titleController.text,
          'date': dateController.text,
          'description': descriptionController.text,
        });
        Get.snackbar(
          'Success',
          'Jadwal added successfully!',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
        titleController.clear();
        dateController.clear();
        descriptionController.clear();
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
