import 'package:get/get.dart';
import 'package:tunedln/modules/auth/signup/sign_up_controller.dart';

class SignUpBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => SignUpController());
  }

}