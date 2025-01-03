import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../controller/admin/admin_laporan_controller.dart';

class LaporanUserPage extends StatefulWidget {
  const LaporanUserPage({super.key});

  @override
  _LaporanUserPageState createState() => _LaporanUserPageState();
}

class _LaporanUserPageState extends State<LaporanUserPage> {
  final LaporanController _laporanController = LaporanController();
  List<Map<String, dynamic>> _userReports = [];

  @override
  void initState() {
    super.initState();
    _loadAllReports();
  }

  Future<void> _loadAllReports() async {
    try {
      final reports = await _laporanController.fetchAllReports();

      // Sort reports by timestamp in descending order
      reports.sort((a, b) {
        final aTimestamp = a['timestamp'].toDate();
        final bTimestamp = b['timestamp'].toDate();
        return bTimestamp.compareTo(aTimestamp);
      });

      setState(() {
        _userReports = reports;
      });
    } catch (e) {
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text('Laporan User', style: TextStyle(color: Colors.white)),
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
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: _userReports.isEmpty
                  ? const Center(child: CircularProgressIndicator())
                  : ListView.builder(
                itemCount: _userReports.length,
                itemBuilder: (context, index) {
                  final report = _userReports[index];
                  return Column(
                    children: [
                      _buildChatBubble(
                        report['username'] ?? 'Unknown',
                        report['text'] ?? 'No details provided',
                        report['username'] == 'admin' ? false : true,
                        report['timestamp'].toDate() ?? 'Just now',
                        report['profileImageUrl'] ?? 'unknown',
                      ),
                      const SizedBox(height: 16),
                    ],
                  );
                },
              ),
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

  // Method to build chat bubble UI with animation
  Widget _buildChatBubble(String username, String laporan, bool isUserMessage, DateTime time, String imageURL) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      transform: Matrix4.translationValues(0.0, 10.0, 0.0),
      child: Row(
        mainAxisAlignment:
        isUserMessage ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          if (!isUserMessage)
            CircleAvatar(
              backgroundImage: imageURL.isNotEmpty
                  ? NetworkImage(imageURL)
                  : null,
              radius: 20,
              child: imageURL.isEmpty
                  ? Icon(Icons.person, size: 50, color: Colors.grey[700])
                  : null,
            ),
          const SizedBox(width: 8),
          Flexible(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                gradient: isUserMessage
                    ? LinearGradient(
                  colors: [Colors.green[100]!, Colors.green[200]!],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                )
                    : LinearGradient(
                  colors: [Colors.grey[300]!, Colors.grey[500]!],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(16),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    offset: Offset(0, 4),
                    blurRadius: 10,
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    username,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: isUserMessage ? Colors.green[800] : Colors.black,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    laporan,
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    DateFormat('dd-MM-yyyy, HH:mm').format(DateTime.parse(time.toString())).toString(),
                    style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 8),
          if (isUserMessage)
            CircleAvatar(
              backgroundImage: imageURL.isNotEmpty
                  ? NetworkImage(imageURL)
                  : null,
              radius: 20,
              child: imageURL.isEmpty
                  ? Icon(Icons.person, size: 50, color: Colors.grey[700])
                  : null,
            ),
        ],
      ),
    );
  }
}