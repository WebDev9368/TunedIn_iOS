
import 'dart:convert';

List<Playlists> PlaylistModelFromJson(String str) => List<Playlists>.from(json.decode(str).map((x) => Playlists.fromJson(x)));

String PlaylistModelToJson(List<Playlists> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Playlists {
  Playlists({
    required this.id, required this.name
  });

   String id;
   String name;

  factory Playlists.fromJson(Map<String, dynamic> json) => Playlists(
    id: json["id"],
    name: json["name"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
  };
}
