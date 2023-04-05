import 'package:get/get.dart';
import 'discover_tab_controller.dart';

class DiscoverTabBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => DiscoverTabController());
  }

}