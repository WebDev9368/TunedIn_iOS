import 'package:get/get.dart';
import 'package:tunedln/modules/main/tabs/post_song/post_song_controller.dart';

class PostSongBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => PostSongController());
  }

}