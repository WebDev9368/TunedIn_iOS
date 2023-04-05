import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../shared/utils/focus.dart';
import '../../../shared/utils/math_utils.dart';
import '../../../shared/widgets/common_appbar.dart';
import '../../../shared/widgets/common_button.dart';
import 'connect_controller.dart';

class ConnectView extends GetView<ConnectController> {
  const ConnectView({Key? key}) : super(key: key);

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
          return Padding(padding: const EdgeInsets.all(20),
              child: Column(
            children: [
              _buildAppleButton(controller),
              SizedBox(height: getSize(24)),
              _buildSpotifyButton(controller),
              SizedBox(height: getSize(24)),
              _buildHomeButton(controller)
            ],
          ));})
        );
  }
  Widget _buildAppleButton(ConnectController controller) {
      return CommonButton(
      textColor: controller.isApple.value == true
          ? Colors.white: Colors.white54,
      onPressed: () {
          controller.connectApple();
      },
      buttonText: controller.isApple.value == true
          ?'Connect to Apple Music' : 'Apple Music Connected',
    );
  }

  Widget _buildHomeButton(ConnectController controller) {
    return CommonButton(
      onPressed: () {
        controller.goHome();
      },
      buttonText: 'Get Started',
    );
  }
  Widget _buildSpotifyButton(ConnectController controller) {
      return CommonButton(
          buttonText: controller.isSpotify.value == false
          ?'Connect to Spotify':'Spotify Connected',
      onPressed: () {
          controller.connectSpotify();
      },
    textColor: controller.isSpotify.value == false
    ? Colors.white: Colors.white54);
  }
}
