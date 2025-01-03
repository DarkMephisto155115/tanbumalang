import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class ProofOfPaymentPage extends StatelessWidget {
  final String proofUrl;

  const ProofOfPaymentPage({super.key, required this.proofUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        iconTheme: const IconThemeData(
          color: Colors.white, //change your color here
        ),
        title: const Text('Bukti Pembayaran', style: TextStyle(color: Colors.white)),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset('assets/logo.png', width: 50, height: 50),
          ),
        ],
      ),
      body: Center(
        child: proofUrl.isNotEmpty
            ? Image.network(proofUrl)
            : const Text('Bukti pembayaran tidak tersedia'),
      ),
    );
  }
}

class PaymentDetailsPage extends StatefulWidget {
  final Map<String, dynamic> payment;

  const PaymentDetailsPage({super.key, required this.payment});

  @override
  _PaymentDetailsPageState createState() => _PaymentDetailsPageState();
}

class _PaymentDetailsPageState extends State<PaymentDetailsPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  String? _selectedPaymentMethod;
  File? _proofOfPayment;

  final List<String> _paymentMethods = ['Transfer Bank', 'E-Wallet', 'Kartu Kredit'];

  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _proofOfPayment = File(pickedFile.path);
      });
    }
  }

  Future<void> _processPayment() async {
    if (_nameController.text.isEmpty || _phoneController.text.isEmpty || _selectedPaymentMethod == null || _proofOfPayment == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Harap lengkapi semua data dan upload bukti pembayaran')),
      );
      return;
    }

    // Upload bukti pembayaran ke Firebase Storage
    final storageRef = FirebaseStorage.instance
        .ref()
        .child('proof_of_payments/${DateTime.now().millisecondsSinceEpoch}.png');
    await storageRef.putFile(_proofOfPayment!);
    final proofUrl = await storageRef.getDownloadURL();

    // Simpan data pembayaran ke Firestore
    await FirebaseFirestore.instance.collection('payments').add({
      'name': _nameController.text,
      'tagihan': widget.payment['name'],
      'phone': _phoneController.text,
      'paymentMethod': _selectedPaymentMethod,
      'proofOfPayment': proofUrl,
      'amount': widget.payment['amount'],
      'timestamp': Timestamp.now(),
    });

    // Beri notifikasi bahwa pembayaran berhasil disimpan
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Pembayaran berhasil dikirim')),
    );

    // Kembali ke halaman sebelumnya
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Pembayaran'),
        backgroundColor: Colors.green[300],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Tagihan: ${widget.payment['name']}', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            Text('Jumlah: ${widget.payment['amount']}', style: const TextStyle(fontSize: 16)),
            const SizedBox(height: 20),
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: 'Nama Lengkap'),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _phoneController,
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(labelText: 'Nomor Telepon'),
            ),
            const SizedBox(height: 10),
            DropdownButtonFormField<String>(
              decoration: const InputDecoration(labelText: 'Metode Pembayaran'),
              value: _selectedPaymentMethod,
              items: _paymentMethods.map((method) {
                return DropdownMenuItem(
                  value: method,
                  child: Text(method),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _selectedPaymentMethod = value;
                });
              },
            ),
            const SizedBox(height: 10),
            const Text('Bukti Pembayaran:', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            _proofOfPayment == null
                ? ElevatedButton(
              onPressed: _pickImage,
              child: const Text('Upload Bukti Pembayaran'),
            )
                : Image.file(_proofOfPayment!, height: 150, width: 150, fit: BoxFit.cover),
            const SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
              onPressed: _processPayment,
              child: const Text('Konfirmasi Pembayaran'),
            ),
          ],
        ),
      ),
    );
  }
}