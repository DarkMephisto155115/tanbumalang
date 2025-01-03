import 'package:get/get.dart';
import 'package:tanbumalang/presentation/admin_page/admin_home_menu/absen/absen_page_admin.dart';
import 'package:tanbumalang/presentation/admin_page/admin_profil_menu/chat_page_admin.dart';
import 'package:tanbumalang/presentation/admin_page/home_page_admin.dart';
import 'package:tanbumalang/presentation/admin_page/info_page_admin.dart';
import 'package:tanbumalang/presentation/admin_page/mutasi_page_admin.dart';
import 'package:tanbumalang/presentation/admin_page/profil_page_admin.dart';
import 'package:tanbumalang/presentation/bindings/main_binding.dart';
import 'package:tanbumalang/presentation/pages/home_menu/absen/absen_page.dart';
import 'package:tanbumalang/presentation/pages/home_menu/keuangan/keungan_page.dart';
import 'package:tanbumalang/presentation/pages/home_menu/keuangan/pembayaran_asrama.dart';
import 'package:tanbumalang/presentation/pages/home_menu/program/asrama_program_page.dart';
import 'package:tanbumalang/presentation/pages/home_menu/program/himpunan_program_page.dart';
import 'package:tanbumalang/presentation/pages/home_menu/program/program_page.dart';
import 'package:tanbumalang/presentation/pages/home_page.dart';
import 'package:tanbumalang/presentation/pages/info_page.dart';
import 'package:tanbumalang/presentation/pages/login_page.dart';
import 'package:tanbumalang/presentation/pages/mutasi_page.dart';
import 'package:tanbumalang/presentation/pages/profil_menu/biodata_page.dart';
import 'package:tanbumalang/presentation/pages/profil_menu/chat_page.dart';
import 'package:tanbumalang/presentation/pages/profil_menu/lapor_page.dart';
import 'package:tanbumalang/presentation/pages/profil_page.dart';
import 'package:tanbumalang/presentation/pages/registration_page.dart';
import 'package:tanbumalang/presentation/pages/splash_screen.dart';
import 'package:tanbumalang/presentation/pages/verification_page.dart';

import '../admin_page/admin_home_menu/absen/absen_page_detail.dart';
import '../admin_page/admin_home_menu/admin_jadwal_page.dart';
import '../admin_page/admin_home_menu/keuangan/admin_keuangan_page.dart';
import '../admin_page/admin_home_menu/location_page.dart';
import '../admin_page/admin_profil_menu/laporan_page.dart';
import '../admin_page/admin_home_menu/program/admin_program_add_edit_page.dart';
import '../pages/home_menu/absen/absen_page_list.dart';
import '../pages/home_menu/jadwal_page.dart';
import '../pages/home_menu/keuangan/pembayaran_himpunan.dart';
import '../pages/profil_menu/about_us_page.dart';
import '../pages/qr_scanner_page.dart';
part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SPLASH;

  static final routes = [
    GetPage(
      name: _Paths.SPLASH,
      page: () => const SplashScreen(),
    ),
    GetPage(
      name: _Paths.HOME,
      page: () => const HomePage(),
      binding: MenuBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => const LoginPage(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.REGISTRASI,
      page: () => const RegistrationPage(),
      binding: RegistrationBinding(),
    ),
    GetPage(
      name: _Paths.VERIFIKASI,
      page: () => const VerificationPage(),
      binding: MenuBinding(),
    ),
    GetPage(
      name: _Paths.MUTASI,
      page: () => const MutasiPage(),
      binding: MenuBinding(),
    ),
    GetPage(
      name: _Paths.INFO,
      page: () => InfoPage(),
      binding: MenuBinding(),
    ),
    GetPage(
      name: _Paths.PROFIL,
      page: () => const ProfilePage(),
      binding: MenuBinding(),
    ),
    GetPage(
      name: _Paths.QRSCAN,
      page: () => const QRScannerPage(),
      binding: MenuBinding(),
    ),
    GetPage(
      name: _Paths.BIODATA,
      page: () => BiodataPage(),
      binding: BiodataBinding(),
    ),
    GetPage(
      name: _Paths.LAPOR,
      page: () => LaporPage(),
      binding: LaporBinding(),
    ),
    GetPage(
      name: _Paths.CHAT,
      page: () => ChatPage(),
      binding: MenuBinding(),
    ),
    GetPage(
      name: _Paths.ABOUTUS,
      page: () => const AboutUsPage(),
      binding: MenuBinding(),
    ),
    GetPage(
      name: _Paths.JADWAL,
      page: () => KalenderPage(),
      binding: MenuBinding(),
    ),
    GetPage(
      name: _Paths.ABSEN,
      page: () => const AbsenPage(formId: '',),
      binding: MenuBinding(),
    ),
    GetPage(
      name: _Paths.ABSEN_LIST,
      page: () => const AttendanceListPage(),
      binding: MenuBinding(),
    ),
    GetPage(
      name: _Paths.KEUANGAN,
      page: () => const KeuanganPage(),
      binding: MenuBinding(),
    ),
    GetPage(
      name: _Paths.PEMBAYARAN_ASRAMA,
      page: () => const PembayaranAsramaPage(),
      binding: MenuBinding(),
    ),
    GetPage(
      name: _Paths.PEMBAYARAN_HIMPUNAN,
      page: () => const PembayaranHimpunanPage(),
      binding: MenuBinding(),
    ),
    GetPage(
      name: _Paths.PROGRAM,
      page: () => const ProgramPage(),
      binding: MenuBinding(),
    ),
    GetPage(
      name: _Paths.PROGRAM_ASRAMA,
      page: () => const AsramaProgramPage(),
      binding: MenuBinding(),
    ),
    GetPage(
      name: _Paths.PROGRAM_HIMPUNAN,
      page: () => const HimpunanProgramPage(),
      binding: MenuBinding(),
    ),


    //ADMIN
    GetPage(
      name: _Paths.HOME_ADMIN,
      page: () => const HomePageAdmin(),
      binding: MenuBinding(),
    ),
    GetPage(
      name: _Paths.KEUANGAN_ADMIN,
      page: () => const KeuanganAdminPage(),
      binding: MenuBinding(),
    ),
    GetPage(
      name: _Paths.ABSEN_ADMIN,
      page: () => const AdminAttendancePage(),
      binding: MenuBinding(),
    ),
    GetPage(
      name: _Paths.ABSEN_DETAIL_ADMIN,
      page: () => const AdminFormDetailPage(formId: '',),
      binding: MenuBinding(),
    ),
    GetPage(
      name: _Paths.LOCATION,
      page: () => LocationPage(),
      binding: MenuBinding(),
    ),
    GetPage(
      name: _Paths.PROFIL_ADMIN,
      page: () => ProfilePageAdmin(),
      binding: MenuBinding(),
    ),
    GetPage(
      name: _Paths.CHAT_ADMIN,
      page: () => const ChatPageAdmin(),
      binding: MenuBinding(),
    ),
    GetPage(
      name: _Paths.LAPORAN,
      page: () => const LaporanUserPage(),
      binding: MenuBinding(),
    ),
    GetPage(
      name: _Paths.INFO_ADMIN,
      page: () => InfoPageAdmin(),
      binding: MenuBinding(),
    ),
    GetPage(
      name: _Paths.JADWAL_ADMIN,
      page: () => AdminJadwalPage(),
      binding: MenuBinding(),
    ),
    GetPage(
      name: _Paths.MUTASI_ADMIN,
      page: () => MutasiPageAdmin(),
      binding: MenuBinding(),
    ),
    GetPage(
      name: _Paths.ADMIN_PROGRAM_LIST,
      page: () => const AdminProgramListPage(),
      binding:
      MenuBinding(), // Anda bisa membuat binding khusus jika diperlukan
    ),
    GetPage(
        name: _Paths.ADMIN_PROGRAM_ADD_EDIT,
        page: () => AdminProgramAddEditPagee(),
        binding:
        MenuBinding(), // Anda bisa membuat binding khusus jika diperlukan
        ),

  ];
}
