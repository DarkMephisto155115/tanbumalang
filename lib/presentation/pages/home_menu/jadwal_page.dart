import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class KalenderPage extends StatelessWidget {
  final CollectionReference jadwalCollection = FirebaseFirestore.instance.collection('jadwal');
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  KalenderPage() {
    _initializeNotifications();
  }

  // Initialize notifications
  Future<void> _initializeNotifications() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
    AndroidInitializationSettings('app_icon');

    const InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
    );

    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  // Show notification
  Future<void> _showNotification(String title, String body) async {
    const AndroidNotificationDetails androidNotificationDetails =
    AndroidNotificationDetails(
      'jadwal_channel',
      'Jadwal Notifications',
      importance: Importance.high,
      priority: Priority.high,
    );

    const NotificationDetails notificationDetails =
    NotificationDetails(android: androidNotificationDetails);

    await flutterLocalNotificationsPlugin.show(
      0,
      title,
      body,
      notificationDetails,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        iconTheme: const IconThemeData(
          color: Colors.white, //change your color here
        ),
        title: const Text('Jadwal', style: TextStyle(color: Colors.white)),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset('assets/logo.png', width: 50, height: 50),
          ),
        ],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: jadwalCollection.snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return const Center(child: Text('Error loading data.'));
          }
          final documents = snapshot.data?.docs ?? [];

          // Sort events by date
          final now = DateTime.now();
          final upcomingEvents = <QueryDocumentSnapshot>[];
          final pastEvents = <QueryDocumentSnapshot>[];

          for (var doc in documents) {
            final dayData = doc.data() as Map<String, dynamic>;
            final date = dayData['date'] != null
                ? DateTime.parse(dayData['date'])
                : DateTime.now();
            if (date.isBefore(now)) {
              pastEvents.add(doc);
            } else {
              upcomingEvents.add(doc);
              // Send notification for upcoming events
              final title = dayData['title'] ?? 'No Title';
              final description = dayData['description'] ?? 'No Description';
              final formattedDate = DateFormat('dd-MM-yyyy, HH:mm')
                  .format(DateTime.parse(dayData['date'].toString()));

              _showNotification(
                'Upcoming Event: $title',
                '$description on $formattedDate',
              );
            }
          }

          // Sort the upcoming events by date
          upcomingEvents.sort((a, b) {
            final dateA = DateTime.parse(a['date']);
            final dateB = DateTime.parse(b['date']);
            return dateA.compareTo(dateB);
          });

          return ListView(
            children: [
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'Upcoming Events',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              ...upcomingEvents.map((document) {
                final dayData = document.data() as Map<String, dynamic>;
                final title = dayData['title'] ?? 'No Title';
                final date = dayData['date'] ?? 'No Date';
                final description = dayData['description'] ?? 'No Description';
                return ListTile(
                  title: Text(title),
                  subtitle: Text(
                    description + "\n" +
                        (DateFormat('dd-MM-yyyy, HH:mm')
                            .format(DateTime.parse(date.toString()))),
                  ),
                  leading: const Icon(Icons.event),
                );
              }),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'Past Events',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              ...pastEvents.map((document) {
                final dayData = document.data() as Map<String, dynamic>;
                final title = dayData['title'] ?? 'No Title';
                final date = dayData['date'] ?? 'No Date';
                final description = dayData['description'] ?? 'No Description';
                return ListTile(
                  title: Text(title),
                  subtitle: Text(
                    description + "\n" +
                        (DateFormat('dd-MM-yyyy, HH:mm')
                            .format(DateTime.parse(date.toString()))),
                  ),
                  leading: const Icon(Icons.event),
                );
              }),
            ],
          );
        },
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
