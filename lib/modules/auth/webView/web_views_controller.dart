import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_web_auth/flutter_web_auth.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tunedln/routes/app_pages.dart';
import 'package:tunedln/shared/dialog/error_toast.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../../../api/dio_client.dart';
import '../../../shared/utils/focus.dart';

class WebViewsController extends GetxController{
  final basicDetailFormKey = GlobalKey<FormState>();
  final profileDetailFormKey = GlobalKey<FormState>();
  final DioClient _client = DioClient();
  late WebViewController controller;
  String spotifyToken = 'null';
  String spotifyRefreshToken = 'null';
  String appleToken = "null";
  Rx<bool> isWebView= false.obs;
  late final WebViewCookieManager cookieManager = WebViewCookieManager();
  final String USER_AGENT = "Mozilla/5.0 (Linux; Android 4.1.1; Galaxy Nexus Build/JRO03C) AppleWebKit/535.19 (KHTML, like Gecko) Chrome/18.0.1025.166 Mobile Safari/535.19";

  
  var arg = Get.arguments;
  RxInt currentView = 0.obs;

  @override
  void onInit() {
    if(arg['url']!= null){
        print(arg['from']);
        connectUrl(arg['url']);
    }
    super.onInit();
  }

  Future<void> connectUrl(String url) async {
    isWebView.value = true;
          controller = WebViewController()
          ..clearLocalStorage()
            ..clearCache()
            ..setJavaScriptMode(JavaScriptMode.unrestricted)
            ..setBackgroundColor(const Color(0x00000000))
            ..setUserAgent("random")
            ..setNavigationDelegate(
              NavigationDelegate(
                onPageFinished: (String url) async {
                  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
                  final cookies = await controller.runJavaScriptReturningResult(
                    'document.cookie',
                  );

                  print(cookies);
                  var token = "spotifyToken=";
                  var refreshToken = "spotifyRefreshToken=";
                  var ca = cookies.toString().split(';');
                  for(var i=0;i < ca.length;i++) {
                    var c = ca[i];
                    while (c.contains(' ')) {
                      c = c.substring(1,c.length);
                    }
                    if (c.indexOf(token) == 0) {
                      spotifyToken = c.substring(token.length,c.length);
                      sharedPreferences.setString("spotifyToken", spotifyToken);
                    }else if(c.indexOf(refreshToken) == 0){
                      spotifyRefreshToken = c.substring(refreshToken.length,c.length);
                      sharedPreferences.setString("spotifyRefreshToken", spotifyRefreshToken.replaceAll('"', ''));
                    }
                  }
                  var localId = sharedPreferences.getString("localId");
                  var spotifyTokens = sharedPreferences.getString(
                      "spotifyToken").toString();
                  if (spotifyToken != 'null') {
                    Map<String, dynamic> dataMaps = {
                      "action": "set_api_token",
                      "source": "spotify",
                      "localId": localId,
                      "token": spotifyToken,
                      "refresh_token": spotifyRefreshToken
                    };
                    _client.setApiToken(body: dataMaps,
                        onSuccess: () async {
                          final bool hadCookies = await cookieManager.clearCookies();
                          print(hadCookies);
                          Get.offAllNamed(Routes.connect);
                        },
                        onError: (dynamic errorCode) {}
                    );
                    //return NavigationDecision.prevent;
                  }
                },
                onWebResourceError: (WebResourceError error) {},
                onNavigationRequest: (NavigationRequest request) async {
                  if (request.url.startsWith('https://wordcoach.app/')) {
                    SharedPreferences sharedPreferences = await SharedPreferences
                        .getInstance();
                    final cookies = await controller
                        .runJavaScriptReturningResult(
                      'document.cookie',
                    );

                    print(cookies);
                    var token = "spotifyToken=";
                    var refreshToken = "spotifyRefreshToken=";
                    var ca = cookies.toString().split(';');
                    for (var i = 0; i < ca.length; i++) {
                      var c = ca[i];
                      while (c.contains(' ')) {
                        c = c.substring(1, c.length);
                      }
                      if (c.indexOf(token) == 0) {
                        spotifyToken = c.substring(token.length, c.length);
                        sharedPreferences.setString(
                            "spotifyToken", spotifyToken);
                      } else if (c.indexOf(refreshToken) == 0) {
                        spotifyRefreshToken =
                            c.substring(refreshToken.length, c.length);
                        sharedPreferences.setString(
                            "spotifyRefreshToken", spotifyRefreshToken.replaceAll('"',''));
                      }
                    }
                    var localId = sharedPreferences.getString("localId");
                    var spotifyTokens = sharedPreferences.getString(
                        "spotifyToken").toString();
                    if (spotifyToken != 'null') {
                      Map<String, dynamic> dataMaps = {
                        "action": "set_api_token",
                        "source": "spotify",
                        "localId": localId,
                        "token": spotifyToken,
                        "refresh_token": spotifyRefreshToken.replaceAll('"','')
                      };
                      _client.setApiToken(body: dataMaps,
                          onSuccess: () async {
                            final bool hadCookies = await cookieManager.clearCookies();
                            print(hadCookies);
                            Get.offAllNamed(Routes.connect);
                          },
                          onError: (dynamic errorCode) {}
                      );
                      //return NavigationDecision.prevent;
                    }
                  }
                  return NavigationDecision.navigate;
                },
              ),
            )..loadRequest(Uri.parse(url));


  }
}