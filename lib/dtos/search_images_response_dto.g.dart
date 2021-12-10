// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_images_response_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SearchImagesResponseDto _$SearchImagesResponseDtoFromJson(
        Map<String, dynamic> json) =>
    SearchImagesResponseDto(
      total: json['total_results'] as int?,
      photos: (json['photos'] as List<dynamic>?)
          ?.map((e) => ImageDto.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SearchImagesResponseDtoToJson(
        SearchImagesResponseDto instance) =>
    <String, dynamic>{
      'total_results': instance.total,
      'photos': instance.photos,
    };
