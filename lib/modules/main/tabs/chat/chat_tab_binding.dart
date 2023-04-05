import 'package:get/get.dart';
import 'chat_tab_controller.dart';

class ChatTabBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => ChatTabController());
  }

}