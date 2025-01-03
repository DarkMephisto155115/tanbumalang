import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controller/admin/admin_jadwal_controller.dart';

class AdminJadwalPage extends StatelessWidget {
  final JadwalController jadwalController = Get.put(JadwalController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        iconTheme: const IconThemeData(
          color: Colors.white, //change your color here
        ),
        title: const Text('Add Jadwal', style: TextStyle(color: Colors.white)),
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
              controller: jadwalController.titleController,
              decoration: const InputDecoration(
                labelText: 'Title',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: jadwalController.dateController,
              readOnly: true,
              onTap: () async {
                final DateTime? date = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(2000),
                  lastDate: DateTime(2100),
                );
                if (date != null) {
                  final TimeOfDay? time = await showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.now(),
                  );
                  if (time != null) {
                    final DateTime selectedDateTime = DateTime(
                      date.year,
                      date.month,
                      date.day,
                      time.hour,
                      time.minute,
                    );
                    jadwalController.dateController.text =
                        selectedDateTime.toString();
                  }
                }
              },
              decoration: const InputDecoration(
                labelText: 'Date and Time',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: jadwalController.descriptionController,
              decoration: const InputDecoration(
                labelText: 'Description',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
              ),
              onPressed: () {
                jadwalController.addJadwal();
              },
              child: const Text('Add Jadwal', style: TextStyle(color: Colors.white),),
            ),
          ],
        ),
      ),
    );
  }
}
