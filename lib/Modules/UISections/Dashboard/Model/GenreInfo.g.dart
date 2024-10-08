// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'GenreInfo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GenreInfo _$GenreInfoFromJson(Map<String, dynamic> json) => GenreInfo(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
    );

Map<String, dynamic> _$GenreInfoToJson(GenreInfo instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
    };
