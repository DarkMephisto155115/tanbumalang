import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'bukti_pembayaran.dart';

class KeuanganAdminPage extends StatelessWidget {
  const KeuanganAdminPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        iconTheme: const IconThemeData(
          color: Colors.white, //change your color here
        ),
        title: const Text('Admin Keuangan', style: TextStyle(color: Colors.white)),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset('assets/logo.png', width: 50, height: 50),
          ),
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('payments').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text('Tidak ada data pembayaran'));
          }

          final payments = snapshot.data!.docs;

          return ListView.builder(
            itemCount: payments.length,
            itemBuilder: (context, index) {
              final payment = payments[index].data() as Map<String, dynamic>;

              return Card(
                margin: const EdgeInsets.all(8.0),
                child: ListTile(
                  title: Text(payment['name'] ?? 'Nama Tidak Diketahui'),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Tagihan: ${payment['tagihan'] ?? '-'}'),
                      Text('Nomor Telepon: ${payment['phone'] ?? '-'}'),
                      Text('Metode Pembayaran: ${payment['paymentMethod'] ?? '-'}'),
                      Text('Jumlah: ${payment['amount'] ?? '-'}'),
                      Text('Waktu: ${payment['timestamp'] != null ? payment['timestamp'].toDate().toString() : '-'}'),
                    ],
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.receipt_long),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProofOfPaymentPage(
                            proofUrl: payment['proofOfPayment'] ?? '',
                          ),
                        ),
                      );
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