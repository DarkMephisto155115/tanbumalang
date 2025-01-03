import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutUsPage extends StatelessWidget {
  final String mapsUrl = "https://maps.app.goo.gl/8ozDrQ5oignMJXp47";

  const AboutUsPage({super.key});

  Future<void> _openMap() async {
    if (await canLaunch(mapsUrl)) {
      await launch(mapsUrl);
    } else {
      throw "Could not launch $mapsUrl";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green,
          title: const Text('Tentang Kami', style: TextStyle(color: Colors.white)),
          iconTheme: const IconThemeData(
            color: Colors.white, //change your color here
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset('assets/logo.png', width: 50, height: 50),
            ),
          ],
        ),
        body: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Gambar/Logo
                Center(
                  child: Container(
                    width: 150,
                    height: 150,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: AssetImage('assets/logo.png'), // Ganti dengan logo yang sesuai
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                // Deskripsi singkat
                const Text(
                  'Himpunan Mahasiswa Kabupaten Tanah Bumbu',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 10),
                const Text(
                  'Himpunan Mahasiswa Kabupaten Tanah Bumbu ialah wadah aktualisasi bagi kawan-kawan mahasiswa yang sedang menuntut ilmu pengetahuan di perguruan tinggi. Organisasi non-politik yang berfungsi menyambung tali persaudaraan antara mahasiswa agar terciptanya ukhuwah dan kerukunan, demi tercapainya SDM yang berkualitas.',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black54,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),

                Container(
                  width: double.infinity,
                  height: 400,
                  color: Colors.grey[300],
                  child: Image.asset(
                    'assets/map_image.png', // Static map image asset (replace with your map asset)
                    fit: BoxFit.cover,
                  ),
                ),

                // Tombol untuk membuka peta
                Card(
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        const Text(
                          "Klik tombol di bawah untuk membuka lokasi asrama di Google Maps:",
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 16),
                        ),
                        const SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: _openMap,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green[300],
                            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: const Text(
                            "Buka Peta",
                            style: TextStyle(fontSize: 18, color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                // Footer atau informasi tambahan
                const Center(
                  child: Text(
                    'Terima kasih telah mengunjungi kami!',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.black45,
                    ),
                  ),
                ),
              ],
            ),
            ),
        );
  }
}