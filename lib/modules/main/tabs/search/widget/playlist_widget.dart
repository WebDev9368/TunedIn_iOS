import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tunedln/shared/constants/color_constants.dart';
import 'package:tunedln/shared/utils/math_utils.dart';
import 'package:tunedln/shared/widgets/base_text.dart';
import '../../../../../routes/app_pages.dart';
import '../../../../../shared/utils/image_utils.dart';

class PLayListWidget extends StatelessWidget {
  const PLayListWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: getSize(16)),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: getSize(24)),
          child: const BaseText(
            text: 'Popular Playlist',
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(height: getSize(16)),
        SizedBox(
          height: getSize(193),
          child: ListView.builder(
            itemCount: 4,
            scrollDirection: Axis.horizontal,
            itemBuilder: (BuildContext context, int index) {
              return _buildListItem(index);
            },
          ),
        ),
        SizedBox(height: getSize(16)),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: getSize(24)),
          child: const BaseText(
            text: 'Recently played',
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(height: getSize(16)),
        SizedBox(
          height: getSize(193),
          child: ListView.builder(
            itemCount: 4,
            scrollDirection: Axis.horizontal,
            itemBuilder: (BuildContext context, int index) {
              return _buildRecentPlayListItem(index);
            },
          ),
        ),
      ],
    ));
  }

  Widget _buildListItem(int index) {
    return Container(
      width: getSize(140),
      color: ColorConstants.lightGrey,
      margin: EdgeInsets.only(
        left: index == 0 ? getSize(24) : 0,
        right: getSize(24),
      ),
      padding: EdgeInsets.only(left: getSize(16)),
      child: GestureDetector(
        onTap: (){
           Get.toNamed(Routes.playlist);
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: Image.asset(
                getAssetsPNGImg(
                  index % 2 == 0 ? 'playlists_cover1' : 'playlists_cover2',
                ),
                height: getSize(124),
                width: getSize(124),
              ),
            ),
            SizedBox(height: getSize(10)),
            BaseText(text: index % 2 == 0 ? 'Shades of love' : 'The Excape'),
            SizedBox(height: getSize(10)),
            BaseText(
              text: index % 2 == 0 ? 'Ania Szarmach' : 'Bundii Staxx ',
              textColor: ColorConstants.textColorSecondary,
              fontSize: 14,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRecentPlayListItem(int index) {
    return Container(
      margin: EdgeInsets.only(
        left: index == 0 ? getSize(24) : 0,
        right: getSize(24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(
            getAssetsPNGImg(
              index % 2 == 0 ? 'recent_play_image1' : 'recent_play_image1',
            ),
            height: getSize(86),
            width: getSize(86),
          ),
          SizedBox(height: getSize(10)),
          BaseText(text: index % 2 == 0 ? 'Ballroom Blitz' : 'Dreamer'),
          SizedBox(height: getSize(10)),
          BaseText(
            text: index % 2 == 0 ? 'Nicky Jam' : 'Billie Eilish',
            textColor: ColorConstants.textColorSecondary,
            fontSize: 14,
          ),
        ],
      ),
    );
  }
}
