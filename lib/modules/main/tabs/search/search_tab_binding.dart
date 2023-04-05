import 'package:get/get.dart';
import 'package:tunedln/modules/main/tabs/search/search_tab_controller.dart';

class SearchTabBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => SearchTabController());
  }

}