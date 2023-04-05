import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../search/model/friend_model.dart';

class DiscoverTabController extends GetxController{
  int currentPage = 1;
  int lastPage = 1;
  int perPage = 30;

  final RefreshController similarProfileRefreshController = RefreshController();
  var friendList = <FriendModel>[].obs;

  RxInt sliderCurrent = 0.obs;

  final List<String> eventSliderImageList = [
    'https://',
    'https://',
    'https://',
    'https://',
    'https://',
    'https://',
  ];

  @override
  void onInit() {
    callFriendsApi();
    super.onInit();
  }

  final String testUrl1 =
      'https://images.unsplash.com/photo-1554151228-14d9def656e4?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=633&q=80';
  final String testUrl2 =
      'https://images.unsplash.com/photo-1494790108377-be9c29b29330?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=634&q=80';
  final String testUrl3 =
      'https://images.unsplash.com/photo-1616766098956-c81f12114571?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=634&q=80';

  Future<void> callFriendsApi() async {
    friendList.add(
      FriendModel(testUrl1, 'Anjela', '1.3K', 100),
    );
    friendList.add(
      FriendModel(testUrl1, 'John Granit', '1.1K', 93),
    );
    friendList.add(
      FriendModel(testUrl1, 'David', '2.3K', 12),
    );
    friendList.add(
      FriendModel(testUrl1, 'Sabrina Le Beauf', '8.4K', 75),
    );
    friendList.add(
      FriendModel(testUrl1, 'Keith Douglas', '3.6K', 23),
    );
    friendList.add(
      FriendModel(testUrl1, 'Anjela', '1.3K', 100),
    );
    friendList.add(
      FriendModel(testUrl1, 'John Granit', '1.1K', 93),
    );
    friendList.add(
      FriendModel(testUrl1, 'David', '2.3K', 12),
    );
    friendList.add(
      FriendModel(testUrl1, 'Sabrina Le Beauf', '8.4K', 75),
    );
    friendList.add(
      FriendModel(testUrl1, 'Keith Douglas', '3.6K', 23),
    );

  }

}