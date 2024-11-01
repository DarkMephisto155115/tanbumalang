import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class PembayaranAsramaPage extends StatefulWidget {
  @override
  _PembayaranAsramaState createState() => _PembayaranAsramaState();
}

class _PembayaranAsramaState extends State<PembayaranAsramaPage> {
  List<Map<String, dynamic>> payments = [
    {'name': 'Iuran Bulanan', 'amount': 'Rp. 20.000', 'status': 'BL'},
    {'name': 'Iuran Kegiatan', 'amount': 'Rp. 100.000', 'status': 'BL'},
  ];

  // Send payment data to Firestore with a timestamp
  Future<void> _sendPaymentToFirestore(Map<String, dynamic> payment) async {
    await FirebaseFirestore.instance.collection('payments').add({
      'name': payment['name'],
      'amount': payment['amount'],
      'status': 'L', // Mark as paid
      'timestamp': FieldValue.serverTimestamp(), // Firebase server timestamp
      'tipePembayaran': 'Asrama',
    });
  }

  void _handlePayment(int index) async {
    setState(() {
      payments[index]['status'] = 'L';
    });
    await _sendPaymentToFirestore(payments[index]);

    // Navigate to Mutasi Page
    Navigator.pushReplacementNamed(context, '/mutasi');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green[300],
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: const Text('Keuangan', style: TextStyle(color: Colors.black)),
          actions: const [
            Padding(
              padding: EdgeInsets.all(8.0),
              child: CircleAvatar(
                backgroundImage: AssetImage('assets/logo.png'),
              ),
            ),
          ],
        ),
        body: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              alignment: Alignment.center,
              child: const Text(
                'Pembayaran Asrama',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
            Table(
              columnWidths: const {
                0: FlexColumnWidth(2),
                1: FlexColumnWidth(1.3),
                2: FlexColumnWidth(1),
                3: FlexColumnWidth(2.1),
              },
              border: const TableBorder.symmetric(inside: BorderSide(color: Colors.grey)),
              children: [
                TableRow(
                  decoration: BoxDecoration(color: Colors.grey[200]),
                  children: ['Pembayaran', 'Tagihan', 'Status', '']
                      .map((header) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        header,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    );
                  })
                      .toList(),
                ),
                ...payments.asMap().entries.map((entry) {
                  int index = entry.key;
                  Map<String, dynamic> payment = entry.value;
                  return TableRow(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(payment['name']),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(payment['amount']),
                      ),
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
                          child: const Text('Bayar'),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: payment['status'] == 'L'
                                ? Colors.grey
                                : Colors.green,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.zero,
                            ),
                            foregroundColor: Colors.white,
                          ),
                          onPressed: payment['status'] == 'L'
                              ? null
                              : () => _handlePayment(index),
                        ),
                      ),
                    ],
                  );
                }).toList(),
              ],
            ),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            backgroundColor: Colors.green[300],
            selectedItemColor: Colors.black,
            unselectedItemColor: Colors.white70,
            items: [
              BottomNavigationBarItem(
                icon: Image.asset('assets/icon_home.png', width: 24, height: 24),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Image.asset('assets/icon_mutasi.png', width: 24, height: 24),
                label: 'Mutasi',
              ),
              BottomNavigationBarItem(
                icon: Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                    border: Border.all(
                      color: Colors.black,
                      width: 2,
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Image.asset(
                      'assets/icon_qr_code.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: Image.asset('assets/icon_info.png', width: 24, height: 24),
                label: 'Info',
              ),
              BottomNavigationBarItem(
                icon: Image.asset('assets/icon_profile.png', width: 24, height: 24),
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
                  break;
                case 3:
                  Navigator.pushReplacementNamed(context, '/info');
                  break;
                case 4:
                  Navigator.pushReplacementNamed(context, '/profile');
                  break;
              }
            },
            ),
        );
    }
}