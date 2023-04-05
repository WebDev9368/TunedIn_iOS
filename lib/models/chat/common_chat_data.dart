import 'package:get/state_manager.dart';

class CommonChatData {
  CommonChatDataUser? user;
  String? message;
  RxInt? unseenMessage = 0.obs;
  int? isOnline;
  int? isSeen;
  int? lastSeen;
  int? time;
  int? type;
  int? senderId;
  int? receiverId;
  RxInt? requestStatus = 0.obs;
  //int? userStatus;`
  bool? deletedUser;
  bool fromSearchScreen = false;
  CommonChatData({
    this.user,
    this.message,
    this.unseenMessage,
    this.isOnline,
    this.isSeen,
    this.lastSeen,
    this.time,
    this.type,
    this.senderId,
    this.receiverId,
    this.requestStatus,
    this.deletedUser,
    this.fromSearchScreen = false,
  });

  CommonChatData.fromJson(Map<String, dynamic> json) {
    user =
        json['user'] != null ? CommonChatDataUser.fromJson(json['user']) : null;
    message = json['message'];
    unseenMessage?.value = json['unseen_message'];
    isOnline = json['is_online'];
    isSeen = json['is_seen'];
    lastSeen = json['last_seen'];
    time = json['time'];
    type = json['type'];
    senderId = json['sender_id'];
    receiverId = json['receiver_id'];
    requestStatus?.value = json['user_status'];
    deletedUser = json['deleted_user'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (user != null) {
      data['user'] = user!.toJson();
    }
    data['message'] = message;
    data['unseen_message'] = unseenMessage?.value;
    data['is_online'] = isOnline;
    data['is_seen'] = isSeen;
    data['last_seen'] = lastSeen;
    data['time'] = time;
    data['type'] = type;
    data['sender_id'] = senderId;
    data['receiver_id'] = receiverId;
    data['user_status'] = requestStatus?.value;
    data['deleted_user'] = deletedUser;
    return data;
  }
}

class CommonChatDataUser {
  int? userId;
  String? name;
  String? email;
  int? profileType;
  String? profile;

  CommonChatDataUser(
      {this.userId, this.name, this.email, this.profileType, this.profile});

  CommonChatDataUser.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    name = json['name'];
    email = json['email'];
    profileType = json['profile_type'];
    profile = json['profile'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['user_id'] = userId;
    data['name'] = name;
    data['email'] = email;
    data['profile_type'] = profileType;
    data['profile'] = profile;
    return data;
  }
}
