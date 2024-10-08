import 'dart:ffi';

import 'package:json_annotation/json_annotation.dart';

part 'MovieInfo.g.dart';

@JsonSerializable()
class MovieInfo {
  final int? id;
  final String? overview;
  @JsonKey(name: "poster_path")
  final String? posterPath;
  @JsonKey(name: "release_date")
  final String? releaseDate;
  final String? title;

  const MovieInfo(
      {this.id, this.overview, this.posterPath, this.releaseDate, this.title});

  factory MovieInfo.fromJson(Map<String, dynamic> json) =>
      _$MovieInfoFromJson(json);
  Map<String, dynamic> toJson() => _$MovieInfoToJson(this);
}
