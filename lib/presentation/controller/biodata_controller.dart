import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class BiodataController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  var isEditing = false.obs;
  var profileImageUrl = ''.obs; // For storing the profile image URL

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
        profileImageUrl.value = data['profileImageUrl'] ?? '';
      }
    }
  }

  Future<void> pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      await uploadProfileImage(pickedFile.path);
    }
  }

  Future<void> uploadProfileImage(String filePath) async {
    final user = _auth.currentUser;
    if (user != null) {
      final ref = _storage.ref().child('profile_images/${user.uid}');
      final uploadTask = ref.putFile(File(filePath));

      final snapshot = await uploadTask;
      final downloadUrl = await snapshot.ref.getDownloadURL();

      await _firestore.collection('users').doc(user.uid).update({
        'profileImageUrl': downloadUrl,
      });

      profileImageUrl.value = downloadUrl;

      Get.snackbar(
        'Success',
        'Profile image updated successfully!',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.green[200],
        colorText: Colors.black,
      );
    }
  }

  Future<void> updateUserData() async {
    final user = _auth.currentUser;
    if (user != null) {
      await _firestore.collection('users').doc(user.uid).update({
        'username': nameController.text.trim(),
        'prodi': prodiController.text.trim(),
        'angkatan': angkatanController.text.trim(),
        'email': emailController.text.trim(), // Meskipun email hanya-baca, tetap disimpan
        'profileImageUrl': profileImageUrl.value, // Pastikan gambar profil juga disimpan
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
