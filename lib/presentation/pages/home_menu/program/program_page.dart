import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import '../../../routes/app_pages.dart';

class ProgramPage extends StatefulWidget {
  const ProgramPage({super.key});

  @override
  _ProgramPageState createState() => _ProgramPageState();
}

class _ProgramPageState extends State<ProgramPage> {

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

class AdminProgramListPage extends StatefulWidget {
  const AdminProgramListPage({super.key});

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
        backgroundColor: Colors.green,
        child: const Icon(Icons.add),
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
      Get.snackbar(
        'Gagal',
        'Gagal menghapus program.',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }
}

class AdminProgramAddEditPage extends StatefulWidget {
  const AdminProgramAddEditPage({super.key});

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