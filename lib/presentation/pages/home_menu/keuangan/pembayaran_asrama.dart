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

  void _handlePayment(int index) {
    setState(() {
      payments[index]['status'] = 'L';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green[300],
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context); // Go back to the previous page
          },
        ),
        title: const Text('Keuangan', style: TextStyle(color: Colors.black)),
        actions: const [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: CircleAvatar(
              backgroundImage: AssetImage('assets/logo.png'), // Ensure the logo is added in assets
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
              3: FlexColumnWidth(2.1), // Additional column for button
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
                              : Colors.green, // Disable if already paid
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.zero, // Rectangular button
                          ),
                          foregroundColor: Colors.white,
                        ),
                        onPressed: payment['status'] == 'L'
                            ? null
                            : () => _handlePayment(index), // Pay action
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
        currentIndex: 0, // Set the current index
        onTap: (index) {
          switch (index) {
            case 0: // Home
              Navigator.pushReplacementNamed(context, '/home');
              break;
            case 1: // Mutasi
              Navigator.pushReplacementNamed(context, '/mutasi');
              break;
            case 2: // QR
            // Handle QR navigation
              break;
            case 3: // Info
              Navigator.pushReplacementNamed(context, '/info');
              break;
            case 4: // Profile
              Navigator.pushReplacementNamed(context, '/profile');
              break;
          }
        },
      ),
    );
  }
}
