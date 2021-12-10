// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'image_source_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ImageSourceDto _$ImageSourceDtoFromJson(Map<String, dynamic> json) =>
    ImageSourceDto(
      original: json['original'] as String?,
      small: json['small'] as String?,
      medium: json['medium'] as String?,
      large: json['large'] as String?,
      large2x: json['large2x'] as String?,
    );

Map<String, dynamic> _$ImageSourceDtoToJson(ImageSourceDto instance) =>
    <String, dynamic>{
      'original': instance.original,
      'small': instance.small,
      'medium': instance.medium,
      'large': instance.large,
      'large2x': instance.large2x,
    };
