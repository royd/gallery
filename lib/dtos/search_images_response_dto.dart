import 'package:gallery/dtos/image_dto.dart';
import 'package:json_annotation/json_annotation.dart';

part 'search_images_response_dto.g.dart';

@JsonSerializable()
class SearchImagesResponseDto {
  SearchImagesResponseDto({
    this.total,
    this.photos,
  });

  @JsonKey(name: 'total_results')
  final int? total;
  final List<ImageDto>? photos;

  factory SearchImagesResponseDto.fromJson(Map<String, dynamic> json) =>
      _$SearchImagesResponseDtoFromJson(json);

  Map<String, dynamic> toJson() => _$SearchImagesResponseDtoToJson(this);
}
