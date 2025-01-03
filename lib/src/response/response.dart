import 'dart:convert';

List<MoviesList> moviesListFromJson(String str) =>
    List<MoviesList>.from(json.decode(str).map((x) => MoviesList.fromJson(x)));

String moviesListToJson(List<MoviesList> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class MoviesList {
  int id;
  String title;
  String posterUrl;
  String imdbId;

  MoviesList({
    required this.id,
    required this.title,
    required this.posterUrl,
    required this.imdbId,
  });

  MoviesList copyWith({
    int? id,
    String? title,
    String? posterUrl,
    String? imdbId,
  }) =>
      MoviesList(
        id: id ?? this.id,
        title: title ?? this.title,
        posterUrl: posterUrl ?? this.posterUrl,
        imdbId: imdbId ?? this.imdbId,
      );

  factory MoviesList.fromJson(Map<String, dynamic> json) => MoviesList(
        id: json["id"],
        title: json["title"],
        posterUrl: json["posterURL"],
        imdbId: json["imdbId"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "posterURL": posterUrl,
        "imdbId": imdbId,
      };
}
