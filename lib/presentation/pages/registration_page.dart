import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../routes/app_pages.dart';
// import 'verification_view.dart';

class RegistrationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[200],
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("SIGN UP", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              const SizedBox(height: 30),

              // Email Field
              Container(
                decoration: BoxDecoration(
                  color: Colors.white, // Latar belakang putih
                  borderRadius: BorderRadius.circular(5), // Sudut melengkung
                ),
                child: const TextField(
                  decoration: InputDecoration(
                    labelText: 'Email',
                    border: UnderlineInputBorder(), // Garis bawah
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Username Field
              Container(
                decoration: BoxDecoration(
                  color: Colors.white, // Latar belakang putih
                  borderRadius: BorderRadius.circular(5), // Sudut melengkung
                ),
                child: const TextField(
                  decoration: InputDecoration(
                    labelText: 'Username',
                    border: UnderlineInputBorder(), // Garis bawah
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Password Field
              Container(
                decoration: BoxDecoration(
                  color: Colors.white, // Latar belakang putih
                  borderRadius: BorderRadius.circular(5), // Sudut melengkung
                ),
                child: const TextField(
                  decoration: InputDecoration(
                    labelText: 'Password',
                    border: UnderlineInputBorder(), // Garis bawah
                  ),
                  obscureText: true,
                ),
              ),
              const SizedBox(height: 20),

              // Prodi Field
              Container(
                decoration: BoxDecoration(
                  color: Colors.white, // Latar belakang putih
                  borderRadius: BorderRadius.circular(5), // Sudut melengkung
                ),
                child: const TextField(
                  decoration: InputDecoration(
                    labelText: 'Prodi',
                    border: UnderlineInputBorder(), // Garis bawah
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Angkatan Field
              Container(
                decoration: BoxDecoration(
                  color: Colors.white, // Latar belakang putih
                  borderRadius: BorderRadius.circular(5), // Sudut melengkung
                ),
                child: const TextField(
                  decoration: InputDecoration(
                    labelText: 'Angkatan',
                    border: UnderlineInputBorder(), // Garis bawah
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Register Button
              ElevatedButton(
                onPressed: () {
                  // Add register logic here
                  // Get.to(() => VerificationView());
                  Get.toNamed(Routes.VERIFIKASI);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.yellow, // menggantikan 'primary'
                  foregroundColor: Colors.black, // menggantikan 'onPrimary'
                ),
                child: const Text("Register"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}