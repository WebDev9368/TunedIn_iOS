import 'package:get/get.dart';
import 'package:tunedln/modules/auth/login/login_controller.dart';

class LoginBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => LoginController());
  }
}