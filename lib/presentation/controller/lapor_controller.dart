import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class LaporController extends GetxController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final RxString profileImageUrl = ''.obs; // Observables for reactive data
  final TextEditingController nameController = TextEditingController();
  final TextEditingController prodiController = TextEditingController();
  final TextEditingController angkatanController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

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

  Future<void> sendLaporan(String laporanText) async {
    final user = _auth.currentUser;
    if (user != null) {
      try {
        await _firestore.collection('laporan').add({
          'text': laporanText,
          'username': nameController.text,
          'profileImageUrl': profileImageUrl.value,
          'timestamp': FieldValue.serverTimestamp(),
        });
        print("Laporan sent successfully!");
      } catch (e) {
        print("Error sending laporan: $e");
      }
    }
  }
}

