import 'package:tunedln/modules/main/tabs/chat/chat_tab_binding.dart';
import 'package:tunedln/modules/main/tabs/chat/chat_tab_view.dart';
import 'package:tunedln/modules/main/tabs/discover/discover_tab_binding.dart';
import 'package:tunedln/modules/main/tabs/discover/discover_tab_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:tunedln/modules/main/tabs/profile/profile_tab_binding.dart';
import 'package:tunedln/modules/main/tabs/profile/profile_tab_view.dart';
import 'package:tunedln/modules/main/tabs/search/search_tab_binding.dart';
import 'package:tunedln/modules/main/tabs/search/search_tab_view.dart';
import '../../routes/app_pages.dart';
import '../../shared/dialog/alert_dialog.dart';
import '../../shared/utils/focus.dart';

class MainController extends FullLifeCycleController {
  var currentTabIndex = 0.obs;
  var pageIndex = 0.obs;
  var pageList = <String>[].obs;

  DateTime? currentBackPressTime;

  String? discoverPage;
  String? searchPage;
  String? chatPage;
  String? profilePage;

  void switchTab(int index) async {
    //int selectedIndex = currentTabIndex.value;
    currentTabIndex.value = index;
    switch (index) {
      case 0:
        if (!pageList.contains(discoverPage)) {
          pageList.add(discoverPage!);
        }
        pageIndex.value = pageList.indexOf(discoverPage);
        break;

      case 1:
        if (!pageList.contains(searchPage)) {
          pageList.add(searchPage!);
        }
        pageIndex.value = pageList.indexOf(searchPage);
        break;

      case 2:
        Get.toNamed(Routes.postSong);
        break;

      case 3:
        if (!pageList.contains(chatPage)) {
          pageList.add(chatPage!);
        }
        pageIndex.value = pageList.indexOf(chatPage);
        break;

      case 4:
        if (!pageList.contains(profilePage)) {
          pageList.add(profilePage!);
        }
        pageIndex.value = pageList.indexOf(profilePage);
        break;

      default:
    }
  }

  Route? onGenerateRoute(RouteSettings settings, String tabItem) {

    GetPageRoute? pageRoute;

    switch(tabItem){
      case Routes.tabDiscover:
        pageRoute =  getPageRoute(
          settings,
          const DiscoverTabView(),
          binding: DiscoverTabBinding(),
        );
        break;

      case Routes.tabSearch:
        pageRoute =  getPageRoute(
          settings,
          const SearchTabView(),
          binding: SearchTabBinding(),
        );
        break;

      case Routes.tabChat:
        pageRoute =  getPageRoute(
          settings,
          const ChatTabView(),
          binding: ChatTabBinding(),
        );
        break;

      case Routes.tabProfile:
        pageRoute =  getPageRoute(
          settings,
          const ProfileTabView(),
          binding: ProfileTabBinding(),
        );
        break;
    }

    return pageRoute;

  }

  GetPageRoute getPageRoute(RouteSettings routeSettings, Widget page,
      {Bindings? binding}) {
    return GetPageRoute(
      settings: routeSettings,
      page: () => page,
      binding: binding,
    );
  }

  @override
  void onInit() {

    discoverPage = Routes.tabDiscover;
    searchPage = Routes.tabSearch;
    chatPage = Routes.tabChat;
    profilePage = Routes.tabProfile;
    pageList.add(discoverPage!);
    super.onInit();
  }

  Future<bool> onWillPop() {
    return CustomAlertDialog().show(
      confirmCallback: () {
        SystemNavigator.pop();
        AppFocus.unFocus();
      },
      context: Get.context!,
      title: "Are you sure?",
      content: "Do you want to exit an App",
    ) ?? false;
  }
}
