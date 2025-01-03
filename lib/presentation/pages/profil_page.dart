import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:whatsapp_unilink/whatsapp_unilink.dart';

import '../routes/app_pages.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});


  void _launchWhatsApp() async {
    const link = WhatsAppUnilink(
      phoneNumber: '+6285236782335', // Ganti dengan nomor yang benar
      text: 'Butuh bantuan nih, min',
    );

    await launch(link.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.green,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset('assets/logo.png', width: 50, height: 50),
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
            const Divider(), // Divider between items
            // Menu Item 2
            MenuItem(
              icon: Icons.report,
              title: 'Lapor',
              onTap: () {
                // Handle Lapor tap
                Navigator.pushNamed(context, '/lapor'); // Change to your route
              },
            ),
            const Divider(), // Divider between items
            // Menu Item 3
            MenuItem(
              icon: Icons.chat,
              title: 'Chat Admin',
              onTap: () {
                // Handle Chat Admin tap
                // Navigator.pushNamed(context, '/chat'); // Change to your route
                _launchWhatsApp();
              },
            ),
            const Divider(), // Divider between items
            // Menu Item 4
            MenuItem(
              icon: Icons.info,
              title: 'Tentang Kami',
              onTap: () {
                // Handle Tentang Kami tap
                Navigator.pushNamed(context, '/aboutus'); // Change to your route
              },
            ),
            const Divider(), // Divider between items
            // Menu Item 5
            MenuItem(
              icon: Icons.exit_to_app,
              title: 'Keluar',
              onTap: () {
                logout();
                Get.offAllNamed(Routes.LOGIN);
              },
            ),
          ],
        ),
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
        currentIndex: 4,
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

Future<void> logout() async {
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.clear();
  Get.offAllNamed('/login');
}


// Custom widget for Menu Item
class MenuItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap; // Callback for onTap

  const MenuItem({super.key,
    required this.icon,
    required this.title,
    required this.onTap, // Add required onTap parameter
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon, size: 30),
      title: Text(title, style: const TextStyle(fontSize: 18)),
      onTap: onTap, // Trigger onTap callback when tapped
    );
  }
}