import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginController extends GetxController {
  var isPasswordHidden = true.obs;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  void togglePasswordVisibility() {
    isPasswordHidden.value = !isPasswordHidden.value;
  }

  Future<void> login() async {
    String email = emailController.text.trim();
    String password = passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      _showErrorSnackbar('Error', 'Please enter email and password');
      return;
    }

    if (email == "admin" && password == "admin") {
      _navigateToAdminHome();
    } else {
      await _loginWithFirebase(email, password);
    }
  }

  Future<void> _loginWithFirebase(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Save login session
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isLoggedIn', true);
      await prefs.setString('userId', userCredential.user!.uid);

      _showSuccessSnackbar('Success', 'Logged in successfully');
      Get.offAllNamed("/home");
    } on FirebaseAuthException catch (e) {
      String message = _getFirebaseErrorMessage(e.code);
      _showErrorSnackbar('Login Failed', message);
    } catch (e) {
      _showErrorSnackbar('Error', 'An unexpected error occurred.');
    }
  }

  String _getFirebaseErrorMessage(String code) {
    switch (code) {
      case 'user-not-found':
        return 'No user found for that email.';
      case 'wrong-password':
        return 'Incorrect password. Please try again.';
      default:
        return 'Login failed. Please try again!';
    }
  }

  void _navigateToAdminHome() {
    _showSuccessSnackbar('Success', 'Logged in successfully');
    Get.offAllNamed("/home_admin");
  }

  void _showSuccessSnackbar(String title, String message) {
    Get.snackbar(title, message,
        backgroundColor: Colors.green, colorText: Colors.white);
  }

  void _showErrorSnackbar(String title, String message) {
    Get.snackbar(title, message,
        backgroundColor: Colors.red, colorText: Colors.white);
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
