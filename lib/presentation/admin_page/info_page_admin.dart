import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controller/admin/admin_info_controller.dart';

class InfoPageAdmin extends StatelessWidget {
  final InfoController infoController = Get.put(InfoController());

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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              onChanged: (value) => infoController.titleController.value = value,
              decoration: const InputDecoration(labelText: 'Title'),
            ),
            TextField(
              onChanged: (value) => infoController.descriptionController.value = value,
              decoration: const InputDecoration(labelText: 'Description'),
              maxLines: 3,
            ),
            TextField(
              onChanged: (value) => infoController.urlController.value = value,
              decoration: const InputDecoration(labelText: 'URL'),
            ),
            const SizedBox(height: 16),
            Obx(() => infoController.imageFile.value == null
                ? GestureDetector(
              onTap: infoController.pickImage,
              child: Container(
                height: 100,
                width: double.infinity,
                color: Colors.grey[300],
                child: const Center(
                  child: Text('Select an Image'),
                ),
              ),
            )
                : Image.file(infoController.imageFile.value!, height: 100, fit: BoxFit.cover)),
            const SizedBox(height: 16),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
              onPressed: infoController.addInfo,
              child: const Text('Add Info', style: TextStyle(color: Colors.white),),
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
        currentIndex: 3,
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
}