import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tunedln/routes/app_pages.dart';
import 'package:tunedln/shared/constants/color_constants.dart';
import 'package:tunedln/shared/constants/string_constant.dart';
import 'package:tunedln/shared/utils/focus.dart';
import 'package:tunedln/theme/theme_data.dart';
import 'app_binding.dart';
import 'di.dart';
import 'lang/translation_service.dart';

late SharedPreferences prefs;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  AppFocus.unFocus();
  await DependencyInjection.init();
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle.dark.copyWith(
      // statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
      statusBarBrightness: Brightness.light,
    ),
  );

  await SystemChrome.setPreferredOrientations(
    [
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ],
  );
 // SharedPreferences.setMockInitialValues({});
  prefs = await SharedPreferences.getInstance();

  runApp(App());
  configLoading();
}
class App extends StatelessWidget {
  App({Key, key}) : super(key: key);

  /*@override
  State<StatefulWidget> createState() {
    return AppState();
  }*/

/*
class AppState extends State<App> with WidgetsBindingObserver {
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
        print("app in resumed");
        break;
      case AppLifecycleState.inactive:
        print("app in inactive");
        break;
      case AppLifecycleState.paused:
        print("app in paused");
        break;
      case AppLifecycleState.detached:
        print("app in detached");
        exit(0);
        //SystemChannels.platform.invokeMethod('SystemNavigator.pop');
        //SystemNavigator.pop();
        AppFocus.unFocus();
        break;
    }
  }
  @override
  void initState() {
    super.initState();
    initPlatformState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }
  final brightness = SchedulerBinding.instance.window.platformBrightness;
  String _appBadgeSupported = 'Unknown';

  initPlatformState() async {
    String appBadgeSupported;
    try {
      bool res = await FlutterAppBadger.isAppBadgeSupported();
      if (res) {
        appBadgeSupported = 'Supported';
        configLoading();
      } else {
        appBadgeSupported = 'Not supported';
        configLoading();
      }
    } on PlatformException {
      appBadgeSupported = 'Failed to get badge support.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _appBadgeSupported = appBadgeSupported;
    });
    print('Badge supported: $_appBadgeSupported\n');
  }

  int _counter = 0;

  void _incrementCounter() {
    SystemChannels.platform.invokeMethod('SystemNavigator.pop');
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }
*/
  @override
  Widget build(BuildContext context) {
    //final prefs = Get.find<SharedPreferences>();
    //print("Token : ${prefs.getString(StorageConstants.token)}");
    var jwt = prefs.get("token").toString();
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: jwt == 'null' || jwt.isEmpty ? Routes.splash: Routes.connect,//Routes.main,
      defaultTransition: Transition.native,
      getPages: AppPages.routes,
      initialBinding: AppBinding(),
      smartManagement: SmartManagement.keepFactory,
      title: StringConstant.appName,
      supportedLocales: const [Locale('en', 'US')],
      theme: ThemeConfig.lightTheme,
      locale: TranslationService.locale,
      fallbackLocale: TranslationService.fallbackLocale,
      translations: TranslationService(),
      builder: EasyLoading.init(),
    );
  }

}

void configLoading() {
  EasyLoading.instance
    ..indicatorType = EasyLoadingIndicatorType.circle
    ..loadingStyle = EasyLoadingStyle.custom
    // ..indicatorSize = 45.0
    ..radius = 10.0
    ..indicatorSize = 20
    // ..progressColor = Colors.yellow
    ..backgroundColor = ColorConstants.black
    ..indicatorColor = ColorConstants.white
    ..textColor = ColorConstants.white
    ..maskColor = ColorConstants.black.withOpacity(0.5)
    ..maskType = EasyLoadingMaskType.custom
    ..toastPosition = EasyLoadingToastPosition.bottom
    // ..maskColor = Colors.red
    ..userInteractions = false
    ..dismissOnTap = false
    ..animationStyle = EasyLoadingAnimationStyle.scale
    ..successWidget = Container(
      height: 100,
      width: 100,
      color: Colors.blue,
    );
}
