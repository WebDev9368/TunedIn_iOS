import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../models/chat/common_chat_data.dart';
import '../../../../../routes/app_pages.dart';
import '../../../../../shared/constants/color_constants.dart';
import '../../../../../shared/utils/date_time_utils.dart';
import '../../../../../shared/utils/focus.dart';
import '../../../../../shared/utils/image_utils.dart';
import '../../../../../shared/utils/math_utils.dart';
import '../../../../../shared/widgets/base_text.dart';

class CommonUserTile extends StatelessWidget {
  const CommonUserTile({
    Key? key,
    required this.commonChatData,
    required this.index,
    required this.deleteCallback,
    required this.blockCallback,
    required this.fromWhichScreen,
  }) : super(key: key);

  final CommonChatData commonChatData;
  final int index;
  final String fromWhichScreen;
  final VoidCallback deleteCallback;
  final VoidCallback blockCallback;

  @override
  Widget build(BuildContext context) {
    int userId = commonChatData.user!.userId!;

    return ListTile(
      leading: _buildLeadingView(commonChatData),
      title: _buildTitleView(commonChatData),
      subtitle: _buildSubtitleView(commonChatData),
      contentPadding: EdgeInsets.zero,
      onTap: () async {
        AppFocus.unFocus();
        var result = await Get.toNamed(
          Routes.chatConversation,
          arguments: [commonChatData],
        );
        printInfo(info: "result   : $result");
        //commonChatData.unseenMessage?.value = 0;
      },
    );
  }

  Widget _buildLeadingView(CommonChatData commonChatData) {
    String? userProfile = commonChatData.user?.profile;
    int? isOnline = commonChatData.isOnline;

    return Stack(
      children: [
        Container(
          width: getSize(50),
          height: getSize(50),
          decoration: BoxDecoration(
            color: ColorConstants.grey1,
            shape: BoxShape.circle,
            image: userProfile != null
                ? DecorationImage(
                    fit: BoxFit.cover,
                    image: CachedNetworkImageProvider(userProfile),
                  )
                : DecorationImage(
                    image: AssetImage(
                      getAssetsPNGImg(
                        'profile_placeholder',
                      ),
                    ),
                    fit: BoxFit.cover,
                  ),
          ),
        ),
        Obx(() => Visibility(
          visible: commonChatData.unseenMessage?.value != null &&
              commonChatData.unseenMessage!.value > 0,
          child: Positioned(
            top: getSize(4),
            right: 0,
            child: CircleAvatar(
              radius: getSize(8),
              backgroundColor: const Color(0xFFE7166B),
              child: BaseText(
                text: commonChatData.unseenMessage!.value.toString(),
                textColor: ColorConstants.white,
                fontSize: 10,
              ),
            ),
          ),
        )),
      ],
    );
  }

  Widget _buildTitleView(CommonChatData commonChatData) {
    String? userName = commonChatData.user?.name;
    int? lastMessageTime = commonChatData.time;

    return Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: Row(
        children: [
          Flexible(
            child: Container(
              width: Get.width,
              padding: const EdgeInsets.only(right: 13.0),
              child: BaseText(
                text: userName ?? '',
                fontWeight: FontWeight.w700,
                fontSize: 15,
                maxLines: 1,
              ),
            ),
          ),
          BaseText(
            text: lastMessageTime != null
                ? DateTimeUtils.getMessageDateTime(lastMessageTime)
                : '',
            maxLines: 1,
            fontSize: 12,
            textColor: ColorConstants.textColorSecondary,
            //textColor: ColorConstants.grey,
          ),
        ],
      ),
    );
  }

  Widget _buildSubtitleView(CommonChatData commonChatData) {
    String? lastMessage = commonChatData.message;
    // int? unseenMessage = commonChatData.unseenMessage?.value;

    return Row(
      children: [
        Expanded(
          child: BaseText(
            text: lastMessage ?? '',
            maxLines: 1,
            fontSize: 12,
            textColor: ColorConstants.textColorSecondary,
          ),
        ),
      ],
    );
  }
}
