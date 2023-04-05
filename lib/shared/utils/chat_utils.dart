import 'package:get/get.dart';

import '../../di.dart';

class ChatUtils {
  // static void performSendMessage(
  //   int type,
  //   int receiverId,
  //   Function(ChatMessage) successCompletion, {
  //   String dateActionMsg = '',
  //   String message = '',
  //   String imageUrl = '',
  // }) {
  //   SocketChatMessage messageData = SocketChatMessage();
  //   messageData.senderId = DependencyInjection.userResponse.value.userId?.value;
  //   messageData.receiverId = receiverId;
  //   messageData.type = type;
  //
  //   if (type == 1) {
  //     messageData.message = message;
  //   } else if (type == SocketConstants.msgTypeAttachment) {
  //     messageData.message = imageUrl;
  //   }
  //   // else if (type == SocketConstants.msgTypeDate) {
  //   //   messageData.dateUserId = rq.dateId.toString();
  //   //   messageData.message = jsonEncode(rq.toJson());
  //   // } else if (type == Const.msgTypeDateAction) {
  //   //   messageData.message = dateActionMsg;
  //   // }
  //
  //   if (!DependencyInjection.socket.connected) {
  //     DependencyInjection.connectSocket();
  //     Future.delayed(Duration(seconds: 2)).then(
  //       (value) {
  //         print("=====>${messageData.toJson()}");
  //
  //         if (!DependencyInjection.socket.connected) {
  //           // Utils.showInfoToast("socket not connected");
  //           return;
  //         }
  //
  //         DependencyInjection.socket.emitWithAck(
  //             SocketConstants.sendMessage, messageData.toJson(), ack: (data) {
  //           print('ackSemd Message $data');
  //           if (data != null) {
  //             ChatMessage chatMessage = ChatMessage();
  //             chatMessage.messageId = data['messageId'];
  //             chatMessage.message = messageData.message?.obs;
  //             chatMessage.senderId = messageData.senderId;
  //             chatMessage.receiverId = messageData.receiverId;
  //             chatMessage.type = messageData.type;
  //             chatMessage.createdAt = DateTime.now();
  //             print(chatMessage.toJson());
  //             //chatBloc.insertLocalMessage(chatMessage);
  //             successCompletion(chatMessage);
  //           } else {
  //             print("Null");
  //           }
  //         });
  //       },
  //     );
  //   } else {
  //     print("=====>${messageData.toJson()}");
  //     DependencyInjection.socket.emitWithAck(
  //         SocketConstants.sendMessage, messageData.toJson(), ack: (data) {
  //       print('ack $data');
  //       if (data != null) {
  //         ChatMessage chatMessage = ChatMessage();
  //         chatMessage.messageId = data['messageId'];
  //         chatMessage.message = messageData.message?.obs;
  //         chatMessage.senderId = messageData.senderId;
  //         chatMessage.receiverId = messageData.receiverId;
  //         chatMessage.type = messageData.type;
  //         chatMessage.createdAt = DateTime.now();
  //         print(chatMessage.toJson());
  //         //   chatBloc.insertLocalMessage(chatMessage);
  //         successCompletion(chatMessage);
  //       } else {
  //         print("Null");
  //       }
  //     });
  //   }
  // }

  static isCurrentUser(int userId) {
    //return userId == DependencyInjection.userResponse.value.userId!.value;
    return userId == 0;
  }
}
