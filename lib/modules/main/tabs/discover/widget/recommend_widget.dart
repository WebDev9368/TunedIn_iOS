import 'package:flutter/material.dart';
import 'package:tunedln/modules/main/tabs/discover/widget/event_slider.dart';
import 'package:tunedln/modules/main/tabs/discover/widget/trending_post_widget.dart';
import 'package:tunedln/shared/constants/color_constants.dart';
import 'package:tunedln/shared/utils/image_utils.dart';
import 'package:tunedln/shared/utils/math_utils.dart';
import 'package:tunedln/shared/widgets/base_text.dart';
import 'albums_list_widget.dart';

class RecommendWidget extends StatelessWidget {
  const RecommendWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        SizedBox(height: getSize(10)),
        _buildTopTitleView(),
        SizedBox(height: getSize(18)),
        const EventCarouselSlider(),
        SizedBox(height: getSize(18)),
        _buildTrendingPostTitleView(),
        const TrendingPostWidget(),
        SizedBox(height: getSize(24)),
        _buildAlbumsTitleView(),
        SizedBox(height: getSize(16)),
        const AlbumsListWidget(),
        SizedBox(height: getSize(30)),
      ],
    );
  }

  Widget _buildTopTitleView() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: getSize(20)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const BaseText(
                text: 'Hai, John',
                fontSize: 24,
                fontWeight: FontWeight.w700,
              ),
              SizedBox(height: getSize(4)),
              BaseText(
                text: 'Find your favorite song here',
                fontSize: 14,
                textColor: ColorConstants.textColorPrimary.withOpacity(0.8),
              ),
            ],
          ),
          Container(
            height: getSize(40),
            width: getSize(40),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: ColorConstants.grey1,
            ),
            child: Padding(
              padding: EdgeInsets.all(getSize(10)),
              child: Image.asset(
                getAssetsPNGImg('ic_calender'),
                height: getSize(24),
                width: getSize(24),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildTrendingPostTitleView() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: getSize(20)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const BaseText(
            text: 'Trending Posts',
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
          SizedBox(height: getSize(4)),
          BaseText(
            text: 'View all',
            fontSize: 14,
            textColor: ColorConstants.primary,
          ),
        ],
      ),
    );
  }

  Widget _buildAlbumsTitleView() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: getSize(20)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const BaseText(
            text: 'Albums',
            fontSize: 18,
            fontWeight: FontWeight.w700,
          ),
          SizedBox(height: getSize(4)),
          BaseText(
            text: 'View all',
            fontSize: 14,
            textColor: ColorConstants.primary,
          ),
        ],
      ),
    );
  }
}
