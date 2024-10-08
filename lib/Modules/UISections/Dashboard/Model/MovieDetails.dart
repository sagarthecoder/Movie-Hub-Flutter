import 'package:json_annotation/json_annotation.dart';
import 'package:movie_hub/Modules/UISections/Dashboard/Model/GenreInfo.dart';

part 'MovieDetails.g.dart';

@JsonSerializable()
class MovieDetails {
  final int? id;
  final bool? adult;
  @JsonKey(name: 'backdrop_path')
  final String? backdropPath;
  final int? budget;
  final List<GenreInfo>? genres;
  @JsonKey(name: "imdb_id")
  final String? imdbId;
  @JsonKey(name: "original_language")
  final String? originalLanguage;
  @JsonKey(name: "poster_path")
  final String? posterPath;
  final int? popularity;
  @JsonKey(name: "release_date")
  final String? releaseDate;
  final int? revenue;
  final int? runtime;
  final String? status;
  final String? tagline;
  final String? title;
  @JsonKey(name: "vote_average")
  final double? voteAverage;
  @JsonKey(name: "vote_count")
  final int? voteCount;

  // Constructor without 'required'
  MovieDetails({
    this.id,
    this.adult,
    this.backdropPath,
    this.budget,
    this.genres,
    this.imdbId,
    this.originalLanguage,
    this.posterPath,
    this.popularity,
    this.releaseDate,
    this.revenue,
    this.runtime,
    this.status,
    this.tagline,
    this.title,
    this.voteAverage,
    this.voteCount,
  });

  // Add factory and toJson methods if needed for JSON serialization
  factory MovieDetails.fromJson(Map<String, dynamic> json) =>
      _$MovieDetailsFromJson(json);

  Map<String, dynamic> toJson() => _$MovieDetailsToJson(this);
}
