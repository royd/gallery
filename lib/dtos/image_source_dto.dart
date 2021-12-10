import 'package:json_annotation/json_annotation.dart';

part 'image_source_dto.g.dart';

@JsonSerializable()
class ImageSourceDto {
  ImageSourceDto({
    this.original,
    this.small,
    this.medium,
    this.large,
    this.large2x,
  });

  final String? original;
  final String? small;
  final String? medium;
  final String? large;
  final String? large2x;

  factory ImageSourceDto.fromJson(Map<String, dynamic> json) =>
      _$ImageSourceDtoFromJson(json);

  Map<String, dynamic> toJson() => _$ImageSourceDtoToJson(this);
}
