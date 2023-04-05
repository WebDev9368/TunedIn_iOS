import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:tunedln/modules/main/tabs/profile/profile_tab_controller.dart';
import 'package:tunedln/modules/main/tabs/profile/widget/tab_bar_widget.dart';
import '../../../../shared/constants/color_constants.dart';
import '../../../../shared/utils/image_utils.dart';
import '../../../../shared/utils/math_utils.dart';
import '../../../../shared/widgets/base_text.dart';
import '../../../../shared/widgets/common_button.dart';
import '../../../auth/connect/connect_controller.dart';

class ProfileTabView extends GetView<ProfileTabController>{
  const ProfileTabView({Key? key}) : super(key: key);
   @override
   Widget build(BuildContext context) {
   return SafeArea(
      child: Scaffold(
        body: _buildBody(),
      ),
    );
  }

  Widget _buildBody() {
    return SizedBox(
      height: Get.height,
      child: Stack(
        children: [
          _buildTopView(),
          Positioned.fill(
            top: getSize(100),
            child: Container(
              width: Get.width,
              decoration: ShapeDecoration(
                shape: SmoothRectangleBorder(
                  borderRadius: SmoothBorderRadius.only(
                    topLeft: SmoothRadius(
                      cornerRadius: getSize(24),
                      cornerSmoothing: 1,
                    ),
                    topRight: SmoothRadius(
                      cornerRadius: getSize(24),
                      cornerSmoothing: 1,
                    ),
                  ),
                ),
                color: Colors.white,
              ),
              padding: EdgeInsets.all(getSize(22)),
              child: Column(
                children: [
                  _buildProfileView(),
                  SizedBox(height: getSize(17)),
                  _buildFansFollowingView(),
                  SizedBox(height: getSize(17)),
                  const StandardTabBarPage(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTopView() {
    return Container(
      height: getSize(200),
      color: ColorConstants.primary,
      child: ListTile(
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Container(
            height: getSize(45),
            width: getSize(45),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(getSize(12)),
            ),
            // child: SvgPicture.asset(
            //   getAssetsSVGImg('ic_arrow_back'),
            //   color: Colors.white,
            // ),
          ),
        ),
        title: const BaseText(
            text: 'Profile',
            fontWeight: FontWeight.w700,
            textColor: Colors.white,
            fontSize: 20,
            textAlign: TextAlign.center,
          ),
        trailing: IconButton(
          onPressed: () {
            controller.exitAction();
            EasyLoading.showToast('Edit Profile');
          },
          icon: Container(
            height: getSize(45),
            width: getSize(45),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.transparent,
              borderRadius: BorderRadius.circular(getSize(12)),
            ),
            child: SvgPicture.asset(getAssetsSVGImg('ic_edit_profile')),
          ),
        ),
      ),
    );
  }

  Widget _buildProfileView() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: getSize(76),
          height: getSize(76),
          decoration: BoxDecoration(
            color: ColorConstants.lightGrey,
            shape: BoxShape.circle,
            image: DecorationImage(
              image: AssetImage(getAssetsPNGImg('profile')),
              fit: BoxFit.cover,
            ),
            // image: profileUrl != null && profileUrl.isNotEmpty
            //     ? DecorationImage(
            //         fit: BoxFit.cover,
            //         image: CachedNetworkImageProvider(profileUrl),
            //       )
            //     : DecorationImage(
            //         image: AssetImage(getAssetsPNGImg('profile_placeholder')),
            //         fit: BoxFit.cover,
            //       ),
          ),
        ),
        SizedBox(width: getSize(15)),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const BaseText(
                text: 'Amy John',
                fontSize: 20,
                fontWeight: FontWeight.w700,
              ),
              SizedBox(height: getSize(7)),
              BaseText(
                text: 'Username : Amy233@',
                fontSize: 12,
                fontWeight: FontWeight.w400,
                textColor: ColorConstants.textColorSecondary,
              ),
              SizedBox(height: getSize(7)),
              BaseText(
                text:
                    'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown ...........',
                fontSize: 12,
                fontWeight: FontWeight.w200,
                textColor: ColorConstants.textColorSecondary,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildFansFollowingView() {
    return Row(
      children: [
        _commonView('Following', '43'),
        SizedBox(width: getSize(60)),
        _commonView('Fans', '7.5K'),
        SizedBox(width: getSize(60)),
        _commonView('Friends', '36'),
      ],
    );
  }

  Widget _commonView(String title, String total) {
    return Column(
      children: [
        BaseText(
          text: total,
          fontWeight: FontWeight.w700,
          fontSize: 20,
        ),
        BaseText(
          text: title,
          fontSize: 14,
          textColor: ColorConstants.textColorSecondary,
        ),
      ],
    );
  }
}


