import 'package:flutter/material.dart';


class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0; // Track the current index of the bottom navigation bar

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;// Update the selected index
      switch (index) {
        case 0: // Home
          break;
        case 1: // Mutasi
          Navigator.pushReplacementNamed(context, '/mutasi'); // Update the route name
          break;
        case 2: // QR
          Navigator.pushReplacementNamed(context, '/qrscan');
          break;
        case 3: // Info
          Navigator.pushReplacementNamed(context, '/info'); // Update the route name
          break;
        case 4: // Profile
          Navigator.pushReplacementNamed(context, '/profil'); // Update the route name
          break;
      }//Yeah i know there is a better way to do this, but i want to sleep. SO FUCK OFF!!!
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green[300],
        title: const Text('Home'),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset('assets/logo.png', width: 50, height: 50), // Logo custom
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            color: Colors.grey[300],
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Row(
                  children: [
                    Text(
                      'Foto',
                      style: TextStyle(fontSize: 20),
                    ),
                    SizedBox(width: 8), // Jarak antara teks dan ikon panah
                    Icon(Icons.arrow_forward), // Ikon panah
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: GridView.count(
              crossAxisCount: 3,
              padding: const EdgeInsets.all(16),
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              children: [
                GestureDetector(
                  onTap: () {
                    // Action for 'Jadwal'
                    Navigator.pushNamed(context, '/jadwal'); // Example of navigation
                  },
                  child: buildMenuItem('assets/jadwal.png', 'Jadwal'),
                ),
                GestureDetector(
                  onTap: () {
                    // Action for 'Keuangan'
                    Navigator.pushNamed(context, '/keuangan'); // Example of navigation
                  },
                  child: buildMenuItem('assets/keuangan.png', 'Keuangan'),
                ),
                GestureDetector(
                  onTap: () {
                    // Action for 'Absen'
                    Navigator.pushNamed(context, '/absen'); // Example of navigation
                  },
                  child: buildMenuItem('assets/absen.png', 'Absen'),
                ),
                GestureDetector(
                  onTap: () {
                    // Action for 'Program'
                    Navigator.pushNamed(context, '/program'); // Example of navigation
                  },
                  child: buildMenuItem('assets/program.png', 'Program'),
                ),
                GestureDetector(
                  onTap: () {
                    // Action for 'Struktural'
                    Navigator.pushNamed(context, '/struktur'); // Example of navigation
                  },
                  child: buildMenuItem('assets/struktural.png', 'Struktural'),
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

  Widget buildMenuItem(String assetPath, String label) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.green),
          ),
          child: Image.asset(assetPath, width: 40, height: 40),
        ),
        const SizedBox(height: 8),
        Text(label, style: const TextStyle(fontSize: 16)),
      ],
    );
  }
}
