import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import '../../../routes/app_pages.dart';

class ProgramPage extends StatefulWidget {
  @override
  _ProgramPageState createState() => _ProgramPageState();
}

class _ProgramPageState extends State<ProgramPage> {
  int _selectedIndex = 0;
  bool _isAdmin = true; // Contoh: Ganti dengan pengecekan admin yang sesuai

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    // Logika navigasi menggunakan GetX
    switch (index) {
      case 0: // Home
        Get.offNamed(Routes.HOME);
        break;
      case 1: // Mutasi
        Get.offNamed(Routes.MUTASI);
        break;
      case 3: // Info
        Get.offNamed(Routes.INFO);
        break;
      case 4: // Profile
        Get.offNamed(Routes.PROFIL);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green[300],
        title: const Text('Program'),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset('assets/logo.png', width: 50, height: 50), // Gambar logo
          ),
          if (_isAdmin) // Menampilkan tombol admin hanya jika pengguna adalah admin
            IconButton(
              icon: const Icon(Icons.settings),
              onPressed: () {
                Get.toNamed(Routes.ADMIN_PROGRAM_LIST);
              },
            ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            // Mengatur kotak ke kiri atas layar
            Column(
              crossAxisAlignment: CrossAxisAlignment.start, // Mengatur ke kiri
              children: [
                // Baris untuk mengatur Asrama dan Himpunan secara horizontal
                Row(
                  mainAxisAlignment: MainAxisAlignment.start, // Mengatur item ke awal
                  children: [
                    // Item grid pertama (Asrama)
                    GestureDetector(
                      onTap: () {
                        // Aksi ketika 'Asrama' ditekan
                        Get.toNamed(Routes.PROGRAM_ASRAMA);
                      },
                      child: Container(
                        margin: const EdgeInsets.only(right: 16), // Jarak antar kotak
                        child: SizedBox(
                          width: 70, // Lebar tetap
                          height: 70, // Tinggi tetap
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.black),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Image.asset('assets/asrama_icon.png', width: 30, height: 30), // Ikon Asrama
                                const SizedBox(height: 4), // Ruang yang diperkecil
                                const Text('Asrama', style: TextStyle(fontSize: 12)), // Teks yang lebih kecil
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),

                    // Item grid kedua (Himpunan)
                    GestureDetector(
                      onTap: () {
                        // Aksi ketika 'Himpunan' ditekan
                        Get.toNamed(Routes.PROGRAM_HIMPUNAN);
                      },
                      child: SizedBox(
                        width: 70, // Lebar tetap
                        height: 70, // Tinggi tetap
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset('assets/himpunan_icon.png', width: 30, height: 30), // Ikon Himpunan
                              const SizedBox(height: 4), // Ruang yang diperkecil
                              const Text('Himpunan', style: TextStyle(fontSize: 12)), // Teks yang lebih kecil
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
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
            label: 'Home',
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
                border: Border.all(color: Colors.black, width: 2),
              ),
              child: Padding(
                padding: const EdgeInsets.all(4.0),
                child: Image.asset('assets/icon_qr_code.png', fit: BoxFit.cover),
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
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}

class AdminProgramListPage extends StatefulWidget {
  @override
  _AdminProgramListPageState createState() => _AdminProgramListPageState();
}

class _AdminProgramListPageState extends State<AdminProgramListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Program'),
        backgroundColor: Colors.green[300],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.toNamed(Routes.ADMIN_PROGRAM_ADD_EDIT);
        },
        child: const Icon(Icons.add),
        backgroundColor: Colors.green,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collectionGroup('program').snapshots(), // Mengambil semua program
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Center(child: Text('Terjadi kesalahan.'));
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          return ListView(
            children: snapshot.data!.docs.map((DocumentSnapshot document) {
              Map<String, dynamic> data = document.data() as Map<String, dynamic>;
              String programType = document.reference.parent.id == 'programAsrama' ? 'Asrama' : 'Himpunan';
              return ListTile(
                title: Text(data['title'] ?? ''),
                subtitle: Text('Tipe: $programType'),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.edit, color: Colors.blue),
                      onPressed: () {
                        Get.toNamed(
                          Routes.ADMIN_PROGRAM_ADD_EDIT,
                          arguments: {'programData': data, 'programId': document.id, 'programType': programType},
                        );
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () => _deleteProgram(document.id, programType),
                    ),
                  ],
                ),
              );
            }).toList(),
          );
        },
      ),
    );
  }

  Future<void> _deleteProgram(String programId, String programType) async {
    try {
      await FirebaseFirestore.instance.collection('program$programType').doc(programId).delete();
      Get.snackbar(
        'Sukses',
        'Program berhasil dihapus.',
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (e) {
      print('Error deleting program: $e');
      Get.snackbar(
        'Gagal',
        'Gagal menghapus program.',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }
}

class AdminProgramAddEditPage extends StatefulWidget {
  @override
  _AdminProgramAddEditPageState createState() => _AdminProgramAddEditPageState();
}

class _AdminProgramAddEditPageState extends State<AdminProgramAddEditPage> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _imageUrlController = TextEditingController();
  String? _selectedProgramType;
  String? _programId;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args = Get.arguments as Map<String, dynamic>?;
    if (args != null && args['programData'] != null) {
      _programId = args['programId'];
      _titleController.text = args['programData']['title'] ?? '';
      _imageUrlController.text = args['programData']['imageUrl'] ?? '';
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
                  if (_formKey.currentState!.validate() && _selectedProgramType != null) {
                    try {
                      final programData = {
                        'title': _titleController.text,
                        'imageUrl': _imageUrlController.text,
                      };

                      String collectionName = 'program$_selectedProgramType';

                      if (_programId == null) {
                        // Tambah program baru
                        await FirebaseFirestore.instance.collection(collectionName).add(programData);
                        Get.snackbar(
                          'Sukses',
                          'Program berhasil ditambahkan.',
                          snackPosition: SnackPosition.BOTTOM,
                        );
                      } else {
                        // Edit program yang ada
                        await FirebaseFirestore.instance.collection(collectionName).doc(_programId).update(programData);
                        Get.snackbar(
                          'Sukses',
                          'Program berhasil diupdate.',
                          snackPosition: SnackPosition.BOTTOM,
                        );
                      }
                      Get.back(); // Kembali ke halaman admin program
                    } catch (e) {
                      print('Error saving program: $e');
                      Get.snackbar(
                        'Gagal',
                        'Gagal menyimpan program.',
                        snackPosition: SnackPosition.BOTTOM,
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