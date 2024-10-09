import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../element/mutasi_element.dart'; // Make sure you have this file with TransactionItem defined

class MutasiPage extends StatefulWidget {
  @override
  _MutasiPageState createState() => _MutasiPageState();
}

class _MutasiPageState extends State<MutasiPage> {
  int _selectedIndex = 1; // Current index of the bottom navigation bar

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    // Add navigation logic based on the selected index
    // You can use Navigator to go to different pages
    switch (index) {
      case 0: // Home
        Navigator.pushReplacementNamed(context, '/home'); // Update the route name
        break;
      case 1: // Mutasi

        break;
      case 2: // QR
      //TBA
        break;
      case 3: // Info
        Navigator.pushReplacementNamed(context, '/info'); // Update the route name
        break;
      case 4: // Profile
        Navigator.pushReplacementNamed(context, '/profile'); // Update the route name
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green[300],
        title: Text('Mutasi'),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset('assets/logo.png', width: 50, height: 50), // Logo custom
          ),
        ],
      ),

      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Container(
              padding: EdgeInsets.symmetric(vertical: 16),
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                'Rentang Waktu (Work on Progress)',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: ListView(
                children: [
                  TransactionItem(
                    date: '21 Sep 2024',
                    description: 'Pembayaran Himpunan',
                    amount: '-Rp 20.000,00',
                  ),
                  TransactionItem(
                    date: '01 Sep 2024',
                    description: 'Pembayaran Asrama',
                    amount: '-Rp 500.000,00',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.green[300],
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.white70,
        items: [
          BottomNavigationBarItem(
            icon: Image.asset('assets/icon_home.png', width: 24, height: 24),
            label: 'Menu',
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
        currentIndex: _selectedIndex,
        onTap: _onItemTapped, // Call the function on tap
      ),
    );
  }
}
