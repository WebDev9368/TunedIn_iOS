import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import '../../../../../models/chat/chat_message.dart';
import '../../../../../models/chat/common_chat_data.dart';

class ConversationController extends GetxController {
  final TextEditingController chatMessageController = TextEditingController();

  String appBarTitle = '';

  var messageList = <ChatMessage>[].obs;
  var isUserOnline = 0.obs;

  //var userLastSeen = 0.obs;
  int currentPage = 1;
  int lastPage = 1;
  int perPage = 50;

  late int receiverId;
  late CommonChatData commonChatDataUser;
  late int senderId;

  //late Socket socket;
  String? roomId;

  final ScrollController scrollController = ScrollController();
  var showMessageLoader = false.obs;

  @override
  void onInit() {
    messageList.add(
      ChatMessage(
        messageId: 101,
        senderId: 1,
        receiverId: 0,
        message: 'Hello, How are you?',
        type: 1,
        createdAt: DateTime.now().toLocal(),
      ),
    );

    messageList.add(
      ChatMessage(
        messageId: 102,
        senderId: 0,
        receiverId: 1,
        message: 'I am fine. How are you?',
        type: 1,
        createdAt: DateTime.now().toLocal(),
      ),
    );

    var arguments = Get.arguments;
    //printInfo(info: 'arguments ===> $arguments');

    if (arguments != null) {
       commonChatDataUser = Get.arguments[0];
      // printInfo(info: 'commonChatDataUser ===> ${commonChatDataUser.toJson()}');
       appBarTitle = commonChatDataUser.user!.name!;
      //
      // receiverId = commonChatDataUser.user!.userId!;
      // //senderId = DependencyInjection.userResponse.value.userId!.value;
      // senderId = 1;
      //
      // //printInfo(info: 'senderId = $senderId , receiverId = $receiverId');
      //
      // printInfo(info: 'fromWhichScreen ===> ${Get.arguments[1]}');

    }

    //scrollController.addListener(listenScrolling);

    //callGetMessageApi();
    //initSocket();
    super.onInit();
  }


  Future<bool> willPopCallback() async {
    Get.back(result: Get.arguments[1]);
    // await showDialog or Show add banners or whatever
    // then
    return true; // return true if the route to be popped
  }

  bool isShowDate(ChatMessage chatMessage, int index) {

    ChatMessage lastMessage = messageList.last;

    if (chatMessage.messageId == lastMessage.messageId) {
      return true;
    }

    ChatMessage nextMessage = messageList[index + 1];

    DateTime currentMessageDate = chatMessage.createdAt ?? DateTime.now();
    DateTime nextMessageDate = nextMessage.createdAt ?? DateTime.now();

    bool isSameDay = currentMessageDate.day == nextMessageDate.day;

    if (/*index > 0 && */ !isSameDay) {
      return true;
    }
    return false;
  }

  void scrollToBottom() {
    scrollController.animateTo(
      0,
      curve: Curves.easeOut,
      duration: const Duration(milliseconds: 500),
    );
  }

}
