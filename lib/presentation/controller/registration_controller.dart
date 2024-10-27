import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegistrationController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Text controllers for form fields
  final emailController = TextEditingController();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final prodiController = TextEditingController();
  final angkatanController = TextEditingController();

  // Method to register user
  Future<void> registerUser() async {
    try {
      // 1. Create user with email and password
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      // 2. Save additional user data in Firestore (except password)
      await _firestore.collection('users').doc(userCredential.user?.uid).set({
        'email': emailController.text.trim(),
        'username': usernameController.text.trim(),
        'prodi': prodiController.text.trim(),
        'angkatan': angkatanController.text.trim(),
        'createdAt': FieldValue.serverTimestamp(),
      });

      // 3. Show success notification
      Get.snackbar(
        "Registration Successful",
        "User has been registered successfully!",
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.green[200],
        colorText: Colors.black,
      );

      // Clear text fields after registration
      clearTextFields();
      Get.toNamed('/login');

    } catch (e) {
      // Show error notification
      Get.snackbar(
        "Registration Failed",
        e.toString(),
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red[200],
        colorText: Colors.black,
      );
    }
  }

  // Method to clear text fields
  void clearTextFields() {
    emailController.clear();
    usernameController.clear();
    passwordController.clear();
    prodiController.clear();
    angkatanController.clear();
  }

  @override
  void onClose() {
    // Dispose of the text controllers when the controller is removed
    emailController.dispose();
    usernameController.dispose();
    passwordController.dispose();
    prodiController.dispose();
    angkatanController.dispose();
    super.onClose();
  }
}
