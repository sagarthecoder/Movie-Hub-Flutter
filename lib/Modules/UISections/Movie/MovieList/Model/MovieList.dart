import 'package:json_annotation/json_annotation.dart';
import 'package:movie_hub/Modules/UISections/Movie/MovieList/Model/MovieInfo.dart';

part 'MovieList.g.dart';

@JsonSerializable()
class MovieList {
  final List<MovieInfo>? results;
  const MovieList({this.results});

  factory MovieList.fromJson(Map<String, dynamic> json) =>
      _$MovieListFromJson(json);
  Map<String, dynamic> toJson() => _$MovieListToJson(this);
}
