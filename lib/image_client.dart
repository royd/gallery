import 'dart:convert';
import 'dart:io';

import 'package:gallery/client_response.dart';
import 'package:gallery/dtos/search_images_response_dto.dart';
import 'package:simple_logger/simple_logger.dart';

class ImageClient {
  static const _apiKey =
      '563492ad6f91700001000001b131fef8abeb4a89969d03bb5effdbbe';
  final _httpClient = HttpClient()
    ..connectionTimeout = const Duration(seconds: 10);
  final _log = SimpleLogger();

  ///
  /// Search for images.
  ///
  /// [text] Search text.
  /// [page] Zero-based index of the page.
  /// [perPage] Max results per result page.
  ///
  Future<ClientResponse<SearchImagesResponseDto>> search({
    required String text,
    required int page,
    required int perPage,
  }) async {
    final queryParameters = {
      'query': text,
      'page': (page + 1).toString(),
      'per_page': perPage.toString(),
    };

    _log.info('Requesting "$text" page $page');

    final uri = Uri.parse('https://api.pexels.com/v1/search').replace(
      queryParameters: queryParameters,
    );

    int? statusCode;
    SearchImagesResponseDto? result;

    try {
      final request = await _httpClient.getUrl(uri);
      request.headers.add('Authorization', _apiKey);

      final response = await request.close();

      statusCode = response.statusCode;

      if (response.statusCode == HttpStatus.ok) {
        final json = await response.transform(utf8.decoder).join();
        result = SearchImagesResponseDto.fromJson(jsonDecode(json));
      }

      if (result == null) {
        _log.warning(
            'Failed to retrieve images. Status code: ${response.statusCode}');
      }
    } on SocketException catch (e) {
      _log.warning('Failed to retrieve images. SocketException: ${e.message}');
    } on Exception catch (e) {
      _log.warning('Failed to retrieve images. Exception: ${e.toString()}');
    }

    return ClientResponse(
      statusCode: statusCode,
      result: result,
    );
  }
}
