import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../routes/app_pages.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  Future<void> checkLoginStatus() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;

    if (isLoggedIn) {
      Get.offAllNamed(Routes.HOME);
    } else {
      await Future.delayed(const Duration(seconds: 4));
      Get.offAllNamed(Routes.LOGIN);
    }
  }

  @override
  Widget build(BuildContext context) {
    checkLoginStatus();
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              Colors.greenAccent.shade200,
              Colors.green.shade300,
            ],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AnimatedTextKit(
                animatedTexts: [
                  TypewriterAnimatedText(
                    "Selamat Datang di Studease",
                    textStyle: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                    speed: const Duration(milliseconds: 100),
                  ),
                ],
              ),
              const SizedBox(height: 50),
              Image.asset(
                'assets/logo.png',
                width: 200,
                height: 200,
              ),
              const SizedBox(height: 20),
              const CircularProgressIndicator(),
            ],
          ),
        ),
      ),
    );
  }
}