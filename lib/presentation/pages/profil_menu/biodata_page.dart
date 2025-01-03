import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tanbumalang/presentation/controller/biodata_controller.dart';

class BiodataPage extends GetView<BiodataController> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        iconTheme: const IconThemeData(
          color: Colors.white, //change your color here
        ),
        title: const Text('Biodata', style: TextStyle(color: Colors.white)),
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
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: controller.isEditing.value ? controller.pickImage : null,
                  child: CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.grey[300],
                    backgroundImage: controller.profileImageUrl.value.isNotEmpty
                        ? NetworkImage(controller.profileImageUrl.value)
                        : null,
                    child: controller.profileImageUrl.value.isEmpty
                        ? Icon(Icons.person, size: 50, color: Colors.grey[700])
                        : null,
                  ),
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
                  isReadOnly: true,
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    if (controller.isEditing.value) {
                      controller.updateUserData();
                    }
                    controller.isEditing.toggle();
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
