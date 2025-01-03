import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Map<String, dynamic>? userData;

  @override
  void initState() {
    super.initState();
    fetchUserData(); // Fetch user data when the widget is initialized
  }

  Future<void> fetchUserData() async {
    try {
      User? currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser != null) {
        DocumentSnapshot<Map<String, dynamic>> userDoc = await FirebaseFirestore.instance
            .collection('users')
            .doc(currentUser.uid)
            .get();

        setState(() {
          userData = userDoc.data();
        });
      }
    } catch (e) {
    }
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
      body: Column(
        children: [
          // Profile Section
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              // border: Border.all(color: Colors.green.shade300,width: 2),
              // border: Border(bottom:  BorderSide(color: Colors.green.shade300, width: 2))
              // borderRadius: const BorderRadius.only(
              //   bottomLeft: Radius.circular(20),
              //   bottomRight: Radius.circular(20),
              // ),
            ),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundImage: userData != null && userData!['profileImageUrl'] != null
                      ? NetworkImage(userData!['profileImageUrl'])
                      : const AssetImage('assets/profile_placeholder.png') as ImageProvider,
                  backgroundColor: Colors.grey[300],
                ),
                const SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      userData != null ? 'Welcome, ${userData!['username']}' : 'Welcome',
                      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      userData != null ? 'Angkatan: ${userData!['angkatan']}' : '',
                      style: const TextStyle(fontSize: 16, color: Colors.black54),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      userData != null ? 'Prodi: ${userData!['prodi']}' : '',
                      style: const TextStyle(fontSize: 16, color: Colors.black54),
                    ),
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
                  buildMenuItem('assets/jadwal.png', 'Jadwal', '/jadwal', 40),
                  buildMenuItem('assets/keuangan.png', 'Keuangan', '/keuangan', 40),
                  buildMenuItem('assets/absen.png', 'Absen', '/absen_list', 40),
                  buildMenuItem('assets/program.png', 'Program', '/program', 40),
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
