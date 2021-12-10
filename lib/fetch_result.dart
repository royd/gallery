import 'package:gallery/dtos/image_source_dto.dart';

class FetchResult {
  FetchResult({
    required this.total,
    required this.items,
  });

  final int total;
  final List<ImageSourceDto> items;
}
