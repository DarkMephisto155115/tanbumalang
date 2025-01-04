import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'absen_page_detail.dart';

class AdminAttendancePage extends StatefulWidget {
  const AdminAttendancePage({super.key});

  @override
  _AdminAttendancePageState createState() => _AdminAttendancePageState();
}

class _AdminAttendancePageState extends State<AdminAttendancePage> {
  final _titleController = TextEditingController();
  bool _isSubmitting = false;

  Future<void> _createForm() async {
    if (_titleController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Judul absensi tidak boleh kosong!")),
      );
      return;
    }

    setState(() {
      _isSubmitting = true;
    });

    try {
      // Create the form in Firestore
      await FirebaseFirestore.instance.collection('forms').add({
        'title': _titleController.text,
        'timestamp': FieldValue.serverTimestamp(),
      });

      _titleController.clear();  // Clear the input after successful creation.

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Form absensi berhasil dibuat!")),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Gagal membuat form: $e")),
      );
    } finally {
      setState(() {
        _isSubmitting = false;
      });
    }
  }

  Future<void> _updateForm(String formId) async {
    final _updateTitleController = TextEditingController();
    final formSnapshot = await FirebaseFirestore.instance.collection('forms').doc(formId).get();
    _updateTitleController.text = formSnapshot['title'];

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Perbarui Form Absensi"),
        content: TextField(
          controller: _updateTitleController,
          decoration: const InputDecoration(labelText: "Judul Absensi"),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text("Batal"),
          ),
          TextButton(
            onPressed: () async {
              if (_updateTitleController.text.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Judul absensi tidak boleh kosong!")),
                );
                return;
              }
              await FirebaseFirestore.instance.collection('forms').doc(formId).update({
                'title': _updateTitleController.text,
              });
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Form absensi berhasil diperbarui!")),
              );
            },
            child: const Text("Perbarui"),
          ),
        ],
      ),
    );
  }

  Future<void> _deleteForm(String formId) async {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Hapus Form Absensi"),
        content: const Text("Apakah Anda yakin ingin menghapus form ini?"),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text("Batal"),
          ),
          TextButton(
            onPressed: () async {
              await FirebaseFirestore.instance.collection('forms').doc(formId).delete();
              Navigator.pop(context);
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Form absensi berhasil dihapus!")),
              );
            },
            child: const Text("Hapus"),
          ),
        ],
      ),
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
        title: const Text('Absensi', style: TextStyle(color: Colors.white)),
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
            // Create Form Section
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(
                labelText: "Judul Absensi",
                hintText: "Contoh: Absensi Kelas PBO",
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
              ),
              onPressed: _isSubmitting ? null : _createForm,
              child: _isSubmitting
                  ? const CircularProgressIndicator(color: Colors.white)
                  : const Text("Buat Form Absensi", style: TextStyle(color: Colors.white),),
            ),
            const SizedBox(height: 32),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('forms')
                    .orderBy('timestamp', descending: true)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return const Center(child: Text("Belum ada form absensi."));
                  }

                  final forms = snapshot.data!.docs;

                  return ListView.builder(
                    itemCount: forms.length,
                    itemBuilder: (context, index) {
                      final form = forms[index];
                      final title = form.get('title') ?? 'Tanpa Judul';
                      final formId = form.id;

                      return Card(
                        margin: const EdgeInsets.all(8.0),
                        child: ListTile(
                          title: Text(title),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => AdminFormDetailPage(formId: formId),
                              ),
                            );
                          },
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.edit),
                                onPressed: () {
                                  _updateForm(formId);
                                },
                              ),
                              IconButton(
                                icon: const Icon(Icons.delete),
                                onPressed: () {
                                  _deleteForm(formId);
                                },
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
