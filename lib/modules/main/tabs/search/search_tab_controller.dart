import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../api/dio_client.dart';
import 'model/friend_model.dart';
import 'model/playlist_model.dart';
import 'model/song_model.dart';

class SearchTabController extends GetxController {
  int currentPage = 1;
  int lastPage = 1;
  int perPage = 30;

  String? appleToken;
  String? spotifyToken;
  late Map<String,dynamic> dataMaps;
  String? spotifyRefreshToken ;
  final DioClient _client = DioClient();

  late SongModel track;
  String? selectedValue;

  Rx<bool> isSpotify = false.obs;
  Rx<bool> isApple = false.obs;

  final TextEditingController textControllers = TextEditingController();
  final TextEditingController textController = TextEditingController();
  final TextEditingController textControllerAll = TextEditingController();
  final TextEditingController textControllerSpotify = TextEditingController();
  final RefreshController songRefreshController = RefreshController();
  final RefreshController friendRefreshController = RefreshController();

  var songListSpotify = <SongModel>[].obs;
  var songList = <SongModel>[].obs;
  var friendList = <FriendModel>[].obs;
  var playlist = <Playlists>[].obs;
  var playlistSpotify = <Playlists>[].obs;

  @override
  Future<void> onInit() async {
    SharedPreferences.getInstance().then(
            (prefs) {
          appleToken = prefs.getString("appleToken").toString();
          spotifyToken = prefs.getString("spotifyToken").toString();
          spotifyRefreshToken = prefs.getString("spotifyRefreshToken").toString();
          callFriendsApi();

        });
    super.onInit();
  }

  final String testUrl1 =
      'https://images.unsplash.com/photo-1554151228-14d9def656e4?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=633&q=80';
  final String testUrl2 =
      'https://images.unsplash.com/photo-1494790108377-be9c29b29330?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=634&q=80';
  final String testUrl3 =
      'https://images.unsplash.com/photo-1616766098956-c81f12114571?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=634&q=80';

  Future<void> addToPlayListAppleApi(String text, SongModel id) async {
    Map<String, dynamic> dataMap = {
      "action": "add_track",
      'playlist_id': text,
      'track_id': id.id,
      "source": "apple",
      "token": appleToken
    };

    if(id.from == "S") {
      EasyLoading.showToast('Sorry, this song was found in Spotify only and cannot be added to Apple Music playlist');
    }else {
    _client.addToPlaylists(
        body: dataMap,
        onSuccess: (dynamic list) {
          EasyLoading.showToast('Song added to Apple Music.');
        },
        onError: (dynamic errorCode) {
          EasyLoading.showToast('Something goes wrong.');
        });
  }
  }
  Future<void> addToPlayListSpotifyApi(String text, SongModel id) async {

    Map<String,dynamic> dataMap = {
      "action": "add_track",
      'playlist_id': text,
      'track_id': id.id,
      "source": "spotify",
      "token": spotifyToken,
      "refresh_token": spotifyRefreshToken
    };

    print(dataMap);
    if(id.from == "AM") {
      EasyLoading.showToast('Sorry, this song was found in Apple Music only and cannot be added to Spotify playlist');
    }else {
      _client.addToPlaylists(
          body: dataMap,
          onSuccess: (dynamic list) {
            print(list);
            EasyLoading.showToast('Song added to Spotify.');
          },
          onError: (dynamic errorCode) {
            EasyLoading.showToast('Something goes wrong.');
          });
    }
  }
  Future<void> createPlayListAppleApi(String text) async {

    Map<String,dynamic> dataMap = {
        "action": "create_playlist",
        'name':text,
        "source":"apple",
        "token": appleToken
      };

    isApple.value = true;
    print(dataMap);
    _client.createPlaylists(
        body: dataMap,
        onSuccess: (dynamic list) {
          isApple.value = false;
          EasyLoading.showToast('Playlist created.');
          playlist.add(Playlists(id: list, name: text));
          playlist.refresh();
        },
        onError: (dynamic errorCode) {

          isApple.value = false;
          EasyLoading.showToast('Something goes wrong.');
        });
  }

  Future<void> createPlayListSpotifyApi(String text) async {

    Map<String,dynamic> dataMap = {

        "action": "create_playlist",
        'name': text,
        "source": "spotify",
        "token": spotifyToken,
        "refresh_token": spotifyRefreshToken
      };
    isSpotify.value == true;
    _client.createPlaylists(
        body: dataMap,
        onSuccess: (dynamic list) {
          EasyLoading.showToast('Playlist created.');
          callPlayListSpotifyApi();
        },
        onError: (dynamic errorCode) {
          isSpotify.value = false;
          EasyLoading.showToast('Something goes wrong.');
        });
  }
  Future<void> callPlayListApi() async {

    Map<String,dynamic> dataMap= {
        "action": "get_playlists",
        "source":"apple",
        "token": appleToken
      };

    _client.getPlaylists(
        body: dataMap,
        onSuccess: (dynamic list) {
          isApple.value = false;
          playlist.clear();
          playlist.addAll(list);
          playlist.refresh();
        },
        onError: (dynamic errorCode) {

          isApple.value = false;
        });
  }

  Future<void> callPlayListSpotifyApi() async {

    Map<String,dynamic> dataMap = {
        "action": "get_playlists",
        "source": "spotify",
        "token": spotifyToken?.replaceAll('"',''),
        "refresh_token": spotifyRefreshToken?.replaceAll('"','')
      };
    _client.getPlaylists(
        body: dataMap,
        onSuccess: (dynamic list) {
          playlistSpotify.clear();
          playlistSpotify.addAll(list);
          playlistSpotify.refresh();

          isSpotify.value = false;
        },
        onError: (dynamic errorCode) {
          isSpotify.value = false;
        });
  }

  Future<void> callChatListApi() async {
   if(appleToken!= 'null' && spotifyToken!= 'null'){
    dataMaps = {
       "action": "search_tracks_multi_api",
       "search_text": textController.text,
       "spotifyRefreshToken":  spotifyRefreshToken,
       "spotifyToken": spotifyToken,
       "appleToken": appleToken
     };
     _client.searchAllText(
         body: dataMaps,
         onSuccess: (dynamic list, dynamic lists) {
           for(SongModel i in list){
             i.from = "AM";
           }
           for(SongModel i in lists){
             i.from = "S";
           }
           songRefreshController.loadComplete();
           songList.clear();
           songList.addAll(list);
           songList.addAll(lists);
         },
         onError: (dynamic errorCode) {
           songRefreshController.loadComplete();
         });
   }else if(appleToken!= 'null'){
     EasyLoading.show(status: 'loading...');

     dataMaps = {
       "action": "search_tracks",
       "search_text": textController.text,
       "source":"apple",
       "token": appleToken
     };
     _client.searchText(
         body: dataMaps,
         onSuccess: (dynamic list) {
           for(SongModel i in list){
             i.from = "AM";
           }
           EasyLoading.dismiss();
           songRefreshController.loadComplete();
           songList.clear();
           songList.addAll(list);
         },
         onError: (dynamic errorCode) {

           EasyLoading.dismiss();
           songRefreshController.loadComplete();
         });

   }else if(spotifyToken!= 'null'){
     EasyLoading.show(status: 'loading...');

     dataMaps = {
       "action": "search_tracks",
       "search_text": textController.text,
       "source":"spotify",
       "token": spotifyToken,
       "refresh_token": spotifyRefreshToken
     };
     _client.searchText(
         body: dataMaps,
         onSuccess: (dynamic list) {
           EasyLoading.dismiss();
           for(SongModel i in list){
             i.from = "S";
           }
           songRefreshController.loadComplete();
           songList.clear();
           songList.addAll(list);
         },
         onError: (dynamic errorCode) {
           EasyLoading.dismiss();
           songRefreshController.loadComplete();
         });
   }
  }

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

  }
}
