import 'package:get/get.dart';
import 'package:tanbumalang/presentation/bindings/main_binding.dart';
import 'package:tanbumalang/presentation/pages/home_view.dart';
part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: MenuBinding(),
    ),
  ];
}
