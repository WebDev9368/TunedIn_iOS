import 'package:get/get.dart';
import 'package:tunedln/modules/auth/webView/web_views_controller.dart';

class WebViewBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => WebViewsController());
  }

}