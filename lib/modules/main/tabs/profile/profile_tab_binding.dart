import 'package:get/get.dart';
import 'package:tunedln/modules/main/tabs/profile/profile_tab_controller.dart';

class ProfileTabBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => ProfileTabController());
  }

}