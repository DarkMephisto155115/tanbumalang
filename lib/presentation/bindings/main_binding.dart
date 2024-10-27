import 'package:get/get.dart';
import 'package:tanbumalang/presentation/controller/biodata_controller.dart';
import 'package:tanbumalang/presentation/controller/login_controller.dart';
import 'package:tanbumalang/presentation/controller/registration_controller.dart';

import '../controller/home_controller.dart';

class MainBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(
      () => HomeController(),
    );
  }
}

class MenuBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(
          () => HomeController(),
    );
  }
}

class LoginBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<LoginController>(
          () => LoginController(),
    );
  }
}

class RegistrationBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<RegistrationController>(
          () => RegistrationController(),
    );
  }
}

class BiodataBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<BiodataController>(
          () => BiodataController(),
    );
  }
}

