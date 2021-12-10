import 'dart:async';
import 'package:flutter/material.dart';
import 'package:gallery/dtos/image_source_dto.dart';
import 'package:gallery/fetch_result.dart';
import 'package:get/get.dart';

class PhotoGridController extends GetxController {
  PhotoGridController({
    required _Fetch fetch,
  }) : _fetch = fetch {
    _imageAtIndex(0);
  }

  static const _imagesPerPage = 60;

  final _Fetch _fetch;
  final _pages = <int, _CachedPage>{};

  final status = Status(kind: StatusKind.none).obs;

  void reload() {
    _pages.clear();
    status.value = Status(
      kind: StatusKind.loading,
    );
    _imageAtIndex(0);
  }

  void clear() {
    _pages.clear();
    status.value = Status(
      kind: StatusKind.none,
    );
  }

  void setSentinelIndex(int index) {
    final indexOfPage = index ~/ _imagesPerPage;
    final firstIndexOnNextPage = (indexOfPage + 1) * _imagesPerPage;
    final isNextPageCached = _pages.containsKey(indexOfPage + 1);

    final count = status.value.count ?? 0;

    if (!isNextPageCached && count > firstIndexOnNextPage) {
      _imageAtIndex(firstIndexOnNextPage);
    }
  }

  Future<ImageSourceDto> imageAtIndex(int index) async {
    final image = await _imageAtIndex(index);

    return image!;
  }

  Future<ImageSourceDto?> _imageAtIndex(int index) async {
    final indexOfPage = index ~/ _imagesPerPage;

    if (!_pages.containsKey(indexOfPage)) {
      final cachedPage = _CachedPage();
      _pages[indexOfPage] = cachedPage;

      final result = await _fetch(
        page: indexOfPage,
        perPage: _imagesPerPage,
      );

      cachedPage.results = result.items;
      status.value = Status(
        kind: StatusKind.results,
        count: result.total,
      );
    }

    final page = _pages[indexOfPage]!;

    await page.isLoaded;

    final indexInPage = index - indexOfPage * _imagesPerPage;

    ImageSourceDto? image;
    if (page.results.length > indexInPage) {
      image = page.results[indexInPage];
    }

    return image;
  }
}

class Status {
  Status({
    required this.kind,
    this.count,
  });

  final int? count;
  final StatusKind kind;

  @override
  operator ==(Object other) =>
      other is Status && other.kind == kind && other.count == count;

  @override
  int get hashCode => hashValues(kind, count);
}

enum StatusKind {
  none,
  results,
  noResults,
  loading,
}

class _CachedPage {
  final _completer = Completer();

  Future get isLoaded => _completer.future;

  List<ImageSourceDto> get results => _results!;
  set results(List<ImageSourceDto> items) {
    _results = items;
    _completer.complete();
  }

  List<ImageSourceDto>? _results;
}

typedef _Fetch = Future<FetchResult> Function({
  required int page,
  required int perPage,
});
