import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tunedln/shared/widgets/common_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tunedln/modules/splash/splash_controller.dart';
import 'package:tunedln/shared/utils/image_utils.dart';
import '../../routes/app_pages.dart';
import '../../shared/constants/color_constants.dart';
import '../../shared/utils/math_utils.dart';

class SplashScreen extends GetView<SplashController> {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(),
      bottomSheet: _buildGetStartedButton(),
    );
  }

  Widget _buildBody() {
    return Center(
      child: SvgPicture.asset(
        getAssetsSVGImg('splash_logo'),
        width: getSize(150),
        height: getSize(150),
      ),
    );

    // return GetBuilder<SplashController>(
    //   init: SplashController(),
    //   builder: (controller) {
    //     return Center(
    //       child: SvgPicture.asset(
    //         getAssetsSVGImg('splash_logo'),
    //         width: controller.animation.value * getSize(150),
    //         height: controller.animation.value * getSize(150),
    //       ),
    //     );
    //   },
    // );
  }

  Widget _buildGetStartedButton() {
    return GetBuilder<SplashController>(builder: (controller) {
      return controller.animationController.isAnimating
          ? Container(
              color: Colors.white,
              height: getSize(200),
              child: Center(
                child: SpinKitCircle(color: ColorConstants.primary),
              ),
            )
          : Container(
              color: Colors.white,
              child: Padding(
                padding: EdgeInsets.only(
                  left: getSize(24),
                  right: getSize(24),
                  bottom: getSize(42),
                ),
                child: CommonButton(
                  onPressed: () {
                    Get.toNamed(Routes.login);
                  },
                  buttonText: 'Get Started',
                ),
              ),
            );
    });
  }
}
