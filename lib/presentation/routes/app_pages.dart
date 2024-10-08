import 'package:get/get.dart';
import 'package:tanbumalang/presentation/bindings/main_binding.dart';
import 'package:tanbumalang/presentation/pages/home_page.dart';
import 'package:tanbumalang/presentation/pages/login_page.dart';
import 'package:tanbumalang/presentation/pages/registration_page.dart';
import 'package:tanbumalang/presentation/pages/verification_page.dart';
part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.LOGIN;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
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
  ];
}
