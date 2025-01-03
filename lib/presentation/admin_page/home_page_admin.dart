import 'package:flutter/material.dart';
import 'package:get/get.dart';


class HomePageAdmin extends StatefulWidget {
  const HomePageAdmin({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePageAdmin> {

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
      body: Column(
        children: [
          // Profile Section
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.grey[100],
            ),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundImage: const AssetImage("assets/admin.png"),
                  backgroundColor: Colors.grey[300],
                ),
                const SizedBox(width: 16),
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Welcome Supreme Administrator',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 4),
                    // const SizedBox(height: 4),
                    // const Text(
                    //   'Have a great day!',
                    //   style: TextStyle(fontSize: 16, color: Colors.black54),
                    // ),
                  ],
                ),
              ],
            ),
          ),
          // const SizedBox(height: 16),
          Expanded(
            child: Container(
              color: Colors.grey[100],
              child: GridView.count(
                crossAxisCount: 3,
                padding: const EdgeInsets.all(16),
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                children: [
                  buildMenuItem('assets/jadwal.png', 'Jadwal', '/jadwal_admin', 40),
                  buildMenuItem('assets/keuangan.png', 'Keuangan', '/keuangan_admin', 40),
                  buildMenuItem('assets/absen.png', 'Absen', '/absen_admin', 40),
                  buildMenuItem('assets/program.png', 'Program', '/program_admin_crud', 40),
                ],
              ),
            ),
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
              Navigator.pushReplacementNamed(context, '/home_admin');
              break;
            case 1:
              Navigator.pushReplacementNamed(context, '/mutasi_admin');
              break;
            case 2:
              Get.toNamed('/qrscan');
              break;
            case 3:
              Navigator.pushReplacementNamed(context, '/info_admin');
              break;
            case 4:
              Navigator.pushReplacementNamed(context, '/profil_admin');
              break;
          }
        },
      ),
    );
  }

  Widget buildMenuItem(String assetPath, String label, String routeName, double tinggi) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, routeName);
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Colors.green),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 6,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: Image.asset(assetPath, width: 40, height: tinggi),
          ),
          const SizedBox(height: 8),
          Text(label, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
}
