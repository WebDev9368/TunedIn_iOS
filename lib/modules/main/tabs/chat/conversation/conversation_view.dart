import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:tunedln/shared/widgets/base_text.dart';
import 'package:tunedln/shared/widgets/common_button.dart';
import '../../../../../models/chat/chat_message.dart';
import '../../../../../shared/constants/color_constants.dart';
import '../../../../../shared/constants/string_constant.dart';
import '../../../../../shared/utils/date_time_utils.dart';
import '../../../../../shared/utils/focus.dart';
import '../../../../../shared/utils/image_utils.dart';
import '../../../../../shared/utils/math_utils.dart';
import '../../../../../shared/widgets/common_appbar.dart';
import '../../../../../shared/widgets/input_field.dart';
import 'chat_message/chat_date_separator_view.dart';
import 'chat_message/chat_msg_attachment_view.dart';
import 'chat_message/chat_msg_text_view.dart';
import 'conversation_controller.dart';

class ConversationView extends GetView<ConversationController> {
  const ConversationView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() => WillPopScope(
          onWillPop: () {
            return controller.willPopCallback();
          },
          child: Scaffold(
            appBar: BaseAppBar(
              title: controller.appBarTitle,
              showAppBarShadow: false,
            ),
            body: _buildBody(),
            bottomSheet: messageTextFieldView(),
          ),
        ));
  }

  Widget _buildBody() {
    return Column(
      children: [
        _buildMessageLoader(),
        ListTile(
          title: const BaseText(
            text: 'Follow',
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
          subtitle: BaseText(
            text: 'Convenient to receive  information',
            textColor: ColorConstants.textColorSecondary,
            fontSize: 14,
          ),
          trailing: BaseButton(
            height: getSize(25),
            width: getSize(100),
            borderRadius: 12.5,
            onPressed: () {
            },
            childWidget: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.add),
                SizedBox(width: getSize(10)),
                const BaseText(
                  text: 'Follow',
                  textColor: Colors.white,
                  fontSize: 12,
                )
              ],
            ),
          ),
        ),
        _buildChatMessageListView(),
      ],
    );
  }

  Widget _buildChatMessageListView() {
    return Obx(() {
      return Expanded(
        child: ListView.builder(
          controller: controller.scrollController,
          padding: EdgeInsets.only(
            top: controller.currentPage > controller.lastPage
                ? getSize(20)
                : getSize(50),
            bottom: getSize(120),
          ),
          shrinkWrap: true,
          physics: const BouncingScrollPhysics(),
          itemCount: controller.messageList.length,
          itemBuilder: (BuildContext context, int index) {
            ChatMessage chatMessage = controller.messageList[index];

            //printInfo(info: 'message timestamp ==> ${chatMessage.createdAt}');
            //printInfo(info: 'message date ==> ${getHeaderDate(chatMessage.createdAt)}');

            return controller.isShowDate(chatMessage, index)
                ? Column(
                    children: [
                      ChatDateSeparatorView(
                        date: DateTimeUtils.getHeaderDate(
                            chatMessage.createdAt ?? DateTime.now()),
                      ),
                      showMessageView(chatMessage: chatMessage, index: index),
                    ],
                  )
                : showMessageView(chatMessage: chatMessage, index: index);
          },
          reverse: true,
        ),
      );
    });
  }

  //message view
  Widget showMessageView(
      {required ChatMessage chatMessage, required int index}) {
    if (chatMessage.type == 1) {
      return ChatMessageTextView(
        chatMessage: chatMessage,
        index: index,
        senderProfile:
            'https://i.pinimg.com/564x/22/af/cf/22afcf1ae76745de68d3ae7b09b2447a.jpg',
        receiverProfile: controller.commonChatDataUser.user?.profile,
        receiverName: controller.commonChatDataUser.user!.name!,
      );
    } else if (chatMessage.type == 2) {
      //printInfo(info: 'imageUrl ===> ${chatMessage.message}');

      return ChatMessageAttachmentView(
        chatMessage: chatMessage,
        index: index,
        senderProfile:
            'https://i.pinimg.com/564x/22/af/cf/22afcf1ae76745de68d3ae7b09b2447a.jpg',
        receiverProfile: controller.commonChatDataUser.user!.profile,
        receiverName: controller.commonChatDataUser.user!.name!,
      );
    } else if (chatMessage.type == 3) {
      return const ChatDateSeparatorView(date: 'Date Here');
    } else {
      return ChatMessageTextView(
        chatMessage: chatMessage,
        index: index,
        senderProfile:
            'https://i.pinimg.com/564x/22/af/cf/22afcf1ae76745de68d3ae7b09b2447a.jpg',
        receiverProfile: controller.commonChatDataUser.user!.profile,
        receiverName: controller.commonChatDataUser.user!.name!,
      );
    }
  }

  Container messageTextFieldView() {
    return Container(
      width: Get.width,
      height: getSize(100),
      padding: EdgeInsets.symmetric(horizontal: getSize(20)),
      margin: EdgeInsets.only(bottom: getSize(10)),
      alignment: Alignment.bottomCenter,
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
      child: Center(
        child: Row(
          children: [
            _buildVoiceButton(),
            SizedBox(width: getSize(8)),
            Expanded(
              child: InputTextField(
                hintText: StringConstant.saySomething,
                onChanged: (value) {
                  //controller.getTypingEvent();
                },
                maxLines: 5,
                controller: controller.chatMessageController,
                textInputType: TextInputType.multiline,
                suffixIconConstraints: BoxConstraints(
                  maxHeight: getSize(50),
                  minWidth: getSize(50),
                ),
                onFieldSubmitted: (value) {
                  if (value.trim().isNotEmpty) {
                    controller.chatMessageController.clear();
                    AppFocus.unFocus();
                    //controller.sendMessage(message: value, type: 1);
                  }
                },
                textInputAction: TextInputAction.newline,
                contentPadding: EdgeInsets.symmetric(
                  vertical: getSize(14),
                  horizontal: getSize(10),
                ),
              ),
            ),
            SizedBox(width: getSize(8)),
            _buildEmojiButton(),
            _buildSendButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildSendButton() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: getSize(0)),
      child: IconButton(
        onPressed: () {},
        icon: SvgPicture.asset(
          getAssetsSVGImg('ic_send'),
          width: getSize(30),
          height: getSize(30),
        ),
      ),
    );
  }

  Widget _buildEmojiButton() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: getSize(0)),
      child: IconButton(
        onPressed: () {},
        icon: SvgPicture.asset(
          getAssetsSVGImg('ic_emoji'),
          width: getSize(30),
          height: getSize(30),
        ),
      ),
    );
  }

  Widget _buildVoiceButton() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: getSize(0)),
      child: IconButton(
        onPressed: () {},
        icon: SvgPicture.asset(
          getAssetsSVGImg('ic_voice'),
          width: getSize(30),
          height: getSize(30),
        ),
      ),
    );
  }

  Widget _buildMessageLoader() {
    return Obx(() {
      return controller.showMessageLoader.value
          ? Platform.isIOS
              ? const CupertinoActivityIndicator(animating: true)
              : CircularProgressIndicator(color: ColorConstants.primary)
          : Container();
    });
  }
}
