import 'package:cloud_firestore/cloud_firestore.dart';

class LaporController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> sendLaporan(String laporanText, String username) async {
    try {
      await _firestore.collection('laporan').add({
        'text': laporanText,
        'username': username,
        'timestamp': FieldValue.serverTimestamp(),
      });
      print("Laporan sent successfully!");
    } catch (e) {
      print("Error sending laporan: $e");
    }
  }
}
