import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tunedln/modules/auth/webView/web_views_controller.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../../../shared/utils/focus.dart';
import '../../../shared/utils/math_utils.dart';
import '../../../shared/widgets/common_appbar.dart';
import '../../../shared/widgets/common_button.dart';

class WebViewView extends GetView<WebViewsController> {
  const WebViewView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: BaseAppBar(
          title: '',
          showAppBarShadow: false,
          onPressedBack: () {
            AppFocus.unFocus();
            Get.back();
          },
        ),
        body: WebViewWidget(controller: controller.controller)
        );
  }

}
