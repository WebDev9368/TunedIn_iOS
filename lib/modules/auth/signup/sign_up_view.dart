import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tunedln/modules/auth/signup/sign_up_controller.dart';
import 'package:tunedln/modules/auth/signup/widget/basic_detail_view.dart';
import 'package:tunedln/modules/auth/signup/widget/profile_detail_view.dart';
import '../../../shared/utils/focus.dart';
import '../../../shared/widgets/common_appbar.dart';

class SignUpView extends GetView<SignUpController> {
  const SignUpView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: BaseAppBar(
          title: '',
          showAppBarShadow: false,
          onPressedBack: () {
            AppFocus.unFocus();
            if (controller.currentView.value == 0) {
              Get.back();
            } else {
              controller.currentView.value = 0;
            }
          },
        ),
        body: Obx(() {
          return IndexedStack(
            index: controller.currentView.value,
            children: const [
              BasicDetailView(),
              ProfileDetailView(),
            ],
          );
        }));
  }
}
