import 'package:get/get.dart';
import 'package:tunedln/modules/main/tabs/search/contacts/contacts_controller.dart';
import 'package:tunedln/modules/main/tabs/search/playlist/playlist_controller.dart';

class ContactsBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => ContactsController());
  }
}