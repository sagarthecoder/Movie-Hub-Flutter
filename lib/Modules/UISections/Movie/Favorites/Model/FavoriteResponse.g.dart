// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'FavoriteResponse.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FavoriteResponse _$FavoriteResponseFromJson(Map<String, dynamic> json) =>
    FavoriteResponse(
      success: json['success'] as bool?,
      message: json['status_message'] as String?,
    );

Map<String, dynamic> _$FavoriteResponseToJson(FavoriteResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'status_message': instance.message,
    };
