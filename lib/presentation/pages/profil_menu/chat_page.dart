import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart'; // Import Font Awesome
import 'package:url_launcher/url_launcher.dart';
import 'package:whatsapp_unilink/whatsapp_unilink.dart';


class ChatPage extends StatefulWidget {
  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  List<Map<String, dynamic>> messages = [
    {'text': 'Min, boleh tanya?', 'isUserMessage': true, 'time': '2:00pm'},
    {'text': 'Tanya apa kak?', 'isUserMessage': false, 'time': '2:01pm'},
  ];

  final TextEditingController _messageController = TextEditingController();

  void _sendMessage() {
    if (_messageController.text.isNotEmpty) {
      setState(() {
        messages.add({
          'text': _messageController.text,
          'isUserMessage': true,
          'time': '2:02pm',
        });
        _messageController.clear();
      });
    }
  }

  void _launchWhatsApp() async {
    const link = WhatsAppUnilink(
      phoneNumber: '+6281556968733', // Ganti dengan nomor yang benar
      text: 'Hello, I need assistance!',
    );

    await launch(link.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green[300],
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: const Text('Chat Admin'),
          actions: [
            IconButton(
              icon: const FaIcon(
                FontAwesomeIcons.whatsapp, // Menggunakan WhatsApp Icon dari FontAwesome
                color: Colors.white,
                size: 30,
              ),
              onPressed: _launchWhatsApp,
            ),
          ],
        ),
        body: Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Connected to Admin',
                style: TextStyle(color: Colors.grey),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: messages.length,
                itemBuilder: (context, index) {
                  return Align(
                    alignment: messages[index]['isUserMessage']
                        ? Alignment.centerRight
                        : Alignment.centerLeft,
                    child: Container(
                      margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: messages[index]['isUserMessage']
                            ? Colors.green[100]
                            : Colors.grey[300],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            messages[index]['text'],
                            style: const TextStyle(fontSize: 16),
                          ),
                          Align(
                            alignment: Alignment.bottomRight,
                            child: Text(
                              messages[index]['time'],
                              style: TextStyle(
                                  fontSize: 12, color: Colors.grey[600]),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _messageController,
                      decoration: InputDecoration(
                        hintText: 'Type your message...',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  GestureDetector(
                    onTap: _sendMessage,
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.green[300],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Icon(
                        Icons.send,
                        color: Colors.white,
                      ),
                    ),
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
                // TBA
                  break;
                case 3:
                  Navigator.pushReplacementNamed(context, '/info');
                  break;
                case 4:
                  break;
              }
            },
            ),
        );
    }
}