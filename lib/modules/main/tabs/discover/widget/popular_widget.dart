import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tunedln/modules/main/tabs/discover/widget/popular_event_slider.dart';
import 'package:tunedln/modules/main/tabs/discover/widget/trending_post_widget.dart';
import 'package:tunedln/shared/utils/image_utils.dart';
import 'package:tunedln/shared/utils/math_utils.dart';
import 'package:tunedln/shared/widgets/base_text.dart';
import 'featured_list_widget.dart';

class PopularWidget extends StatelessWidget {
  const PopularWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        SizedBox(height: getSize(18)),
        const PopularEventCarouselSlider(),
        SizedBox(height: getSize(24)),
        _buildFeaturedForYouView(),
        SizedBox(height: getSize(16)),
        const FeaturedListWidget(),
        const TrendingPostWidget(),
        SizedBox(height: getSize(30)),
      ],
    );
  }

  Widget _buildFeaturedForYouView() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: getSize(20)),
      child: Row(
        children: [
          SvgPicture.asset(
            getAssetsSVGImg('ic_star'),
            width: getSize(14),
            height: getSize(14),
          ),
          SizedBox(width: getSize(10)),
          const BaseText(
            text: 'Featured for you',
            fontSize: 15,
            fontWeight: FontWeight.w700,
          ),
        ],
      ),
    );
  }
}

