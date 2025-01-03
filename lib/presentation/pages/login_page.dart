import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/login_controller.dart';

class LoginPage extends GetView<LoginController> {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          height: MediaQuery.of(context).size.height,
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
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 150),
                // App Logo
                Image.asset(
                  'assets/logo.png',
                  height: 150, // Adjusted size for better spacing
                ),
                const SizedBox(height: 20),

                // Sign-in Text
                const Text(
                  "Selamat Datang !!!",
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 20),

                // Email and Password Input Fields
                Container(
                  padding: const EdgeInsets.all(20.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 10.0,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      // Email TextField
                      TextField(
                        controller: controller.emailController,
                        decoration: InputDecoration(
                          labelText: 'Email',
                          labelStyle: TextStyle(color: Colors.grey.shade700),
                          border: InputBorder.none,
                          prefixIcon: const Icon(Icons.email, color: Colors.blue),
                        ),
                      ),
                      const Divider(height: 10, thickness: 1.0),

                      // Password TextField
                      Obx(
                            () => TextField(
                          controller: controller.passwordController,
                          obscureText: controller.isPasswordHidden.value,
                          decoration: InputDecoration(
                            labelText: 'Password',
                            labelStyle: TextStyle(color: Colors.grey.shade700),
                            border: InputBorder.none,
                            prefixIcon: const Icon(Icons.lock, color: Colors.blue),
                            suffixIcon: IconButton(
                              icon: Icon(
                                controller.isPasswordHidden.value
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                                color: Colors.grey.shade700,
                              ),
                              onPressed: controller.togglePasswordVisibility,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 15),

                // Forgot Password
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {},
                    child: Text(
                      'Forgot Password?',
                      style: TextStyle(
                        color: Colors.blue[500],
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 15),

                // Login Button
                ElevatedButton(
                  onPressed: () {
                    // Get.offAllNamed("/home");
                    controller.login();
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 100, vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    backgroundColor: Colors.green.shade500,
                  ),
                  child: const Text(
                    "Login",
                    style: TextStyle(fontSize: 18, color: Colors.white),
                  ),
                ),

                const SizedBox(height: 10),

                // Login Admin Button
                // ElevatedButton(
                //   onPressed: () {
                //     Get.offAllNamed("/home_admin");
                //   },
                //   style: ElevatedButton.styleFrom(
                //     padding: const EdgeInsets.symmetric(horizontal: 80, vertical: 15),
                //     shape: RoundedRectangleBorder(
                //       borderRadius: BorderRadius.circular(30.0),
                //     ),
                //     backgroundColor: Colors.green.shade400,
                //   ),
                //   child: const Text(
                //     "Login Admin",
                //     style: TextStyle(fontSize: 18, color: Colors.white),
                //   ),
                // ),

                // const SizedBox(height: 15),

                // Register Button
                TextButton(
                  onPressed: () {
                    Get.toNamed('/registrasi');
                  },
                  child: Text(
                    "Don't have an account? Register",
                    style: TextStyle(
                      color: Colors.blue[500],
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
