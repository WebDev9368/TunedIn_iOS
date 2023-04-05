
import 'dart:convert';

import 'package:tunedln/modules/main/tabs/search/model/song_model.dart';
import 'package:tunedln/modules/main/tabs/search/model/songs_model.dart';

List<SongsModel> SongsListModelFromJson(String str) => List<SongsModel>.from(json.decode(str).map((x) => SongsListModel.fromJson(x)));

String SongsListModelToJson(List<SongsListModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SongsListModel {
  SongsListModel({
    required this.success,
    required this.tracks,
    //required this.apple,
    //required this.spotify,
    required this.accessToken,
    required this.refreshToken
  });

   bool? success;
   List<SongModel>? apple;

  List<SongModel>? tracks;
  List<SongModel>? spotify;
   String? accessToken;
   String? refreshToken;

  factory SongsListModel.fromJson(Map<String, dynamic> json) => SongsListModel(
    success: json["success"],
    tracks: json["tracks"]['apple'].map<SongModel>((x) => SongModel.fromJson(x)).toList(),//['apple'].map<SongsModel>((x) => SongModel.fromJson(x)).toList(),
    //spotify: json["tracks"]['spotify'].map<SongsModel>((x) => SongModel.fromJson(x)).toList(),
      accessToken: json["accessToken"],
    refreshToken: json["refreshToken"]
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "tracks":tracks,
    //"apple": apple,
    //"spotify": spotify,
    "accessToken": accessToken,
    "refreshToken": refreshToken,
  };
}
