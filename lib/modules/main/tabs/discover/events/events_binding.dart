import 'package:get/get.dart';
import 'package:tunedln/modules/main/tabs/discover/events/events_controller.dart';

class EventsBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => EventsController());
  }
}