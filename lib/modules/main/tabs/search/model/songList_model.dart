
import 'dart:convert';

import 'package:tunedln/modules/main/tabs/search/model/song_model.dart';

List<SongModel> SongListModelFromJson(String str) => List<SongModel>.from(json.decode(str).map((x) => SongListModel.fromJson(x)));

String SongListModelToJson(List<SongListModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SongListModel {
  SongListModel({
    required this.success,
    required this.tracks,
    required this.accessToken,
    required this.refreshToken
  });

   bool? success;
   List<SongModel>? tracks;
   String? accessToken;
   String? refreshToken;

  factory SongListModel.fromJson(Map<String, dynamic> json) => SongListModel(
    success: json["success"],
    tracks: json["tracks"].map<SongModel>((x) => SongModel.fromJson(x)).toList(),
    accessToken: json["accessToken"],
    refreshToken: json["refreshToken"]
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "tracks": tracks,
    "accessToken": accessToken,
    "refreshToken": refreshToken,
  };
}
