import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gallery/app_theme.dart';
import 'package:gallery/image_client.dart';
import 'package:gallery/search_page.dart';
import 'package:get/instance_manager.dart';

class GalleryApp extends StatelessWidget {
  GalleryApp({Key? key}) : super(key: key) {
    Get.put(ImageClient());
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      home: Builder(
        builder: (context) {
          return AppTheme.light(
            child: const SearchPage(),
          );
        },
      ),
      localizationsDelegates: const [
        DefaultMaterialLocalizations.delegate,
        DefaultCupertinoLocalizations.delegate,
      ],
    );
  }
}
