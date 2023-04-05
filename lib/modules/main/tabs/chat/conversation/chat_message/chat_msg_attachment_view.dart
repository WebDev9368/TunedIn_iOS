import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import '../../../../../../models/chat/chat_message.dart';
import '../../../../../../shared/constants/color_constants.dart';
import '../../../../../../shared/utils/chat_utils.dart';
import '../../../../../../shared/utils/image_utils.dart';
import '../../../../../../shared/utils/math_utils.dart';
import '../../../../../../shared/widgets/base_text.dart';

class ChatMessageAttachmentView extends StatelessWidget {
  final ChatMessage chatMessage;
  final int index;

  final String? senderProfile;
  final String? receiverProfile;
  final String receiverName;

  final double borderRadius = 16;

  int deleteTimer = 0;

  ChatMessageAttachmentView({
    Key? key,
    required this.chatMessage,
    required this.index,
    required this.senderProfile,
    required this.receiverProfile,
    required this.receiverName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    printInfo(info: 'chatMessage ==> ${chatMessage.toJson()}');

    return Container(
      margin: EdgeInsets.only(
        left: getSize(30),
        right: getSize(30),
        bottom: getSize(7),
        top: index == 0 ? getSize(15) : getSize(7),
      ),
      child: ChatUtils.isCurrentUser(chatMessage.senderId!)
          ? _buildRightMessageView()
          : _buildLeftMessageView(),
    );
  }

  Widget _buildProfileView({required String? profileUrl}) {
    return Container(
      width: getSize(50),
      height: getSize(50),
      margin: EdgeInsets.only(
        top: getSize(14),
      ),
      decoration: BoxDecoration(
        color: ColorConstants.grey1,
        shape: BoxShape.circle,
        image: profileUrl != null && profileUrl.isNotEmpty
            ? DecorationImage(
                fit: BoxFit.cover,
                image: CachedNetworkImageProvider(profileUrl),
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
    );
  }

  Widget _buildLeftMessageView() {
    return Row(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        _buildProfileView(profileUrl: receiverProfile),
        SizedBox(
          width: getSize(10),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: Get.width * 0.70,
                child: BaseText(
                  text: receiverName,
                  fontSize: 12,
                  maxLines: 1,
                  textColor: ColorConstants.black,
                ),
              ),
              Obx(() => InkWell(
                    onTap: chatMessage.message!.isEmpty
                        ? null
                        : () async {


                          },
                    child: Opacity(
                      opacity: chatMessage.message!.isEmpty ? 0.5 : 1,
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: getSize(14), vertical: getSize(13)),
                        constraints: BoxConstraints(
                          maxWidth: Get.width * 0.70,
                        ),
                        decoration: BoxDecoration(
                          color: ColorConstants.white,
                          borderRadius: getBorderRadiusLeft(),
                        ),
                        child: chatMessage.message!.isEmpty
                            ? Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const BaseText(
                                    textAlign: TextAlign.right,
                                    text: 'Attachment',
                                    fontSize: 14,
                                  ),
                                  SizedBox(
                                    width: getSize(10),
                                  ),
                                  SvgPicture.asset(
                                    getAssetsSVGImg('timer_bomb'),
                                    height: getSize(20),
                                    width: getSize(20),
                                  ),
                                ],
                              )
                            : const BaseText(
                                textAlign: TextAlign.left,
                                text: 'Attachment',
                                fontSize: 12,
                              ),
                      ),
                    ),
                  )),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildRightMessageView() {

    // int autoDelete = chatMessage.timer ?? 0;
    // if (autoDelete > 0) {
    //   deleteLocally(autoDelete);
    // }

    return Row(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            BaseText(
              text: 'You',
              fontSize: 12,
              textColor: ColorConstants.black,
            ),
            Obx(() {
              return InkWell(
                borderRadius: getBorderRadiusRight(),
                onTap: chatMessage.message!.isEmpty
                    ? null
                    : () {

                      },
                child: Opacity(
                  opacity: chatMessage.message == null ? 0.5 : 1,
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: getSize(14),
                      vertical: getSize(13),
                    ),
                    constraints: BoxConstraints(
                      maxWidth: Get.width * 0.70,
                    ),
                    decoration: BoxDecoration(
                      color: ColorConstants.primary,
                      borderRadius: getBorderRadiusRight(),
                    ),
                    child: chatMessage.message!.isEmpty
                        ? Opacity(
                            opacity: 0.2,
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const BaseText(
                                  textAlign: TextAlign.right,
                                  text: 'You sent a photo',
                                  fontSize: 14,
                                ),
                                SizedBox(
                                  width: getSize(10),
                                ),
                                SvgPicture.asset(
                                  getAssetsSVGImg('timer_bomb'),
                                  height: getSize(20),
                                  width: getSize(20),
                                ),
                              ],
                            ),
                          )
                        : Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SvgPicture.asset(
                                getAssetsSVGImg('triangle_sent_photo'),
                              ),
                              SizedBox(
                                width: getSize(10),
                              ),
                             const BaseText(
                                textAlign: TextAlign.right,
                                text: 'You sent a photo',
                                fontSize: 14,
                              ),
                            ],
                          ),
                  ),
                ),
              );
            }),
          ],
        ),
        SizedBox(
          width: getSize(10),
        ),
        _buildProfileView(profileUrl: senderProfile),
      ],
    );
  }

  bool isTimeFinished() {
    DateTime? messageDateTime = chatMessage.createdAt;
    int timer =  0;

    if (timer > 0 && messageDateTime != null) {
      DateTime now = DateTime.now();
      messageDateTime.add(Duration(seconds: timer));
      bool isTimeFinish = now.isAfter(messageDateTime);

      printInfo(info: 'now ==> $now');
      printInfo(info: 'messageDateTime ==> $messageDateTime');
      printInfo(info: 'isTimeFinish ==> $isTimeFinish');

      return isTimeFinish;
    }

    return false;
  }

  void deleteLocally(int autoDeleteSecond) {
    printInfo(info: 'autoDeleteSecond ==> $autoDeleteSecond');

    //Timer? timer;
    const oneSec = Duration(seconds: 1);
    Timer timer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (autoDeleteSecond == 0) {
          timer.cancel();
          printInfo(info: 'Delete photo');
          chatMessage.message = '';
        } else {
          autoDeleteSecond--;
        }
      },
    );
  }

  BorderRadius getBorderRadiusLeft() {
    return BorderRadius.only(
      topRight: Radius.circular(
        getSize(borderRadius),
      ),
      bottomLeft: Radius.circular(
        getSize(borderRadius),
      ),
      bottomRight: Radius.circular(
        getSize(borderRadius),
      ),
    );
  }

  BorderRadius getBorderRadiusRight() {
    return BorderRadius.only(
      topLeft: Radius.circular(
        getSize(borderRadius),
      ),
      bottomRight: Radius.circular(
        getSize(borderRadius),
      ),
      bottomLeft: Radius.circular(
        getSize(borderRadius),
      ),
    );
  }
}
