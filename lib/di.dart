import 'package:get/get.dart';
import 'package:tunedln/shared/services/storage_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DependencyInjection {
  static final prefs = Get.find<SharedPreferences>();
  static var showLoader = true.obs;

  static Future<void> init() async {
    await Get.putAsync(() => StorageService().init());
  }
}
