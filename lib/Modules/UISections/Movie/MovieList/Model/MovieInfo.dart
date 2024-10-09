import 'dart:ffi';

import 'package:json_annotation/json_annotation.dart';

part 'MovieInfo.g.dart';

@JsonSerializable()
class MovieInfo {
  final int? id;
  @JsonKey(name: "original_title")
  final String? originalTitle;
  final String? overview;
  @JsonKey(name: "poster_path")
  final String? posterPath;
  @JsonKey(name: "release_date")
  final String? releaseDate;
  final String? title;
  @JsonKey(name: "genre_ids")
  final List<int>? genreIds;
  @JsonKey(name: "vote_average")
  final double? voteAverage;
  @JsonKey(name: "vote_count")
  final int? voteCount;

  const MovieInfo(
      {this.id,
      this.overview,
      this.posterPath,
      this.genreIds,
      this.releaseDate,
      this.title,
      this.voteAverage,
      this.originalTitle,
      this.voteCount});

  factory MovieInfo.fromJson(Map<String, dynamic> json) =>
      _$MovieInfoFromJson(json);
  Map<String, dynamic> toJson() => _$MovieInfoToJson(this);
}
