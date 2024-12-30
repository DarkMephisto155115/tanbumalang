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

  void login() async {
    String email = emailController.text;
    String password = passwordController.text;

    if (email.isNotEmpty && password.isNotEmpty) {
      if (email == "admin" && password == "admin"){
        Get.snackbar('Success', 'Logged in successfully',  backgroundColor: Colors.green, colorText: Colors.white);
        Get.offAllNamed("/home_admin");
      }else{
        try {
          UserCredential userCredential = await _auth.signInWithEmailAndPassword(
              email: email, password: password);

          final SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.setBool('isLoggedIn', true);
          await prefs.setString('userId', userCredential.user!.uid);

          Get.snackbar('Success', 'Logged in successfully',  backgroundColor: Colors.green, colorText: Colors.white);


          Get.offAllNamed("/home");
        } on FirebaseAuthException catch (e) {
          String message;
          if (e.code == 'user-not-found') {
            message = ' No user  found for that email. ';
          } else if (e.code == 'wrong-password') {
            message = 'Wrong password provider';
          } else {
            message = 'Login failed. Please try again!';
          }
          Get.snackbar('Login Failed ', message,
              backgroundColor: Colors.red, colorText: Colors.white);
        } catch (e) {
          Get.snackbar('Error', 'An unexpeted error ocurred.',
              backgroundColor: Colors.red, colorText: Colors.white);
        }
      }
    } else {
      Get.snackbar('Error', 'Please enter email and password',
          backgroundColor: Colors.red, colorText: Colors.white);
    }
  }

  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
