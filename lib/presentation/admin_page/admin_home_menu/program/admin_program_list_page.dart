import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';


class AdminProgramListPage extends StatefulWidget {
  const AdminProgramListPage({super.key});

  @override
  _AdminProgramAddEditPageState createState() => _AdminProgramAddEditPageState();
}

class _AdminProgramAddEditPageState extends State<AdminProgramListPage> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _imageUrlController = TextEditingController();
  String? _selectedProgramType;
  String? _programId;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Menggunakan Get.arguments untuk mendapatkan data yang diteruskan
    final args = Get.arguments as Map<String, dynamic>?;
    if (args != null) {
      _programId = args['programId'];
      _titleController.text = args['programData']?['title'] ?? '';
      _imageUrlController.text = args['programData']?['imageUrl'] ?? '';
      _selectedProgramType = args['programType'];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_programId == null ? 'Tambah Program' : 'Edit Program'),
        backgroundColor: Colors.green[300],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(labelText: 'Judul Program'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Judul program tidak boleh kosong.';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _imageUrlController,
                decoration: const InputDecoration(labelText: 'URL Gambar'),
              ),
              const SizedBox(height: 20),
              DropdownButtonFormField<String>(
                value: _selectedProgramType,
                decoration: const InputDecoration(labelText: 'Tipe Program'),
                items: const [
                  DropdownMenuItem(value: 'Asrama', child: Text('Asrama')),
                  DropdownMenuItem(value: 'Himpunan', child: Text('Himpunan')),
                ],
                validator: (value) {
                  if (value == null) {
                    return 'Pilih tipe program.';
                  }
                  return null;
                },
                onChanged: (String? newValue) {
                  setState(() {
                    _selectedProgramType = newValue;
                  });
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate() &&
                      _selectedProgramType != null) {
                    try {
                      final programData = {
                        'title': _titleController.text,
                        'imageUrl': _imageUrlController.text,
                      };

                      String collectionName =
                          'program$_selectedProgramType';

                      if (_programId == null) {
                        // Tambah program baru
                        await FirebaseFirestore.instance
                            .collection(collectionName)
                            .add(programData);
                        Get.snackbar(
                          'Sukses',
                          'Program berhasil ditambahkan.',
                          snackPosition: SnackPosition.BOTTOM,
                          backgroundColor: Colors.green,
                          colorText: Colors.white,
                        );
                      } else {
                        // Edit program yang ada
                        await FirebaseFirestore.instance
                            .collection(collectionName)
                            .doc(_programId)
                            .update(programData);
                        Get.snackbar(
                          'Sukses',
                          'Program berhasil diupdate.',
                          snackPosition: SnackPosition.BOTTOM,
                          backgroundColor: Colors.green,
                          colorText: Colors.white,
                        );
                      }
                      Get.back(); // Kembali ke halaman admin program
                    } catch (e) {
                      Get.snackbar(
                        'Gagal',
                        'Gagal menyimpan program.',
                        snackPosition: SnackPosition.BOTTOM,
                        backgroundColor: Colors.red,
                        colorText: Colors.white,
                      );
                    }
                  }
                },
                style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                child: const Text('Simpan'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}