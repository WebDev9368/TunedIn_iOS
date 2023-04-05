import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../routes/app_pages.dart';
import 'model/songs_cover_model.dart';

class ProfileTabController extends GetxController{
  List<SongsCoverModel> songsCoverList = [
    SongsCoverModel('songs_cover1', '93'),
    SongsCoverModel('songs_cover2', '48'),
    SongsCoverModel('songs_cover3', '78'),
    SongsCoverModel('songs_cover4', '37'),
    SongsCoverModel('songs_cover5', '88'),
    SongsCoverModel('songs_cover6', '69'),
    SongsCoverModel('songs_cover1', '93'),
    SongsCoverModel('songs_cover2', '48'),
    SongsCoverModel('songs_cover3', '78'),
    SongsCoverModel('songs_cover4', '37'),
    SongsCoverModel('songs_cover5', '88'),
    SongsCoverModel('songs_cover6', '69'),
  ];

  exitAction() async {
    var emptyString = "";
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString("token", emptyString);
    sharedPreferences.setString("refreshToken", emptyString);
    sharedPreferences.setString("spotifyRefreshToken", emptyString);
    sharedPreferences.setString("spotifyToken", emptyString);
    sharedPreferences.setString("appleToken", emptyString);
    Get.offAllNamed(Routes.login);
  }

}