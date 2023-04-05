
import 'dart:convert';

import 'package:tunedln/modules/main/tabs/search/model/song_model.dart';

List<SongsModel> SongsModelFromJson(String str) => List<SongsModel>.from(json.decode(str).map((x) => SongsModel.fromJson(x)));

String SongsModelToJson(List<SongsModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SongsModel {
  SongsModel({
    required this.apple, required this.spotify
  });

  List<SongModel>? apple;
  List<SongModel>? spotify;

  factory SongsModel.fromJson(Map<String, dynamic> json) => SongsModel(
    apple: json['apple'].map<SongsModel>((x) => SongModel.fromJson(x)).toList(),
    spotify: json['spotify'].map<SongsModel>((x) => SongModel.fromJson(x)).toList(),
  );

  Map<String, dynamic> toJson() => {
    "apple": apple,
    "spotify": apple,

  };
}
