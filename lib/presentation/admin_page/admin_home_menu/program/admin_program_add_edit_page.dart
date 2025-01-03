import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class AdminProgramAddEditPagee extends StatefulWidget {
  @override
  _AdminProgramAddEditPageState createState() => _AdminProgramAddEditPageState();
}

class _AdminProgramAddEditPageState extends State<AdminProgramAddEditPagee> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  String? _selectedProgramType;
  String? _programId;
  File? _imageFile;
  String? _uploadedImageUrl;
  bool _isUploading = false;

  final ImagePicker _picker = ImagePicker();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    if (args != null && args['programData'] != null) {
      _programId = args['programId'];
      _titleController.text = args['programData']['title'] ?? '';
      _uploadedImageUrl = args['programData']['imageUrl'] ?? '';
      _selectedProgramType = args['programType'];
    }
  }

  Future<void> _pickImage(ImageSource source) async {
    try {
      final pickedFile = await _picker.pickImage(
        source: source,
        maxWidth: 800,
        maxHeight: 800,
        imageQuality: 80,
      );

      if (pickedFile != null) {
        setState(() {
          _imageFile = File(pickedFile.path);
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Gagal memilih gambar.')),
      );
    }
  }

  Future<String?> _uploadImage(File image) async {
    try {
      String fileName = '${DateTime.now().millisecondsSinceEpoch}.jpg';
      Reference storageRef = FirebaseStorage.instance.ref().child('program_images').child(fileName);
      UploadTask uploadTask = storageRef.putFile(image);

      TaskSnapshot snapshot = await uploadTask;
      String downloadUrl = await snapshot.ref.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Gagal mengupload gambar.')),
      );
      return null;
    }
  }

  Widget _buildImagePreview() {
    if (_imageFile != null) {
      return Image.file(
        _imageFile!,
        height: 200,
        width: double.infinity,
        fit: BoxFit.cover,
      );
    } else if (_uploadedImageUrl != null && _uploadedImageUrl!.isNotEmpty) {
      return Image.network(
        _uploadedImageUrl!,
        height: 200,
        width: double.infinity,
        fit: BoxFit.cover,
      );
    } else {
      return Container(
        height: 200,
        color: Colors.grey[300],
        child: const Icon(
          Icons.image,
          size: 100,
          color: Colors.white,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        iconTheme: const IconThemeData(
          color: Colors.white, //change your color here
        ),
        title: const Text('Tambah Program', style: TextStyle(color: Colors.white)),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset('assets/logo.png', width: 50, height: 50),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: _isUploading
            ? const Center(child: CircularProgressIndicator())
            : Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              _buildImagePreview(),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton.icon(
                    onPressed: () => _pickImage(ImageSource.camera),
                    icon: const Icon(Icons.camera_alt, color: Colors.white),
                    label: const Text('Kamera', style: TextStyle(color: Colors.white)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                    ),
                  ),
                  ElevatedButton.icon(
                    onPressed: () => _pickImage(ImageSource.gallery),
                    icon: const Icon(Icons.photo_library, color: Colors.white),
                    label: const Text('Galeri', style: TextStyle(color: Colors.white)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
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
                onPressed: _saveProgram,
                style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                child: const Text('Simpan', style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _saveProgram() async {
    if (_formKey.currentState!.validate() && _selectedProgramType != null) {
      setState(() {
        _isUploading = true;
      });

      String? imageUrl = _uploadedImageUrl;

      // If a new image is selected, upload it
      if (_imageFile != null) {
        String? uploadedUrl = await _uploadImage(_imageFile!);
        if (uploadedUrl != null) {
          imageUrl = uploadedUrl;
        } else {
          setState(() {
            _isUploading = false;
          });
          return;
        }
      }

      try {
        final programData = {
          'title': _titleController.text,
          'imageUrl': imageUrl ?? '',
        };

        String collectionName = 'program$_selectedProgramType';

        if (_programId == null) {
          // Tambah program baru
          await FirebaseFirestore.instance.collection(collectionName).add(programData);
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Program berhasil ditambahkan.')),
          );
        } else {
          // Edit program yang ada
          await FirebaseFirestore.instance.collection(collectionName).doc(_programId).update(programData);
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Program berhasil diupdate.')),
          );
        }
        Navigator.pop(context); // Kembali ke halaman admin program
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Gagal menyimpan program.')),
        );
      } finally {
        setState(() {
          _isUploading = false;
        });
      }
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }
}
