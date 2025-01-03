import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tanbumalang/presentation/controller/lapor_controller.dart';

class LaporPage extends StatelessWidget {
  final LaporController _laporController = Get.put(LaporController());
  final TextEditingController _laporanController = TextEditingController();

  LaporPage({super.key});

  @override
  Widget build(BuildContext context) {
    _laporController.fetchUserData(); // Fetch user data when page loads

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text('Lapor', style: TextStyle(color: Colors.white)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset('assets/logo.png', width: 50, height: 50),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 16),
              TextField(
                controller: _laporanController,
                maxLines: 5,
                decoration: InputDecoration(
                  hintText: 'Tulis laporan Anda di sini...',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: const BorderSide(color: Colors.green, width: 2),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.green,
                  padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
                ),
                onPressed: () async {
                  if (_laporanController.text.isNotEmpty) {
                    await _laporController.sendLaporan(_laporanController.text);
                    _laporanController.clear();
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Laporan berhasil dikirim!')),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Laporan tidak boleh kosong')),
                    );
                  }
                },
                icon: const Icon(Icons.send),
                label: const Text('Kirim Laporan'),
              ),
            ],
          ),
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
