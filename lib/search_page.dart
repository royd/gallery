import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gallery/app_localizations.dart';
import 'package:gallery/app_theme.dart';
import 'package:gallery/dtos/image_source_dto.dart';
import 'package:gallery/fetch_result.dart';
import 'package:gallery/image_client.dart';
import 'package:gallery/photo_grid.dart';
import 'package:gallery/photo_grid_controller.dart';
import 'package:gallery/search_controller.dart';
import 'package:get/get.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  static const _searchPhotoGridControllerTag = 'search_photo_grid_controller';

  final ImageClient _client = Get.find();
  late final SearchController _searchController;
  late final PhotoGridController _photoController;

  @override
  void initState() {
    super.initState();

    _searchController = Get.put(
      SearchController(
        text: defaultSearchText,
      ),
    );
    _photoController = Get.put(
      PhotoGridController(
        fetch: _fetch,
      ),
      tag: _searchPhotoGridControllerTag,
    );
    _searchController.searchText.listen((value) {
      if (value.isEmpty) {
        _photoController.clear();
      } else {
        _photoController.reload();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final leading = SliverAppBar(
      backgroundColor: AppTheme.of(context).backgroundColor,
      floating: true,
      flexibleSpace: Container(
        padding: const EdgeInsets.symmetric(horizontal: 6),
        margin: const EdgeInsets.only(top: 12),
        child: CupertinoSearchTextField(
          controller: _searchController.textController,
          backgroundColor: AppTheme.of(context).editTextBackgroundColor,
        ),
      ),
    );

    return Container(
      color: AppTheme.of(context).backgroundColor,
      child: SafeArea(
        child: PhotoGrid(
          controllerTag: _searchPhotoGridControllerTag,
          leadingSliver: leading,
        ),
      ),
    );
  }

  Future<FetchResult> _fetch({
    required int page,
    required int perPage,
  }) async {
    final response = await _client.search(
      text: _searchController.textController.text,
      page: page,
      perPage: perPage,
    );

    final total = response.result?.total ?? 0;

    final results = response.result?.photos
            ?.map((e) => e.src)
            .whereType<ImageSourceDto>()
            .toList() ??
        [];

    return FetchResult(
      total: total,
      items: results,
    );
  }
}
