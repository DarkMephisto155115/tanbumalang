import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class AdminFormDetailPage extends StatelessWidget {
  final String formId;

  const AdminFormDetailPage({super.key, required this.formId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        iconTheme: const IconThemeData(
          color: Colors.white, //change your color here
        ),
        title: const Text('Detail Absensi', style: TextStyle(color: Colors.white)),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset('assets/logo.png', width: 50, height: 50),
          ),
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('forms')
            .doc(formId)
            .collection('responses')
            .orderBy('timestamp', descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text("Tidak ada respons untuk form ini."));
          }

          final responses = snapshot.data!.docs;

          return ListView.builder(
            itemCount: responses.length,
            itemBuilder: (context, index) {
              final response = responses[index];
              final username = response.get('username');
              final photoUrl = response.get('photoUrl');
              final angkatan = response.get('angkatan');
              final prodi = response.get('prodi');
              final time = response.get('timestamp');

              return Card(
                margin: const EdgeInsets.all(8.0),
                child: ListTile(
                  title: Text(username),
                  subtitle: Text("Angkatan: "+angkatan + "\n"+"Prodi: " + prodi + "\nWaktu: "+ DateFormat('dd-MM-yyyy, HH:mm')
                      .format(DateTime.parse(time.toDate().toString()) )),
                  trailing: IconButton(
                    icon: const Icon(Icons.photo),
                    onPressed: () {
                      if (photoUrl != null) {
                        showDialog(
                          context: context,
                          builder: (_) => AlertDialog(
                            content: Image.network(photoUrl),
                          ),
                        );
                      }
                    },
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
