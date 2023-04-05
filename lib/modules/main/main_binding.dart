import 'package:get/instance_manager.dart';
import 'main_controller.dart';

class MainBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MainController>(
      () => MainController(),
    );
  }
}
