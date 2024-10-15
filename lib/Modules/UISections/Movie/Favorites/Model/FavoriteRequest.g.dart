// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'FavoriteRequest.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FavoriteRequest _$FavoriteRequestFromJson(Map<String, dynamic> json) =>
    FavoriteRequest(
      mediaId: (json['media_id'] as num).toInt(),
      mediaType: json['media_type'] as String,
      favorite: json['favorite'] as bool,
    );

Map<String, dynamic> _$FavoriteRequestToJson(FavoriteRequest instance) =>
    <String, dynamic>{
      'media_id': instance.mediaId,
      'media_type': instance.mediaType,
      'favorite': instance.favorite,
    };
