import 'package:flutter/material.dart';

import 'himpunan_struktur_page.dart';

class StrukturPage extends StatefulWidget {
  @override
  _StrukturPageState createState() => _StrukturPageState();
}

class _StrukturPageState extends State<StrukturPage> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    // Navigation logic
    switch (index) {
      case 0: // Home
        Navigator.pushReplacementNamed(context, '/home');
        break;
      case 1: // Mutasi
        Navigator.pushReplacementNamed(context, '/mutasi');
        break;
      case 2: // QR (not implemented)
        break;
      case 3: // Info
        Navigator.pushReplacementNamed(context, '/info');
        break;
      case 4: // Profile
        Navigator.pushReplacementNamed(context, '/profile');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green[300],
        title: const Text('Struktural'),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset('assets/logo.png', width: 50, height: 50), // Logo image
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            // Align the boxes to the top left of the screen
            Column(
              crossAxisAlignment: CrossAxisAlignment.start, // Align to the left
              children: [
                // Row to arrange Asrama and Himpunan horizontally
                Row(
                  mainAxisAlignment: MainAxisAlignment.start, // Align items to the start
                  children: [
                    // First grid item (Asrama)
                    GestureDetector(
                      onTap: () {
                        // Action when 'Asrama' is tapped
                        Navigator.pushNamed(context, '/asrama');
                      },
                      child: Container(
                        margin: const EdgeInsets.only(right: 16), // Space between boxes
                        child: SizedBox(
                          width: 70, // Fixed width
                          height: 70, // Fixed height
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.black),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset('assets/asrama_icon.png', width: 30, height: 30), // Asrama icon
                                const SizedBox(height: 4), // Reduced spacing
                                const Text('Asrama', style: TextStyle(fontSize: 12)), // Smaller text
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),

                    // Second grid item (Himpunan)
                    GestureDetector(
                      onTap: () {
                        // Action when 'Himpunan' is tapped
                        // Navigator.pushNamed(context, '/himpunan');
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => HimpunanStrukturPage()),
                        );
                      },
                      child: SizedBox(
                        width: 70, // Fixed width
                        height: 70, // Fixed height
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset('assets/himpunan_icon.png', width: 30, height: 30), // Himpunan icon
                              const SizedBox(height: 4), // Reduced spacing
                              const Text('Himpunan', style: TextStyle(fontSize: 12)), // Smaller text
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
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
                border: Border.all(color: Colors.black, width: 2),
              ),
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Image.asset('assets/icon_qr_code.png', fit: BoxFit.cover),
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
        onTap: _onItemTapped,
      ),
    );
  }
}
