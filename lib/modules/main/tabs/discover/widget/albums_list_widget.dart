import 'package:flutter/material.dart';
import 'package:tunedln/shared/constants/color_constants.dart';
import 'package:tunedln/shared/utils/math_utils.dart';
import 'package:tunedln/shared/widgets/base_text.dart';
import '../../../../../shared/utils/image_utils.dart';

class AlbumsListWidget extends StatelessWidget {
  const AlbumsListWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: getSize(230),
      child: ListView.builder(
        itemCount: 4,
        scrollDirection: Axis.horizontal,
        itemBuilder: (BuildContext context, int index) {
          return _buildListItem(index);
        },
      ),
    );
  }

  Widget _buildListItem(int index) {
    return Container(
      width: getSize(140),
      margin: EdgeInsets.only(
        left: index == 0 ? getSize(24) : 0,
        right: getSize(24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(getSize(16)),
            child: Image.asset(
              getAssetsPNGImg('album_image1'),
              height: getSize(140),
              width: getSize(140),
            ),
          ),
          SizedBox(height: getSize(10)),
          const BaseText(text: 'All To Well (10 Minute Version)'),
          SizedBox(height: getSize(10)),
          BaseText(
            text: 'Taylor Swift',
            textColor: ColorConstants.textColorSecondary,
            fontSize: 14,
          ),
        ],
      ),
    );
  }
}
