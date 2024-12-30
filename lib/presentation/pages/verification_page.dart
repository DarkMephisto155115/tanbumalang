import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../routes/app_pages.dart';


class VerificationPage extends StatelessWidget {
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
              const Text("Verification", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildVerificationBox(),
                  _buildVerificationBox(),
                  _buildVerificationBox(),
                  _buildVerificationBox(),
                  _buildVerificationBox(),
                ],
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // Setelah verifikasi selesai, kembalikan ke halaman login

                  Get.offAllNamed(Routes.LOGIN);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.yellow, // background
                  foregroundColor: Colors.black, // foreground
                ),
                child: const Text("Verify"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Fungsi untuk membuat kotak input verifikasi
  Widget _buildVerificationBox() {
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black),
        borderRadius: BorderRadius.circular(10),
      ),
      child: const Center(
        child: TextField(
          textAlign: TextAlign.center,
          keyboardType: TextInputType.number,
          maxLength: 1, // Maksimal input 1 karakter per kotak
          decoration: InputDecoration(
            border: InputBorder.none,
            counterText: '',
          ),
        ),
      ),
    );
  }
}