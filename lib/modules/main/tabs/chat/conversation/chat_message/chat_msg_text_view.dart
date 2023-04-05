import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../../models/chat/chat_message.dart';
import '../../../../../../shared/constants/color_constants.dart';
import '../../../../../../shared/utils/chat_utils.dart';
import '../../../../../../shared/utils/image_utils.dart';
import '../../../../../../shared/utils/math_utils.dart';
import '../../../../../../shared/widgets/base_text.dart';

class ChatMessageTextView extends StatelessWidget {
  final ChatMessage chatMessage;
  final int index;

  final String? senderProfile;
  final String? receiverProfile;
  final String receiverName;

  final double borderRadius = 16;

  const ChatMessageTextView({
    Key? key,
    required this.chatMessage,
    required this.index,
    required this.senderProfile,
    required this.receiverProfile,
    required this.receiverName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        left: getSize(30),
        right: getSize(30),
        bottom: getSize(7),
        top: index == 0 ? getSize(15) : getSize(7),
      ),
      child: ChatUtils.isCurrentUser(chatMessage.senderId ?? 0)
          ? _buildRightMessageView()
          : _buildLeftMessageView(),
    );
  }

  Widget _buildLeftMessageView() {
    return Row(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        _buildProfileView(profileUrl: receiverProfile),
        SizedBox(width: getSize(10)),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: Get.width * 0.70,
                child: BaseText(
                  text: receiverName,
                  fontSize: 12,
                  textColor: ColorConstants.black,
                  maxLines: 1,
                ),
              ),
              SizedBox(height: getSize(10)),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: getSize(14),
                  vertical: getSize(13),
                ),
                constraints: BoxConstraints(maxWidth: Get.width * 0.70),
                decoration: BoxDecoration(
                  color: ColorConstants.lightGrey,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(getSize(borderRadius)),
                    bottomLeft: Radius.circular(getSize(borderRadius)),
                    bottomRight: Radius.circular(getSize(borderRadius)),
                  ),
                ),
                child: BaseText(
                  textAlign: TextAlign.left,
                  text: chatMessage.message ?? "",
                  fontSize: 12,
                ),
              ),
              SizedBox(height: getSize(3)),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildRightMessageView() {
    return Padding(
      padding: EdgeInsets.only(top: getSize(10)),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                // BaseText(
                //   text: 'You',
                //   fontSize: 12,
                //   textColor: ColorConstants.black,
                // ),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: getSize(14),
                    vertical: getSize(13),
                  ),
                  constraints: BoxConstraints(maxWidth: Get.width * 0.70),
                  decoration: BoxDecoration(
                    color: ColorConstants.primary,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(getSize(borderRadius)),
                      bottomRight: Radius.circular(getSize(borderRadius)),
                      bottomLeft: Radius.circular(getSize(borderRadius)),
                    ),
                  ),
                  child: BaseText(
                    textAlign: TextAlign.right,
                    text: chatMessage.message ?? "",
                    fontSize: 14,
                  ),
                ),
                SizedBox(height: getSize(3)),
              ],
            ),
          ),
          SizedBox(width: getSize(10)),
          _buildProfileView(profileUrl: senderProfile),
        ],
      ),
    );
  }

  Widget _buildProfileView({required String? profileUrl}) {
    return Container(
      width: getSize(50),
      height: getSize(50),
      //margin: EdgeInsets.only(top: getSize(14)),
      decoration: BoxDecoration(
        color: ColorConstants.grey1,
        shape: BoxShape.circle,
        image: profileUrl != null && profileUrl.isNotEmpty
            ? DecorationImage(
          fit: BoxFit.cover,
          image: CachedNetworkImageProvider(profileUrl),
        )
            : DecorationImage(
          image: AssetImage(getAssetsPNGImg('profile_placeholder')),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
