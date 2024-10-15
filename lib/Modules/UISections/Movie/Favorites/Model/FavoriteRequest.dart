import 'package:json_annotation/json_annotation.dart';

part 'FavoriteRequest.g.dart';

@JsonSerializable()
class FavoriteRequest {
  @JsonKey(name: "media_id")
  final int mediaId;
  @JsonKey(name: "media_type")
  final String mediaType;
  final bool favorite;
  FavoriteRequest(
      {required this.mediaId, required this.mediaType, required this.favorite});

  factory FavoriteRequest.fromJson(Map<String, dynamic> json) =>
      _$FavoriteRequestFromJson(json);
  Map<String, dynamic> toJson() => _$FavoriteRequestToJson(this);
}
