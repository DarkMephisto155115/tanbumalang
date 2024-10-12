import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../routes/app_pages.dart';
// import 'register_view.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[300], // Latar belakang hijau muda
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("SIGN IN", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              const SizedBox(height: 30),

              // Kotak email dan password dengan sudut melengkung
              Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  color: Colors.white, // Latar belakang putih untuk kotak
                  borderRadius: BorderRadius.circular(15), // Sudut melengkung
                  boxShadow: [
                    const BoxShadow(
                      color: Colors.black12,
                      blurRadius: 6.0,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: const Column(
                  children: [
                    // TextField untuk Email
                    TextField(
                      decoration: InputDecoration(
                        labelText: 'Email',
                        border: InputBorder.none, // Menghapus border default
                        contentPadding: EdgeInsets.symmetric(horizontal: 10),
                      ),
                    ),
                    Divider(height: 20, thickness: 1.0), // Garis pemisah antara email dan password
                    // TextField untuk Password
                    TextField(
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        border: InputBorder.none, // Menghapus border default
                        contentPadding: EdgeInsets.symmetric(horizontal: 10),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 10),
              const Align(
                alignment: Alignment.centerRight,
                child: Text('Forgot Password?', style: TextStyle(color: Colors.blue)),
              ),
              const SizedBox(height: 20),

              // Tombol Login
              ElevatedButton(
                onPressed: () {
                  // Logika login
                  // Get.toNamed(Routes.HOME);
                  Get.offAllNamed(Routes.HOME);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.yellow, // Warna latar tombol
                  foregroundColor: Colors.black, // Warna teks tombol
                ),
                child: const Text("Login"),
              ),
              const SizedBox(height: 20),
              // Tombol Login
              ElevatedButton(
                onPressed: () {
                  // Logika login
                  Get.offAllNamed(Routes.HOME_ADMIN);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.yellow, // Warna latar tombol
                  foregroundColor: Colors.black, // Warna teks tombol
                ),
                child: const Text("Login Admin"),
              ),
              const SizedBox(height: 20),

              // Teks untuk navigasi ke halaman register
              GestureDetector(
                onTap: () {
                  // Get.to(() => RegisterView());
                  Get.toNamed(Routes.REGISTRASI);
                },
                child: const Text("Don't Have Account? Signup", style: TextStyle(color: Colors.blue)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}