import 'package:tunedln/modules/auth/login/login_binding.dart';
import 'package:tunedln/modules/auth/login/login_view.dart';
import 'package:get/get.dart';
import 'package:tunedln/modules/auth/signup/sign_up_binding.dart';
import 'package:tunedln/modules/auth/signup/sign_up_view.dart';
import 'package:tunedln/modules/main/main_binding.dart';
import 'package:tunedln/modules/main/main_view.dart';
import 'package:tunedln/modules/main/tabs/chat/conversation/conversation_binding.dart';
import 'package:tunedln/modules/main/tabs/chat/conversation/conversation_view.dart';
import 'package:tunedln/modules/main/tabs/discover/events/concerts_detail/concerts_detail_view.dart';
import 'package:tunedln/modules/main/tabs/discover/events/events_binding.dart';
import 'package:tunedln/modules/main/tabs/discover/events/events_view.dart';
import 'package:tunedln/modules/main/tabs/search/contacts/contacts_binding.dart';
import 'package:tunedln/modules/main/tabs/search/contacts/contacts_view.dart';
import 'package:tunedln/modules/main/tabs/search/playlist/playlist_view.dart';
import 'package:tunedln/modules/main/tabs/post_song/post_song_view.dart';
import '../modules/auth/connect/connect_binding.dart';
import '../modules/auth/connect/connect_view.dart';
import '../modules/auth/forgot_password/forgot_password_binding.dart';
import '../modules/auth/forgot_password/forgot_password_view.dart';
import '../modules/auth/webView/web_view_binding.dart';
import '../modules/auth/webView/web_view_view.dart';
import '../modules/main/tabs/discover/events/concerts_detail/concerts_detail_binding.dart';
import '../modules/main/tabs/search/playlist/playlist_binding.dart';
import '../modules/main/tabs/post_song/post_song_binding.dart';
import '../modules/splash/splash_binding.dart';
import '../modules/splash/splash_screen.dart';
part 'app_routes.dart';

class AppPages {
  static final routes = [
    GetPage(
      name: Routes.splash,
      page: () => const SplashScreen(),
      binding: SplashBinding(),
    ),

    GetPage(
      name: Routes.signUp,
      page: () => const SignUpView(),
      binding: SignUpBinding(),
    ),

    GetPage(
      name: Routes.connect,
      page: () => const ConnectView(),
      binding: ConnectBinding(),
    ),

    GetPage(
      name: Routes.webView,
      page: () => const WebViewView(),
      binding: WebViewBinding(),
    ),

    GetPage(
      name: Routes.login,
      page: () => const LoginView(),
      binding: LoginBinding(),
    ),

    GetPage(
      name: Routes.forgotPassword,
      page: () => const ForgotPasswordView(),
      binding: ForgotPasswordBinding(),
    ),



    GetPage(
      name: Routes.main,
      page: () => const MainView(),
      binding: MainBindings(),
    ),

    GetPage(
      name: Routes.chatConversation,
      page: () => const ConversationView(),
      binding: ConversationBinding(),
    ),

    GetPage(
      name: Routes.postSong,
      page: () => const PostSongView(),
      binding: PostSongBinding(),
    ),

    GetPage(
      name: Routes.playlist,
      page: () => const PlayListView(),
      binding: PlayListBinding(),
    ),

    GetPage(
      name: Routes.events,
      page: () => const EventsView(),
      binding: EventsBinding(),
    ),

    GetPage(
      name: Routes.concertsDetails,
      page: () => const ConcertsDetailView(),
      binding: ConcertsDetailBinding(),
    ),

    GetPage(
      name: Routes.contacts,
      page: () => const ContactsView(),
      binding: ContactsBinding(),
    ),

  ];
}
