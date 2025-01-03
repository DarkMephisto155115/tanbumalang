import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'absen_page.dart';

class AttendanceListPage extends StatefulWidget {
  const AttendanceListPage({super.key});

  @override
  _AttendanceListPageState createState() => _AttendanceListPageState();
}

class _AttendanceListPageState extends State<AttendanceListPage> {
  String? userId;

  @override
  void initState() {
    super.initState();
    _getCurrentUserId();
  }

  Future<void> _getCurrentUserId() async {
    final user = FirebaseAuth.instance.currentUser;
    setState(() {
      userId = user?.uid;
    });
  }

  Future<bool> _hasUserAttended(String formId) async {
    if (userId == null) return false;

    final responseSnapshot = await FirebaseFirestore.instance
        .collection('forms')
        .doc(formId)
        .collection('responses')
        .where('userId', isEqualTo: userId)
        .get();

    return responseSnapshot.docs.isNotEmpty;
  }

  Future<Map<String, List<QueryDocumentSnapshot>>> _fetchForms() async {
    final snapshot = await FirebaseFirestore.instance
        .collection('forms')
        .orderBy('timestamp', descending: true)
        .get();

    final submittedForms = <QueryDocumentSnapshot>[];
    final notSubmittedForms = <QueryDocumentSnapshot>[];

    for (final form in snapshot.docs) {
      final formId = form.id;
      final hasSubmitted = await _hasUserAttended(formId);
      if (hasSubmitted) {
        submittedForms.add(form);
      } else {
        notSubmittedForms.add(form);
      }
    }

    return {
      'submitted': submittedForms,
      'notSubmitted': notSubmittedForms,
    };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        iconTheme: const IconThemeData(
          color: Colors.white, //change your color here
        ),
        title: const Text('Absensi', style: TextStyle(color: Colors.white)),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset('assets/logo.png', width: 50, height: 50),
          ),
        ],
      ),
      body: userId == null
          ? const Center(child: CircularProgressIndicator())
          : FutureBuilder<Map<String, List<QueryDocumentSnapshot>>>(
        future: _fetchForms(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data == null) {
            return const Center(child: Text("Tidak ada absensi tersedia."));
          }

          final submittedForms = snapshot.data!['submitted']!;
          final notSubmittedForms = snapshot.data!['notSubmitted']!;

          return ListView(
            children: [

              if (notSubmittedForms.isNotEmpty)
                const ListTile(
                  title: Text(
                    "Belum Mengisi",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ...notSubmittedForms.map((form) => ListTile(
                title: Text(form.get('title') ?? 'Absensi'),
                subtitle: Text(
                    "Dibuat pada: ${(form.get('timestamp') as Timestamp).toDate()}"),
                trailing: const Icon(Icons.close, color: Colors.red),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AbsenPage(
                        formId: form.id,
                      ),
                    ),
                  );
                },
              )),
              if (submittedForms.isNotEmpty)
                const ListTile(
                  title: Text(
                    "Sudah Mengisi",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ...submittedForms.map((form) => ListTile(
                title: Text(form.get('title') ?? 'Absensi'),
                subtitle: Text(
                    "Dibuat pada: ${(form.get('timestamp') as Timestamp).toDate()}"),
                trailing: const Icon(Icons.check, color: Colors.green),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AbsenPage(
                        formId: form.id,
                      ),
                    ),
                  );
                },
              )),
            ],
          );
        },
      ),
    );
  }
}
