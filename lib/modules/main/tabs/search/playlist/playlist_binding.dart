import 'package:get/get.dart';
import 'package:tunedln/modules/main/tabs/search/playlist/playlist_controller.dart';

class PlayListBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => PlayListController());
  }
}