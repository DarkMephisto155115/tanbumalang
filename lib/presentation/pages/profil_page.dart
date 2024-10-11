import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../routes/app_pages.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green[300],
        title: Text('Profile'),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset('assets/logo.png', width: 50, height: 50), // Custom logo
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            // Menu Item 1
            MenuItem(
              icon: Icons.person,
              title: 'Biodata',
              onTap: () {
                Navigator.pushNamed(context, '/biodata'); // Change to your route
              },
            ),
            Divider(), // Divider between items
            // Menu Item 2
            MenuItem(
              icon: Icons.report,
              title: 'Lapor',
              onTap: () {
                // Handle Lapor tap
                Navigator.pushNamed(context, '/lapor'); // Change to your route
              },
            ),
            Divider(), // Divider between items
            // Menu Item 3
            MenuItem(
              icon: Icons.chat,
              title: 'Chat Admin',
              onTap: () {
                // Handle Chat Admin tap
                Navigator.pushNamed(context, '/chat'); // Change to your route
              },
            ),
            Divider(), // Divider between items
            // Menu Item 4
            MenuItem(
              icon: Icons.info,
              title: 'Tentang Kami',
              onTap: () {
                // Handle Tentang Kami tap
                Navigator.pushNamed(context, '/aboutus'); // Change to your route
              },
            ),
            Divider(), // Divider between items
            // Menu Item 5
            MenuItem(
              icon: Icons.exit_to_app,
              title: 'Keluar',
              onTap: () {
                Get.offAllNamed(Routes.LOGIN);
              },
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
        currentIndex: 4, // Set to the index of the current page
        onTap: (index) {
          switch (index) {
            case 0: // Home
              Navigator.pushReplacementNamed(context, '/home'); // Update the route name
              break;
            case 1: // Mutasi
              Navigator.pushReplacementNamed(context, '/mutasi'); // Update the route name
              break;
            case 2: // QR
            //TBA
              break;
            case 3: // Info
              Navigator.pushReplacementNamed(context, '/info'); // Update the route name
              break;
            case 4: // Profile
          }
        },
      ),
    );
  }
}

// Custom widget for Menu Item
class MenuItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap; // Callback for onTap

  MenuItem({
    required this.icon,
    required this.title,
    required this.onTap, // Add required onTap parameter
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, size: 30),
      title: Text(title, style: TextStyle(fontSize: 18)),
      onTap: onTap, // Trigger onTap callback when tapped
    );
  }
}