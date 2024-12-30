import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BiodataController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Use observable for reactive UI updates
  var isEditing = false.obs;
  late final TextEditingController nameController;
  late final TextEditingController prodiController;
  late final TextEditingController angkatanController;
  late final TextEditingController emailController;

  @override
  void onInit() {
    super.onInit();
    nameController = TextEditingController();
    prodiController = TextEditingController();
    angkatanController = TextEditingController();
    emailController = TextEditingController();
    fetchUserData();
  }

  Future<void> fetchUserData() async {
    final user = _auth.currentUser;
    if (user != null) {
      final doc = await _firestore.collection('users').doc(user.uid).get();
      if (doc.exists) {
        final data = doc.data()!;
        nameController.text = data['username'] ?? '';
        prodiController.text = data['prodi'] ?? '';
        angkatanController.text = data['angkatan'] ?? '';
        emailController.text = data['email'] ?? '';
      }
    }
  }

  Future<void> updateUserData() async {
    final user = _auth.currentUser;
    if (user != null) {
      await _firestore.collection('users').doc(user.uid).update({
        'username': nameController.text.trim(),
        'prodi': prodiController.text.trim(),
        'angkatan': angkatanController.text.trim(),
        'email': emailController.text.trim(),
      });
      Get.snackbar(
        'Success',
        'Biodata updated successfully!',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.green[200],
        colorText: Colors.black,
      );
    }
  }

  @override
  void onClose() {
    nameController.dispose();
    prodiController.dispose();
    angkatanController.dispose();
    emailController.dispose();
    super.onClose();
  }
}
