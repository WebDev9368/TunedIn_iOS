import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:tunedln/modules/main/tabs/post_song/post_song_controller.dart';
import '../../../../../shared/constants/color_constants.dart';
import '../../../../../shared/utils/image_utils.dart';
import '../../../../../shared/utils/math_utils.dart';
import '../../../../../shared/widgets/base_text.dart';

class SongAlbumWidget extends GetView<PostSongController> {
  const SongAlbumWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Row(
      children: [
        _buildSongView(),
        SizedBox(width: getSize(20)),
        _buildAlbumView(),
      ],
    );
  }

  Widget _buildSongView() {
    return Expanded(
      child: Obx(() {
        return ClipRRect(
          borderRadius: BorderRadius.circular(getSize(10)),
          child: Material(
            color: controller.currentView.value == 0
                ? const Color(0xFFFBFDFD)
                : ColorConstants.grey2,
            child: InkWell(
              borderRadius: BorderRadius.circular(getSize(10)),
              onTap: () {
                if (controller.currentView.value == 1) {
                  controller.currentView.value = 0;
                }
              },
              child: Container(
                height: getSize(116),
                //width: getSize(140),
                padding: EdgeInsets.symmetric(
                  horizontal: getSize(12),
                  vertical: getSize(15),
                ),
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(getSize(10)),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      getAssetsSVGImg('ic_music'),
                      height: getSize(50),
                      width: getSize(50),
                      color: controller.currentView.value == 0
                          ? ColorConstants.primary
                          : null,
                    ),
                    SizedBox(height: getSize(14)),
                    BaseText(
                      text: 'Song',
                      fontSize: controller.currentView.value == 0 ? 16 : 14,
                      textColor: controller.currentView.value == 0
                          ? ColorConstants.primary
                          : ColorConstants.textColorSecondary,
                      fontWeight: controller.currentView.value == 0
                          ? FontWeight.w800
                          : FontWeight.w400,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      }),
    );
  }

  Widget _buildAlbumView() {
    return Expanded(
      child: Obx(() {
        return ClipRRect(
          borderRadius: BorderRadius.circular(getSize(10)),
          child: Material(
            color: controller.currentView.value == 1
                ? const Color(0xFFFBFDFD)
                : ColorConstants.grey2,
            child: InkWell(
              borderRadius: BorderRadius.circular(getSize(10)),
              onTap: () {
                if (controller.currentView.value == 0) {
                  controller.currentView.value = 1;
                }
              },
              child: Container(
                height: getSize(116),
                //width: getSize(140),
                padding: EdgeInsets.symmetric(
                  horizontal: getSize(12),
                  vertical: getSize(15),
                ),
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: BorderRadius.circular(getSize(10)),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      getAssetsSVGImg('ic_album'),
                      height: getSize(50),
                      width: getSize(50),
                      color: controller.currentView.value == 1
                          ? ColorConstants.primary
                          : null,
                    ),
                    SizedBox(height: getSize(14)),
                    BaseText(
                      text: 'Album',
                      fontSize: controller.currentView.value == 1 ? 16 : 14,
                      textColor: controller.currentView.value == 1
                          ? ColorConstants.primary
                          : ColorConstants.textColorSecondary,
                      fontWeight: controller.currentView.value == 1
                          ? FontWeight.w800
                          : FontWeight.w400,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      }),
    );
  }

}
