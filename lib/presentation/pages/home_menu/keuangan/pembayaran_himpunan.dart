import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../admin_page/admin_home_menu/keuangan/bukti_pembayaran.dart';

class PembayaranHimpunanPage extends StatefulWidget {
  const PembayaranHimpunanPage({super.key});

  @override
  _PembayaranHimpunanState createState() => _PembayaranHimpunanState();
}

class _PembayaranHimpunanState extends State<PembayaranHimpunanPage> {
  List<Map<String, dynamic>> payments = [
    {'name': 'Iuran Bulanan', 'amount': 'Rp. 20.000', 'status': 'BL'},
    {'name': 'Iuran Kegiatan', 'amount': 'Rp. 100.000', 'status': 'BL'},
  ];

  Future<void> _sendPaymentToFirestore(Map<String, dynamic> payment) async {
    await FirebaseFirestore.instance.collection('payments').add({
      'name': payment['name'],
      'amount': payment['amount'],
      'status': 'L',
      'timestamp': FieldValue.serverTimestamp(),
      'tipePembayaran': 'Himpunan',
    });
  }

  void _handlePayment(int index) async {
    Map<String, dynamic> payment = payments[index];

    // Navigate to PaymentDetailsPage with the payment data
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PaymentDetailsPage(payment: payment),
      ),
    );

    // Check if the result is not null (meaning the user confirmed the payment)
    if (result != null) {
      setState(() {
        payments[index]['status'] = 'L';  // Mark payment as completed
      });
      // Send payment data to Firestore
      await _sendPaymentToFirestore(payment);
      Navigator.pushReplacementNamed(context, '/mutasi');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        iconTheme: const IconThemeData(
          color: Colors.white, //change your color here
        ),
        title: const Text('Pembayaran Himpunan', style: TextStyle(color: Colors.white)),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset('assets/logo.png', width: 50, height: 50),
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            child: const Text(
              'Pembayaran Himpunan',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          Table(
            columnWidths: const {0: FlexColumnWidth(2), 1: FlexColumnWidth(1.3), 2: FlexColumnWidth(1), 3: FlexColumnWidth(2.1)},
            border: const TableBorder.symmetric(inside: BorderSide(color: Colors.grey)),
            children: [
              TableRow(
                decoration: BoxDecoration(color: Colors.grey[200]),
                children: ['Pembayaran', 'Tagihan', 'Status', '']
                    .map((header) => Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(header, style: const TextStyle(fontWeight: FontWeight.bold)),
                ))
                    .toList(),
              ),
              ...payments.asMap().entries.map((entry) {
                int index = entry.key;
                Map<String, dynamic> payment = entry.value;
                return TableRow(
                  children: [
                    Padding(padding: const EdgeInsets.all(8.0), child: Text(payment['name'])),
                    Padding(padding: const EdgeInsets.all(8.0), child: Text(payment['amount'])),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        payment['status'],
                        style: TextStyle(
                          color: payment['status'] == 'L' ? Colors.green : Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: payment['status'] == 'L' ? Colors.grey : Colors.green,
                        ),
                        onPressed: payment['status'] == 'L' ? null : () => _handlePayment(index),
                        child: const Text('Bayar'),
                      ),
                    ),
                  ],
                );
              }),
            ],
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.green,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white70,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Menu',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.swap_horiz),
            label: 'Mutasi',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.qr_code),
            label: 'QR',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.info),
            label: 'Info',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: 'Profile',
          ),
        ],
        currentIndex: 0,
        onTap: (index) {
          switch (index) {
            case 0:
              Navigator.pushReplacementNamed(context, '/home');
              break;
            case 1:
              Navigator.pushReplacementNamed(context, '/mutasi');
              break;
            case 2:
              Get.toNamed('/qrscan');
              break;
            case 3:
              Navigator.pushReplacementNamed(context, '/info');
              break;
            case 4:
              Navigator.pushReplacementNamed(context, '/profil');
              break;
          }
        },
      ),
    );
  }
}