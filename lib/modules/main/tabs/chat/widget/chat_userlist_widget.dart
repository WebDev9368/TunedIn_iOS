import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../../../../models/chat/common_chat_data.dart';
import '../../../../../shared/constants/string_constant.dart';
import '../../../../../shared/utils/focus.dart';
import '../../../../../shared/widgets/base_text.dart';
import '../chat_tab_controller.dart';
import 'common_user_tile.dart';

class ChatUserListWidget extends GetView<ChatTabController> {
  const ChatUserListWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SmartRefresher(
        enablePullUp: true,
        controller: controller.refreshController,
        onRefresh: () async {
          Timer(const Duration(seconds: 3), () => controller.refreshController.refreshCompleted());
        },
        onLoading: () async {
          Timer(const Duration(seconds: 3), () => controller.refreshController.loadComplete());
        },
        child: Obx(
          () => controller.chatList.isEmpty ? _buildNoData() : _buildListView(),
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
    return ListView.builder(
        physics: const BouncingScrollPhysics(),
        shrinkWrap: true,
        padding: EdgeInsets.zero,
        //padding: EdgeInsets.symmetric(horizontal: getSize(20)),
        itemCount: controller.chatList.length,
        itemBuilder: (BuildContext context, int index) {
          CommonChatData commonChatData = controller.chatList[index];
          return CommonUserTile(
            commonChatData: commonChatData,
            index: index,
            deleteCallback: () {
              Get.back();
              AppFocus.unFocus();
              //controller.callDeleteChatApi(userId: commonChatData.user!.userId!);
            },
            blockCallback: () {
              Get.back();
              AppFocus.unFocus();
              //controller.callAcceptDenyChatRequestApi(commonChatData.user!.userId!, StringConstant.requestStatusBlock);
            },
            fromWhichScreen: 'message',
          );
        },
      );
  }
}
