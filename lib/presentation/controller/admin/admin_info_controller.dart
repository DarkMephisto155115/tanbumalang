import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class InfoController extends GetxController {
  final CollectionReference infoCollection = FirebaseFirestore.instance.collection('info');
  final FirebaseStorage storage = FirebaseStorage.instance;

  final titleController = ''.obs;
  final descriptionController = ''.obs;
  final Rx<File?> imageFile = Rx<File?>(null);

  final ImagePicker picker = ImagePicker();

  // Function to pick an image
  Future<void> pickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      imageFile.value = File(pickedFile.path);
    }
  }

  // Function to upload image to Firebase Storage
  Future<String> uploadImageToStorage(File image) async {
    try {
      final ref = storage.ref().child('info_images/${DateTime.now().millisecondsSinceEpoch}.jpg');
      await ref.putFile(image);
      return await ref.getDownloadURL();
    } catch (e) {
      print('Error uploading image: $e');
      return '';
    }
  }

  // Function to add info data to Firestore
  Future<void> addInfo() async {
    if (titleController.value.isEmpty || descriptionController.value.isEmpty) {
      Get.snackbar('Error', 'Title and Description are required', snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.green[200],
        colorText: Colors.black,);
      return;
    }

    String imageUrl = '';
    if (imageFile.value != null) {
      imageUrl = await uploadImageToStorage(imageFile.value!);
    }

    await infoCollection.add({
      'title': titleController.value,
      'description': descriptionController.value,
      'imageUrl': imageUrl,
    });

    // Clear fields after uploading
    titleController.value = '';
    descriptionController.value = '';
    imageFile.value = null;

    Get.snackbar('Success', 'Info added successfully', snackPosition: SnackPosition.TOP,
      backgroundColor: Colors.green[200],
      colorText: Colors.black,);
  }
}
