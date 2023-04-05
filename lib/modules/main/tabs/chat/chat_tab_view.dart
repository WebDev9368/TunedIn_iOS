import 'package:figma_squircle/figma_squircle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:tunedln/modules/main/tabs/chat/widget/chat_userlist_widget.dart';
import 'package:tunedln/modules/main/tabs/chat/widget/groups_chats_widget.dart';
import 'package:tunedln/shared/utils/image_utils.dart';
import 'package:tunedln/shared/utils/math_utils.dart';
import 'package:tunedln/shared/widgets/common_appbar.dart';
import '../../../../shared/constants/color_constants.dart';
import '../../../../shared/widgets/base_text.dart';

class ChatTabView extends StatelessWidget {
  const ChatTabView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(
        title: 'Chats',
        showAppBarShadow: false,
        leading: Container(),
        actions: [
          _buildAddButton(),
          IconButton(
            iconSize: getSize(18),
            onPressed: () {
              EasyLoading.showToast('Search');
            },
            icon: SvgPicture.asset(
              getAssetsSVGImg('ic_search'),
              //width: getSize(24),
              //height: getSize(24),
            ),
          ),
          SizedBox(width: getSize(10)),
        ],
      ),
      body: _buildBody(),
    );
  }

  Widget _buildAddButton() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: getSize(16)),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(getSize(14)),
        child: Material(
          color: ColorConstants.primary,
          child: InkWell(
            borderRadius: BorderRadius.circular(getSize(14)),
            onTap: () {
              EasyLoading.showToast('Add');
            },
            child: Container(
              width: getSize(36),
              //padding: EdgeInsets.symmetric(horizontal: getSize(12)),
              decoration: ShapeDecoration(
                color: Colors.transparent,
                shape: SmoothRectangleBorder(
                  borderRadius: SmoothBorderRadius.all(
                    SmoothRadius(
                      cornerRadius: getSize(14),
                      cornerSmoothing: 1,
                    ),
                  ),
                ),
              ),
              child: Icon(
                Icons.add,
                size: getSize(18),
              ),
            ),
          ),
        ),
      ),
      // child: Container(
      //   width: getSize(36),
      //   decoration: BoxDecoration(
      //     color: ColorConstants.primary,
      //     borderRadius: BorderRadius.circular(getSize(14)),
      //   ),
      //   child: const Icon(Icons.add),
      // ),
    );
  }

  Widget _buildBody() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: getSize(24)),
      child: Column(
        children: [
          const GroupsChatsWidget(),
          SizedBox(height: getSize(12)),
          _buildFindFriendView(),
          _buildSystemNoticeView(),
          const ChatUserListWidget(),
        ],
      ),
    );
  }

  Widget _buildFindFriendView() {
    return ListTile(
      leading: _buildLeadingView('ic_find_friend'),
      title: _buildTitleView('Find friends'),
      subtitle: _buildSubtitleView('Friends You may know'),
      trailing: _buildMoreView(),
      contentPadding: EdgeInsets.zero,
      onTap: () async {},
    );
  }

  Widget _buildSystemNoticeView() {
    return ListTile(
      leading: _buildLeadingView('ic_official_news'),
      title: _buildTitleView('System Notice',showTime: true),
      subtitle: _buildSubtitleView('Welcome to the singing app...'),
      contentPadding: EdgeInsets.zero,
      onTap: () async {},
    );
  }

  Widget _buildLeadingView(String icon) {
    return Container(
      width: getSize(50),
      height: getSize(50),
      padding: EdgeInsets.all(getSize(10)),
      decoration: const BoxDecoration(
        color: Color(0xFFFAFAFA),
        shape: BoxShape.circle,
      ),
      child: SvgPicture.asset(
        getAssetsSVGImg(icon),
      ),
    );
  }

  Widget _buildMoreView() {
    const double borderSize = 1;

    return ClipOval(
      child: Container(
        height: getSize(30),
        width: getSize(30),
        padding: const EdgeInsets.all(borderSize),
        color: const Color(0xFFFAFAFA),
        child: ClipOval(
          child: Image.asset(getAssetsPNGImg('ic_more1')),
        ),
      ),
    );
  }

  Widget _buildTitleView(String title, {bool showTime = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: Row(
        children: [
          Flexible(
            child: Container(
              width: Get.width,
              padding: const EdgeInsets.only(right: 13.0),
              child: BaseText(
                text: title,
                fontWeight: FontWeight.w700,
                fontSize: 15,
                maxLines: 1,
              ),
            ),
          ),
          showTime
              ? BaseText(
                  text: '10:55',
                  maxLines: 1,
                  fontSize: 12,
                  textColor: ColorConstants.textColorSecondary,
                )
              : Container(),
        ],
      ),
    );
  }

  Widget _buildSubtitleView(String subTitle) {
    return Row(
      children: [
        Expanded(
          child: BaseText(
            text: subTitle,
            maxLines: 1,
            fontSize: 12,
            textColor: ColorConstants.textColorSecondary,
          ),
        ),
      ],
    );
  }
}
