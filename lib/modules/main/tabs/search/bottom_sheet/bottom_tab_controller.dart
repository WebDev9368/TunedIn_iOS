import 'package:flutter/cupertino.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../api/dio_client.dart';
import '../model/song_model.dart';

class BottomTabController extends GetxController {
  int currentPage = 1;
  int lastPage = 1;
  int perPage = 30;

  String? selectedValue;
  String? appleToken;
  String? spotifyToken;
  late Map<String,dynamic> dataMaps;
  String? spotifyRefreshToken ;
  final DioClient _client = DioClient();

  final TextEditingController textController = TextEditingController();
  final RefreshController songRefreshController = RefreshController();
  final RefreshController friendRefreshController = RefreshController();

  var songList = <SongModel>[].obs;

  final List<String> items = [
    'Item1',
    'Item2',
    'Item3',
    'Item4',
    'Item5',
    'Item6',
    'Item7',
    'Item8',
  ];
  @override
  Future<void> onInit() async {
    SharedPreferences.getInstance().then(
            (prefs) {
          appleToken = prefs.getString("appleToken").toString();
          spotifyToken = prefs.getString("spotifyToken").toString();
          spotifyRefreshToken = prefs.getString("spotifyRefreshToken").toString();
          callPlayListApi();
        });
    super.onInit();
  }

  final String testUrl1 =
      'https://images.unsplash.com/photo-1554151228-14d9def656e4?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=633&q=80';
  final String testUrl2 =
      'https://images.unsplash.com/photo-1494790108377-be9c29b29330?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=634&q=80';
  final String testUrl3 =
      'https://images.unsplash.com/photo-1616766098956-c81f12114571?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=634&q=80';


  Future<void> callPlayListApi() async {

    Map<String,dynamic> dataMap;
    if(appleToken != "null") {
      dataMap = {
        "action": "get_playlists",
        "source":"apple",
        "token": appleToken
      };
    } else {
      dataMap = { "action": "get_playlists",
        "source": "spotify",
        "token": spotifyToken,
        "refresh_token": spotifyRefreshToken?.replaceAll('"','')
      };
    }
    _client.getPlaylists(
        body: dataMap,
        onSuccess: (dynamic list) {
          print(list);
          songList.clear();
          songList.addAll(list);
        },
        onError: (dynamic errorCode) {
        });
  }
  Future<void> callChatListApi() async {
   if(appleToken!= 'null' && spotifyToken!= 'null'){

    // EasyLoading.show(status: 'loading...');

     print(spotifyRefreshToken);
     dataMaps = {
       "action": "search_tracks_multi_api",
       "search_text": textController.text,
       "spotify_refresh_token": spotifyRefreshToken?.replaceAll('"',''),
       "spotify_token": spotifyToken,
       "apple_token": appleToken
     };
     print(dataMaps);
     _client.searchAllText(
         body: dataMaps,
         onSuccess: (dynamic list, dynamic lists) {
           print(list);

           //EasyLoading.dismiss();
           songRefreshController.loadComplete();
           songList.clear();
           songList.addAll(list);
           songList.addAll(lists);
         },
         onError: (dynamic errorCode) {
           //EasyLoading.dismiss();
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
     print(dataMaps);
     _client.searchText(
         body: dataMaps,
         onSuccess: (dynamic list) {
           print(list);

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
       "refresh_token": spotifyRefreshToken?.replaceAll('"','')
     };
     print(dataMaps);
     _client.searchText(
         body: dataMaps,
         onSuccess: (dynamic list) {

           EasyLoading.dismiss();
           print(list);

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
}
