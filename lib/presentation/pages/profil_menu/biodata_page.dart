import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tanbumalang/presentation/controller/biodata_controller.dart';


class BiodataPage extends GetView<BiodataController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green[300],
        title: const Text('Biodata'),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset('assets/logo.png', width: 50, height: 50),
          ),
        ],
      ),
      body: Obx(() {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center( // Center the entire content
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center, // Center items vertically
              crossAxisAlignment: CrossAxisAlignment.center, // Center items horizontally
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundColor: Colors.grey[300],
                  child: Icon(Icons.person, size: 50, color: Colors.grey[700]),
                ),
                const SizedBox(height: 20),
                buildBiodataItem(
                  icon: Icons.person,
                  label: "Nama",
                  controller: controller.nameController,
                  isReadOnly: !controller.isEditing.value,
                ),
                const SizedBox(height: 10),
                buildBiodataItem(
                  icon: Icons.school,
                  label: "Prodi",
                  controller: controller.prodiController,
                  isReadOnly: !controller.isEditing.value,
                ),
                const SizedBox(height: 10),
                buildBiodataItem(
                  icon: Icons.date_range,
                  label: "Angkatan",
                  controller: controller.angkatanController,
                  isReadOnly: !controller.isEditing.value,
                ),
                const SizedBox(height: 10),
                buildBiodataItem(
                  icon: Icons.email,
                  label: "Email",
                  controller: controller.emailController,
                  isReadOnly: !controller.isEditing.value,
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    if (controller.isEditing.value) {
                      controller.updateUserData(); // Save changes
                    }
                    controller.isEditing.toggle(); // Toggle editing state
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: controller.isEditing.value ? Colors.red : Colors.green,
                    foregroundColor: Colors.white,
                  ),
                  child: Text(controller.isEditing.value ? 'Save' : 'Edit'),
                ),
              ],
            ),
          ),
        );
      }),
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
        currentIndex: 4, // Set to the index of the current page
        onTap: (index) {
          switch (index) {
            case 0:
              Navigator.pushReplacementNamed(context, '/home');
              break;
            case 1:
              Navigator.pushReplacementNamed(context, '/mutasi');
              break;
            case 2:
            // QR Code Action
              break;
            case 3:
              Navigator.pushReplacementNamed(context, '/info');
              break;
            case 4:
            // Profile, already on this page
              break;
          }
        },
      ),
    );
  }

  // Helper method to build each biodata item
  Widget buildBiodataItem({
    required IconData icon,
    required String label,
    required TextEditingController controller,
    required bool isReadOnly,
  }) {
    return Row(
      children: [
        Icon(icon, size: 24),
        const SizedBox(width: 16),
        Expanded(
          child: TextFormField(
            controller: controller,
            decoration: InputDecoration(
              labelText: label,
              border: const OutlineInputBorder(),
            ),
            readOnly: isReadOnly, // Set read-only based on the editing state
          ),
        ),
      ],
    );
  }
}
