import 'package:json_annotation/json_annotation.dart';

part 'GenreInfo.g.dart';

@JsonSerializable()
class GenreInfo {
  int? id;
  String? name;

  GenreInfo({this.id, this.name});

  factory GenreInfo.fromJson(Map<String, dynamic> json) =>
      _$GenreInfoFromJson(json);
  Map<String, dynamic> toJson() => _$GenreInfoToJson(this);
}
