import 'dart:async';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:tunedln/modules/main/tabs/discover/discover_tab_controller.dart';
import 'package:tunedln/shared/widgets/base_text.dart';
import '../../../../../shared/constants/color_constants.dart';
import '../../../../../shared/constants/string_constant.dart';
import '../../../../../shared/utils/image_utils.dart';
import '../../../../../shared/utils/math_utils.dart';
import '../../../../../shared/widgets/common_button.dart';
import '../../search/model/friend_model.dart';

class SimilarProfileWidget extends GetView<DiscoverTabController> {
  const SimilarProfileWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SmartRefresher(
        enablePullUp: true,
        controller: controller.similarProfileRefreshController,
        onRefresh: () async {
          Timer(
              const Duration(seconds: 3),
              () => controller.similarProfileRefreshController
                  .refreshCompleted());
        },
        onLoading: () async {
          Timer(const Duration(seconds: 3),
              () => controller.similarProfileRefreshController.loadComplete());
        },
        child: Column(
          children: [
            Obx(
              () => controller.friendList.isEmpty
                  ? _buildNoData()
                  : _buildListView(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNoData() {
    return const Center(
      child: BaseText(
        text: StringConstant.noResult,
      ),
    );
  }

  Widget _buildListView() {
    return Expanded(
      child: ListView.builder(
        physics: const BouncingScrollPhysics(),
        shrinkWrap: true,
        padding: EdgeInsets.symmetric(horizontal: getSize(20)),
        itemCount: controller.friendList.length,
        itemBuilder: (BuildContext context, int index) {
          return _buildListItem(index);
        },
      ),
    );
  }

  Widget _buildListItem(int index) {
    FriendModel friendModel = controller.friendList[index];
    return Padding(
      padding: EdgeInsets.only(
        top: getSize(10),
        bottom: index == controller.friendList.length - 1 ? getSize(50) : 0,
      ),
      child: ListTile(
        leading: _buildLeadingView(friendModel.profileImage),
        title: _buildTitleView(friendModel.name),
        subtitle: _buildSubtitleView(
            friendModel.totalFollower, friendModel.totalSing),
        contentPadding: EdgeInsets.zero,
        trailing: _buildPlayButton(),
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
        maxLines: 1,
      ),
    );
  }

  Widget _buildSubtitleView(String totalFollower, int totalSing) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BaseText(
          text: '$totalFollower followers',
          maxLines: 1,
          fontSize: 12,
          textColor: ColorConstants.textColorSecondary,
        ),
        SizedBox(width: getSize(10)),
        SvgPicture.asset(
          getAssetsSVGImg('ic_sing'),
          height: getSize(10),
          width: getSize(10),
        ),
        SizedBox(width: getSize(5)),
        BaseText(
          text: '$totalSing',
          maxLines: 1,
          fontSize: 12,
          textColor: ColorConstants.textColorSecondary,
        ),
      ],
    );
  }

  Widget _buildPlayButton() {
    return BaseButton(
      width: getSize(60),
      height: getSize(34),
      borderRadius: 17,
      onPressed: () {
        //EasyLoading.showToast('Add Song');
      },
      childWidget: const Icon(Icons.add),
    );
  }
}
