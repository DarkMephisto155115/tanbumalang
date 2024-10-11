import 'package:get/get.dart';
import 'package:tanbumalang/presentation/bindings/main_binding.dart';
import 'package:tanbumalang/presentation/pages/home_menu/absen_page.dart';
import 'package:tanbumalang/presentation/pages/home_page.dart';
import 'package:tanbumalang/presentation/pages/info_page.dart';
import 'package:tanbumalang/presentation/pages/login_page.dart';
import 'package:tanbumalang/presentation/pages/mutasi_page.dart';
import 'package:tanbumalang/presentation/pages/profil_menu/biodata_page.dart';
import 'package:tanbumalang/presentation/pages/profil_menu/chat_admin_page.dart';
import 'package:tanbumalang/presentation/pages/profil_menu/lapor_page.dart';
import 'package:tanbumalang/presentation/pages/profil_page.dart';
import 'package:tanbumalang/presentation/pages/registration_page.dart';
import 'package:tanbumalang/presentation/pages/verification_page.dart';

import '../pages/profil_menu/about_us_page.dart';
import '../pages/qr_scanner_page.dart';
part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.LOGIN;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomePage(),
      binding: MenuBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => LoginPage(),
      binding: MenuBinding(),
    ),
    GetPage(
      name: _Paths.REGISTRASI,
      page: () => RegistrationPage(),
      binding: MenuBinding(),
    ),
    GetPage(
      name: _Paths.VERIFIKASI,
      page: () => VerificationPage(),
      binding: MenuBinding(),
    ),
    GetPage(
      name: _Paths.MUTASI,
      page: () => MutasiPage(),
      binding: MenuBinding(),
    ),
    GetPage(
      name: _Paths.INFO,
      page: () => InfoPage(),
      binding: MenuBinding(),
    ),
    GetPage(
      name: _Paths.PROFIL,
      page: () => ProfilePage(),
      binding: MenuBinding(),
    ),
    // GetPage(
    //   name: _Paths.QRSCAN,
    //   page: () => QRScannerPage(),
    //   binding: MenuBinding(),
    // ),
    GetPage(
      name: _Paths.BIODATA,
      page: () => BiodataPage(),
      binding: MenuBinding(),
    ),
    GetPage(
      name: _Paths.LAPOR,
      page: () => LaporPage(),
      binding: MenuBinding(),
    ),
    GetPage(
      name: _Paths.CHAT,
      page: () => ChatAdminPage(),
      binding: MenuBinding(),
    ),
    GetPage(
      name: _Paths.ABOUTUS,
      page: () => AboutUsPage(),
      binding: MenuBinding(),
    ),
    GetPage(
      name: _Paths.ABSEN,
      page: () => AbsenPage(),
      binding: MenuBinding(),
    ),
  ];
}
