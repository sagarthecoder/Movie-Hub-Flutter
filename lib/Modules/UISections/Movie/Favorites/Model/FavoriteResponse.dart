import 'package:json_annotation/json_annotation.dart';

part 'FavoriteResponse.g.dart';

@JsonSerializable()
class FavoriteResponse {
  final bool? success;
  @JsonKey(name: "status_message")
  final String? message;
  FavoriteResponse({this.success, this.message});

  factory FavoriteResponse.fromJson(Map<String, dynamic> json) =>
      _$FavoriteResponseFromJson(json);
  Map<String, dynamic> toJson() => _$FavoriteResponseToJson(this);
}
