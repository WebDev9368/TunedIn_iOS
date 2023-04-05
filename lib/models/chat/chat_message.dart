class ChatMessage {
  int? messageId;
  int? senderId;
  int? receiverId;
  String? message = '';
  int? type;
  int? seen;
  DateTime? createdAt;

  ChatMessage(
      {this.messageId,
      this.senderId,
      this.receiverId,
      this.message,
      this.type,
      this.seen,
      this.createdAt});

  ChatMessage.fromJson(Map<String, dynamic> json) {
    messageId = json['message_id'];
    senderId = json['sender_id'];
    receiverId = json['receiver_id'];
    message = json['message'] ?? '';
    type = json['type'];
    seen = json['seen'];
    createdAt = (json['created_at'] != null &&
            json['created_at'].toString().length <= 10)
        ? DateTime.fromMillisecondsSinceEpoch(json['created_at'] * 1000)
            .toLocal()
        : DateTime.now().toLocal();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message_id'] = messageId;
    data['sender_id'] = senderId;
    data['receiver_id'] = receiverId;
    data['message'] = message;
    data['type'] = type;
    data['seen'] = seen;
    data['created_at'] = createdAt;
    return data;
  }
}

// class SocketChatMessage {
//   int? receiverId;
//   int? senderId;
//   String? message;
//   int? type;
//
//   SocketChatMessage({this.receiverId, this.senderId, this.message, this.type});
//
//   SocketChatMessage.fromJson(Map<String, dynamic> json) {
//     receiverId = json['receiver_id'];
//     senderId = json['sender_id'];
//     message = json['message'];
//     type = json['type'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = <String, dynamic>{};
//     data['receiver_id'] = receiverId;
//     data['sender_id'] = senderId;
//     data['message'] = message;
//     data['type'] = type;
//     return data;
//   }
// }
