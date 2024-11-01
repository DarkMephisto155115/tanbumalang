import 'package:cloud_firestore/cloud_firestore.dart';

class LaporanController {
  final CollectionReference _userReportsCollection =
  FirebaseFirestore.instance.collection('laporan');

  // Fetch all reports from Firestore
  Future<List<Map<String, dynamic>>> fetchAllReports() async {
    try {
      final querySnapshot = await _userReportsCollection.get();
      return querySnapshot.docs
          .map((doc) => doc.data() as Map<String, dynamic>)
          .toList();
    } catch (e) {
      print("Error fetching reports: $e");
      return [];
    }
  }
}
