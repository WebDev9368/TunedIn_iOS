
import 'dart:convert';

List<SongModel> SongModelFromJson(String str) => List<SongModel>.from(json.decode(str).map((x) => SongModel.fromJson(x)));

String SongModelToJson(List<SongModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SongModel {
  SongModel({
    required this.id, required this.image, required this.name, required this.previewUrl, required this.artists, this.from
  });

   String id;
   String image;
   String name;
   String previewUrl;
   String artists;
   String? from;
  // final int totalSing;

  factory SongModel.fromJson(Map<String, dynamic> json) => SongModel(
    id: json["id"],
    image: json["image"],
    name: json["name"],
    previewUrl: json["preview_url"],
    artists: json["artists"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "image": image,
    "name": name,
    "preview_url": previewUrl,
    "artists": artists,
  };
}
