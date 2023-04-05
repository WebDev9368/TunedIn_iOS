
import 'dart:convert';

import 'package:tunedln/modules/main/tabs/search/model/playlist_model.dart';
import 'package:tunedln/modules/main/tabs/search/model/song_model.dart';
import 'package:tunedln/modules/main/tabs/search/model/songs_model.dart';
List<Playlists> PlaylistModelFromJson(String str) => List<Playlists>.from(json.decode(str).map((x) => PlaylistModel.fromJson(x)));

String PlaylistModelToJson(List<PlaylistModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PlaylistModel {
  PlaylistModel({
    required this.success,
    required this.playlists,
    required this.accessToken,
    required this.refreshToken
  });

   bool? success;
   List<Playlists>? playlists;
   String? accessToken;
   String? refreshToken;

  factory PlaylistModel.fromJson(Map<String, dynamic> json) => PlaylistModel(
    success: json["success"],
    playlists: json["playlists"].map<Playlists>((x) => Playlists.fromJson(x)).toList(),
      accessToken: json["accessToken"]?? "",
    refreshToken: json["refreshToken"]?? ""
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "playlists": playlists,
    "accessToken": accessToken,
    "refreshToken": refreshToken,
  };
}
