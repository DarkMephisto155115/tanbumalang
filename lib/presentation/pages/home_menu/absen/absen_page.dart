import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

class AbsenPage extends StatefulWidget {
  final String formId;

  const AbsenPage({super.key, required this.formId});

  @override
  _AbsenPageState createState() => _AbsenPageState();
}

class _AbsenPageState extends State<AbsenPage> {
  Map<String, dynamic>? userData;
  File? _selectedImage;
  bool _isSubmitting = false;
  String _selectedAttendance = 'Hadir';
  bool _hasSubmitted = false;

  @override
  void initState() {
    super.initState();
    fetchUserData();
    _checkIfUserHasSubmitted();
  }

  Future<void> fetchUserData() async {
    try {
      User? currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser != null) {
        // Fetch user data from Firestore
        DocumentSnapshot<Map<String, dynamic>> userDoc = await FirebaseFirestore.instance
            .collection('users')
            .doc(currentUser.uid)
            .get();

        setState(() {
          userData = userDoc.data();  // Store user data
        });
      }
    } catch (e) {
      print("Error fetching user data: $e");
    }
  }

  Future<void> _checkIfUserHasSubmitted() async {
    User? currentUser = FirebaseAuth.instance.currentUser;
    final userId = currentUser?.uid;

    if (userId == null) return;

    final responseSnapshot = await FirebaseFirestore.instance
        .collection('forms')
        .doc(widget.formId)
        .collection('responses')
        .where('userId', isEqualTo: userId)
        .get();

    if (responseSnapshot.docs.isNotEmpty) {
      setState(() {
        _hasSubmitted = true;
      });
    }
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
    }
  }

  Future<void> _submitForm() async {
    if (_selectedImage == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Unggah foto untuk melanjutkan!")),
      );
      return;
    }

    if (userData == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Data pengguna tidak ditemukan.")),
      );
      return;
    }

    setState(() {
      _isSubmitting = true;
    });

    try {
      // Upload photo to Firebase Storage
      final storageRef = FirebaseStorage.instance
          .ref()
          .child('attendance_photos')
          .child('${DateTime.now().millisecondsSinceEpoch}.jpg');
      await storageRef.putFile(_selectedImage!);
      final photoUrl = await storageRef.getDownloadURL();

      // Save the response to Firestore
      await FirebaseFirestore.instance
          .collection('forms')
          .doc(widget.formId)
          .collection('responses')
          .add({
        'attendance': _selectedAttendance,
        'photoUrl': photoUrl,
        'timestamp': FieldValue.serverTimestamp(),
        'userId': FirebaseAuth.instance.currentUser?.uid,
        'username': userData?['username'],
        'prodi': userData?['prodi'],
        'angkatan': userData?['angkatan'],
        'profileImageUrl': userData?['profileImageUrl'],
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Form berhasil dikirim!")),
      );
      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Gagal mengirim form: $e")),
      );
    } finally {
      setState(() {
        _isSubmitting = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_hasSubmitted) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green,
          iconTheme: const IconThemeData(
            color: Colors.white, //change your color here
          ),
          title: const Text('Form Kehadiran', style: TextStyle(color: Colors.white)),
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset('assets/logo.png', width: 50, height: 50),
            ),
          ],
        ),
        body: const Center(
          child: Text("Anda sudah mengisi absensi untuk form ini."),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Form Kehadiran"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DropdownButton<String>(
              value: _selectedAttendance,
              items: ['Hadir', 'Tidak Hadir']
                  .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                  .toList(),
              onChanged: (value) {
                setState(() {
                  _selectedAttendance = value!;
                });
              },
            ),
            const SizedBox(height: 16),
            const Text("Unggah Foto Bukti"),
            const SizedBox(height: 8),
            _selectedImage == null
                ? const Text("Belum ada foto yang dipilih.")
                : Image.file(_selectedImage!, height: 150, width: 150),
            TextButton.icon(
              onPressed: _pickImage,
              icon: const Icon(Icons.photo_library),
              label: const Text("Pilih Foto"),
            ),
            const Spacer(),
            ElevatedButton(
              onPressed: _isSubmitting ? null : _submitForm,
              child: _isSubmitting
                  ? const CircularProgressIndicator(color: Colors.white)
                  : const Text("Kirim"),
            ),
          ],
        ),
      ),
    );
  }
}
