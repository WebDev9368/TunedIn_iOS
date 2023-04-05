import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:music_kit/music_kit.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tunedln/routes/app_pages.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../../../api/dio_client.dart';

class ConnectController extends GetxController{
  final basicDetailFormKey = GlobalKey<FormState>();
  final profileDetailFormKey = GlobalKey<FormState>();
  final DioClient _client = DioClient();
  late WebViewController controller;
  Rx<bool> isSpotify = false.obs;
  Rx<bool> isApple = true.obs;
  Rx<bool> isWebView= false.obs;

  String? spotifyToken;
  String? spotifyRefreshToken;
  String? appleToken;
  String? localId;
  RxInt currentView = 0.obs;

  final _musicKitPlugin = MusicKit();

  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController aboutYouController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  @override
  void onInit() {
    SharedPreferences.getInstance().then(
            (prefs) {
          appleToken = prefs.getString("appleToken").toString();
          spotifyToken = prefs.getString("spotifyToken").toString();
          spotifyRefreshToken = prefs.getString("spotifyRefreshToken").toString();
          localId = prefs.getString("localId");
          if(appleToken != 'null' && appleToken != ""){
            isApple.value = false;
          }
          else{
            isApple.value = true;
          }
          if(spotifyToken != 'null' && spotifyToken != ""){
            isSpotify.value = true;
          } else{
            isSpotify.value = false;
          }
          isSpotify.refresh();
          isApple.refresh();
        });
    super.onInit();
  }

  void goHome(){
    Get.offAllNamed(Routes.main);

  }


    Future<void> initPlatformState(String developerToken) async {
      EasyLoading.dismiss();
      await _musicKitPlugin.requestAuthorizationStatus();
      final String userToken;
      try {
        userToken =
        await _musicKitPlugin.requestUserToken(developerToken);
        SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
        sharedPreferences.setString("appleToken", userToken);
        Map<String,dynamic> dataMap = {
          "action":"set_api_token",
          "source": "apple",
          "localId": localId,
          "token": userToken
        };

        _client.setApiToken(body: dataMap,
            onSuccess: () {
              EasyLoading.dismiss();
              isApple.value = false;
            },
            onError: (dynamic errorCode) {
              EasyLoading.dismiss();
            }
        );
      }catch(error){
        EasyLoading.showToast('Please make sure you have subscribed to Apple Music.');
      }

  }

  Future<void> connectApple() async {
    EasyLoading.show(status: 'loading...');

    _client.getDeveloperToken(
        onSuccess: (dynamic list) async {
          initPlatformState(list);
        },
        onError: (dynamic errorCode) {
          EasyLoading.dismiss();
        });
  }

  Future<void> connectSpotify() async {

    EasyLoading.show(status: 'loading...');
    _client.connect(body: {'source':"spotify"},
        onSuccess: (dynamic url) {
          EasyLoading.dismiss();
          isWebView.value = true;
          Get.toNamed(
            Routes.webView,
            arguments: {'url': url, 'from':'spotify'},
          )?.then((value) => isSpotify.value = true);
        },
        onError: (dynamic errorCode) {
          EasyLoading.dismiss();
        });
  }
}