import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SearchController extends GetxController {
  SearchController({
    String text = '',
  }) : textController = TextEditingController(
          text: text,
        );

  Timer? _searchDebounce;

  final TextEditingController textController;

  final searchText = ''.obs;

  @override
  void onInit() {
    super.onInit();

    searchText.value = textController.text;
    textController.addListener(_onTextChanged);
  }

  @override
  void dispose() {
    textController.removeListener(_onTextChanged);
    textController.dispose();

    super.dispose();
  }

  Future _onTextChanged() async {
    final debounce = _searchDebounce;
    if (debounce != null && debounce.isActive) {
      debounce.cancel();
    }

    _searchDebounce = Timer(
      const Duration(
        milliseconds: 500,
      ),
      () {
        searchText.value = textController.text;
      },
    );
  }
}
