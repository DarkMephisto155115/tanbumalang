import 'package:flutter/material.dart';

class InfoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green[300],
        title: Text('Info'),
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
            // Info Card 1
            InfoCard(
              title: 'Pendaftaran Universitas Muhammadiyah Malang',
              description:
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. Donec pede justo, fringilla vel, aliquet nec.',
            ),
            SizedBox(height: 16), // Space between cards
            // Info Card 2
            InfoCard(
              title: 'Beasiswa Tanah Bumbu',
              description:
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. Donec pede justo, fringilla vel, aliquet nec.',
            ),
            SizedBox(height: 16), // Space between cards
            // Info Card 3
            InfoCard(
              title: 'Fundraising untuk Rakyat yang membutuhkan',
              description:
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. Donec pede justo, fringilla vel, aliquet nec.',
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
        currentIndex: 3, // Set to the index of the current page
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
              Navigator.pushReplacementNamed(context, '/profile'); // Update the route name
              break;
          }
        },
      ),
    );
  }
}

// Custom widget for Info Card
class InfoCard extends StatelessWidget {
  final String title;
  final String description;

  InfoCard({required this.title, required this.description});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8), // Space between title and description
          Text(
            description,
            style: TextStyle(fontSize: 14),
          ),
          SizedBox(height: 8), // Space between description and photo
          Container(
            height: 100, // Placeholder height for photo
            color: Colors.grey[400], // Placeholder color for the photo
            child: Center(child: Text('Foto', style: TextStyle(color: Colors.white))),
          ),
        ],
      ),
    );
  }
}
