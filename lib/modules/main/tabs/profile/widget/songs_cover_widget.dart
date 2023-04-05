import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:tunedln/modules/main/tabs/profile/profile_tab_controller.dart';
import 'package:tunedln/shared/constants/color_constants.dart';
import '../../../../../shared/utils/image_utils.dart';
import '../../../../../shared/utils/math_utils.dart';
import '../../../../../shared/widgets/base_text.dart';
import '../model/songs_cover_model.dart';

class SongsCoverWidget extends GetView<ProfileTabController> {
  const SongsCoverWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      itemCount: controller.songsCoverList.length,
      itemBuilder: (BuildContext context, int index) {
        return _buildGridItem(index);
      },
      padding: EdgeInsets.symmetric(vertical: getSize(24)),
      //scrollDirection: Axis.horizontal,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisSpacing: getSize(16),
        mainAxisSpacing: getSize(16),
        crossAxisCount: 3,
        mainAxisExtent: getSize(100),
      ),
      physics: const BouncingScrollPhysics(),
      shrinkWrap: true,
    );
  }

  Widget _buildGridItem(int index) {
    SongsCoverModel songsCoverModel = controller.songsCoverList[index];

    return Stack(
      children: [
        _buildImageView(songsCoverModel.image),
        Positioned(
          right: getSize(20),
          top: getSize(6),
          child: Container(
            height: getSize(16),
            width: getSize(42),
            decoration: BoxDecoration(
              color: const Color(0xFF101010).withOpacity(0.5),
              borderRadius: BorderRadius.circular(getSize(21)),
            ),
            alignment: Alignment.center,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SvgPicture.asset(
                  getAssetsSVGImg('ic_listen'),
                  width: getSize(10),
                  height: getSize(10),
                ),
                BaseText(
                  text: songsCoverModel.totalListen,
                  fontSize: 12,
                  textColor: Colors.white,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildImageView(String imageAsset) {
    return Container(
      decoration: BoxDecoration(
        color: ColorConstants.lightGrey,
        borderRadius: BorderRadius.circular(getSize(16)),
      ),
      width: getSize(100),
      height: getSize(100),
      child: Image.asset(getAssetsPNGImg(imageAsset)),
    );
  }
}
