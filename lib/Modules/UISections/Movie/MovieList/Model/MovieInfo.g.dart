// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'MovieInfo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MovieInfo _$MovieInfoFromJson(Map<String, dynamic> json) => MovieInfo(
      id: (json['id'] as num?)?.toInt(),
      overview: json['overview'] as String?,
      posterPath: json['poster_path'] as String?,
      genreIds: (json['genre_ids'] as List<dynamic>?)
          ?.map((e) => (e as num).toInt())
          .toList(),
      releaseDate: json['release_date'] as String?,
      title: json['title'] as String?,
      voteAverage: (json['vote_average'] as num?)?.toDouble(),
      originalTitle: json['original_title'] as String?,
      voteCount: (json['vote_count'] as num?)?.toInt(),
    );

Map<String, dynamic> _$MovieInfoToJson(MovieInfo instance) => <String, dynamic>{
      'id': instance.id,
      'original_title': instance.originalTitle,
      'overview': instance.overview,
      'poster_path': instance.posterPath,
      'release_date': instance.releaseDate,
      'title': instance.title,
      'genre_ids': instance.genreIds,
      'vote_average': instance.voteAverage,
      'vote_count': instance.voteCount,
    };
