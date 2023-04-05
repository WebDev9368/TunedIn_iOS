import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../../../models/chat/common_chat_data.dart';

class ChatTabController extends GetxController{
  int currentPage = 1;
  int lastPage = 1;
  int perPage = 30;

  final RefreshController refreshController = RefreshController();

  var chatList = <CommonChatData>[].obs;

  @override
  void onInit() {
    callChatListApi();
    super.onInit();
  }

  final String testUrl1 = 'https://images.unsplash.com/photo-1554151228-14d9def656e4?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=633&q=80';
  final String testUrl2 = 'https://images.unsplash.com/photo-1494790108377-be9c29b29330?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=634&q=80';
  final String testUrl3 = 'https://images.unsplash.com/photo-1616766098956-c81f12114571?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=634&q=80';

  Future<void> callChatListApi() async {
    chatList.add(
      CommonChatData(
        user: CommonChatDataUser(
          userId: 1,
          name: 'Padraigin',
          profile: testUrl1,
        ),
        message: 'It\'s been a long time since I heard you...',
        isOnline: 1,
        time: 1669738348,
        unseenMessage: 2.obs,
      ),
    );

    chatList.add(
      CommonChatData(
        user: CommonChatDataUser(
          userId: 2,
          name: 'Quaneisha',
          profile: testUrl2,
        ),
        message: 'I sang a few Taylor\'s',
        isOnline: 0,
        time: 1669738348,
        unseenMessage: 0.obs,
      ),
    );

    chatList.add(
      CommonChatData(
        user: CommonChatDataUser(
          userId: 3,
          name: 'Tabath',
          profile: testUrl3,
        ),
        message: 'It\'s been a long time since I heard you...',
        isOnline: 0,
        time: 1669738348,
        unseenMessage: 1.obs,
      ),
    );

    chatList.add(
      CommonChatData(
        user: CommonChatDataUser(
          userId: 4,
          name: 'Obadiah',
          profile: testUrl1,
        ),
        message: 'There is nothing to do at night',
        isOnline: 1,
        time: 1669738348,
        unseenMessage: 5.obs,
      ),
    );

    chatList.add(
      CommonChatData(
        user: CommonChatDataUser(
          userId: 5,
          name: 'Waggoner',
          profile: testUrl2,
        ),
        message: 'I am learning',
        isOnline: 1,
        time: 1669738348,
        unseenMessage: 12.obs,
      ),
    );

    chatList.add(
      CommonChatData(
        user: CommonChatDataUser(
          userId: 6,
          name: 'Yasima',
          profile: testUrl3,
        ),
        message: 'Are you coming for party?',
        isOnline: 0,
        time: 1669722320,
        unseenMessage: 2.obs,
      ),
    );

  }
}