import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:tunedln/shared/constants/constants.dart';
import 'package:tunedln/shared/utils/math_utils.dart';
import 'package:tunedln/shared/widgets/base_text.dart';
import '../../../../../shared/utils/image_utils.dart';
import '../discover_tab_controller.dart';

class TrendingPostWidget extends GetView<DiscoverTabController> {
  const TrendingPostWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        padding: EdgeInsets.symmetric(horizontal: getSize(20)),
        itemCount: 3,
        itemBuilder: (BuildContext context, int index) {
          return _buildListItem(index);
        },

    );
  }


  Widget _buildListItem(int index) {
    return Padding(
      padding: EdgeInsets.only(
        top: getSize(10),
        bottom: index == controller.friendList.length - 1 ? getSize(50) : 0,
      ),
      child: Column(
        children: [
          ListTile(
            leading: _buildLeadingView('https://images.unsplash.com/photo-1554151228-14d9def656e4?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=633&q=80'),
            title: _buildTitleView('Quaneisha'),
            subtitle: _buildSubtitleView('23:18 13-12-20'),
            contentPadding: EdgeInsets.zero,
          ),
          const BaseText(
            text:
                'This is my first time singing in this app, I hope you like it',
            fontSize: 15,
          ),
          SizedBox(height: getSize(18)),
          _buildFeedView(),
          SizedBox(height: getSize(18)),
          _buildLikeCommentShareView(),
        ],
      ),
    );
  }

  Widget _buildLeadingView(String userProfile) {
    return Container(
      width: getSize(52),
      height: getSize(52),
      decoration: BoxDecoration(
        color: ColorConstants.grey1,
        shape: BoxShape.circle,
        image: userProfile != null
            ? DecorationImage(
                fit: BoxFit.cover,
                image: CachedNetworkImageProvider(userProfile),
              )
            : DecorationImage(
                image: AssetImage(getAssetsPNGImg('profile_placeholder')),
                fit: BoxFit.cover,
              ),
      ),
    );
  }

  Widget _buildTitleView(String name) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: BaseText(
        text: name,
        fontSize: 15,
        fontWeight: FontWeight.w700,
        maxLines: 1,
      ),
    );
  }

  Widget _buildSubtitleView(String dateTime) {
    return BaseText(
      text: dateTime,
      maxLines: 1,
      fontSize: 12,
      textColor: ColorConstants.textColorSecondary,
    );
  }

  Widget _buildFeedView() {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            color: ColorConstants.lightGrey,
            borderRadius: BorderRadius.circular(getSize(16)),
          ),
          width: Get.width,
          height: getSize(192),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(getSize(16)),
            child: Image.asset(
              getAssetsPNGImg('trending_post'),
              fit: BoxFit.cover,
              width: Get.width,
            ),
          ),
        ),
        ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(getSize(16)),
            topRight: Radius.circular(getSize(16)),
          ),
          child: Container(
            color: Colors.black.withOpacity(0.35),
            height: getSize(40),
            child: Row(
              children: [
                SizedBox(width: getSize(18)),
                SvgPicture.asset(getAssetsSVGImg('ic_song')),
                SizedBox(width: getSize(10)),
                const BaseText(
                  text: 'Yesterday Once More',
                  textColor: Colors.white,
                ),
                const Spacer(),
                SvgPicture.asset(getAssetsSVGImg('ic_arrow_forward')),
                SizedBox(width: getSize(24)),
              ],
            ),
          ),
        ),
        Positioned.fill(
          bottom: -140,
          child: Row(
            children: [
              SizedBox(width: getSize(18)),
              SvgPicture.asset(getAssetsSVGImg('ic_listen')),
              SizedBox(width: getSize(10)),
              const BaseText(
                text: '68.6k',
                textColor: Colors.white,
                fontSize: 12,
              ),
              const Spacer(),
              const BaseText(
                text: '10 : 00',
                textColor: Colors.white,
                fontSize: 12,
              ),
              SizedBox(width: getSize(10)),
              SvgPicture.asset(
                getAssetsSVGImg('ic_play_fill'),
                height: getSize(24),
                width: getSize(24),
              ),
              SizedBox(width: getSize(24)),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildLikeCommentShareView() {
    return Row(
      children: [
        _buildCommonView('ic_like', '2.6K'),
        SizedBox(width: getSize(20)),
        _buildCommonView('ic_comment', '256'),
        SizedBox(width: getSize(20)),
        _buildCommonView('ic_share_feed', '12'),
      ],
    );
  }

  Widget _buildCommonView(String icon, String title) {
    return Row(
      children: [
        Image.asset(
          getAssetsPNGImg(icon),
          width: getSize(18),
          height: getSize(18),
        ),
        SizedBox(width: getSize(10)),
        BaseText(text: title),
      ],
    );
  }
}
