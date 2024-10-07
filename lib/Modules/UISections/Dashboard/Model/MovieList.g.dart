// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'MovieList.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MovieList _$MovieListFromJson(Map<String, dynamic> json) => MovieList(
      results: (json['results'] as List<dynamic>?)
          ?.map((e) => MovieInfo.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$MovieListToJson(MovieList instance) => <String, dynamic>{
      'results': instance.results,
    };
