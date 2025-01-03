import 'package:flutter/material.dart';
import 'package:get/get.dart';

class KeuanganPage extends StatefulWidget {
  const KeuanganPage({super.key});

  @override
  _KeuanganPageState createState() => _KeuanganPageState();
}

class _KeuanganPageState extends State<KeuanganPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        iconTheme: const IconThemeData(
          color: Colors.white, //change your color here
        ),
        title: const Text('Keuangan', style: TextStyle(color: Colors.white)),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset('assets/logo.png', width: 50, height: 50),
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
                        Navigator.pushNamed(context, '/pembayaran_asrama');
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
                        Navigator.pushNamed(context, '/pembayaran_himpunan');
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
