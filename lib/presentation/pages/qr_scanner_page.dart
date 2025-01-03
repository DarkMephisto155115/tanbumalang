import 'package:flutter/material.dart';
import 'package:qr_code_scanner_plus/qr_code_scanner_plus.dart';

class QRScannerPage extends StatefulWidget {
  const QRScannerPage({super.key});

  @override
  State<QRScannerPage> createState() => _QRScannerScreenState();
}

class _QRScannerScreenState extends State<QRScannerPage> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? controller;
  String? qrCodeResult;

  @override
  void reassemble() {
    super.reassemble();
    if (controller != null) {
      if (mounted) {
        controller!.pauseCamera();
        controller!.resumeCamera();
      }
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset('assets/logo.png', width: 50, height: 50),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            flex: 5,
            child: QRView(
              key: qrKey,
              onQRViewCreated: _onQRViewCreated,
              overlay: QrScannerOverlayShape(
                borderColor: Colors.green,
                borderRadius: 10,
                borderLength: 30,
                borderWidth: 10,
                cutOutSize: 300,
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Center(
              child: qrCodeResult != null
                  ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Scanned Data: $qrCodeResult',
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green[300], // Button background color
                      foregroundColor: Colors.black, // Button text color
                    ),
                    onPressed: () {
                      Navigator.pop(context, qrCodeResult);
                      Navigator.pushNamed(context, '/qrscan');
                    },
                    child: const Text('Reset'),
                  ),
                ],
              )
                  : const Text(
                'Point your camera at a QR code to scan.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() => this.controller = controller);

    controller.scannedDataStream.listen((scanData) {
      setState(() {
        qrCodeResult = scanData.code; // Capture the scanned QR code result
        controller.pauseCamera(); // Stop scanning after the first result
      });
    });
  }
}
