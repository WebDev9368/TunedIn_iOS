import 'package:get/get.dart';
import 'concerts_detail_controller.dart';

class ConcertsDetailBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => ConcertsDetailController());
  }
}