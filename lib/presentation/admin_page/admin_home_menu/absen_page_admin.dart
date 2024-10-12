import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../routes/app_pages.dart';

class AbsenPageAdmin extends StatelessWidget {
  final List<Map<String, String>> members = [
    {'nama': 'Muhib', 'lokasi': 'Lacak'},
    {'nama': 'Malik', 'lokasi': 'Lacak'},
    {'nama': 'Lana', 'lokasi': 'Lacak'},
    {'nama': 'Opet', 'lokasi': 'Lacak'},
    {'nama': 'Fandi', 'lokasi': 'Lacak'},
    {'nama': 'Adi', 'lokasi': 'Lacak'},
    {'nama': 'Ichsan', 'lokasi': 'Lacak'},
    {'nama': 'Rivan', 'lokasi': 'Lacak'},
    {'nama': 'Dafa', 'lokasi': 'Lacak'},
    {'nama': 'Yusril', 'lokasi': 'Lacak'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green[400],
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset(
              'assets/logo.png', // Ganti dengan path logo kamu
              width: 40, // Ukuran logo
              height: 40,
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
              'List Anggota',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Table(
                border: TableBorder.all(),
                columnWidths: const {
                  0: FixedColumnWidth(50.0),
                  1: FixedColumnWidth(120.0), // Lebar kolom nama disesuaikan
                  2: FixedColumnWidth(100.0),
                },
                children: [
                  const TableRow(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text('No', textAlign: TextAlign.center),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text('Nama', textAlign: TextAlign.center),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text('Lokasi', textAlign: TextAlign.center),
                      ),
                    ],
                  ),
                  for (int index = 0; index < members.length; index++)
                    TableRow(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Text('${index + 1}', textAlign: TextAlign.center),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Text(
                            members[index]['nama']!,
                            textAlign: TextAlign.left,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center( // Mengatur teks agar rata tengah
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.green[300],
                                padding: const EdgeInsets.symmetric(horizontal: 12), // Padding horizontal
                              ),
                              onPressed: () {
                                // Aksi Lacak untuk setiap anggota
                                Get.toNamed(Routes.LOCATION);
                                // Replace the print statement with the action you want to perform
                                // Example: Navigator.push to a new page or show a dialog
                              },
                              child: Text(members[index]['lokasi']!),
                            ),
                          ),
                        ),
                      ],
                    ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey[300],
                  ),
                  onPressed: () {
                    Navigator.pop(context); // Go back to the previous page
                  },
                  child: const Text('Kembali', style: TextStyle(color: Colors.black)),
                ),
              ],
            ),
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
