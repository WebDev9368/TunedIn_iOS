import 'package:get/get.dart';
import 'package:tunedln/modules/main/tabs/search/search_tab_controller.dart';

import 'bottom_tab_controller.dart';

class BottomTabBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => BottomTabController());
  }

}