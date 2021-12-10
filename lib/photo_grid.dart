import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:gallery/app_localizations.dart';
import 'package:gallery/app_theme.dart';
import 'package:gallery/dtos/image_source_dto.dart';
import 'package:gallery/photo_grid_controller.dart';
import 'package:get/get.dart';

class PhotoGrid extends StatefulWidget {
  const PhotoGrid({
    required String controllerTag,
    Widget? leadingSliver,
    Key? key,
  })  : _leadingSliver = leadingSliver,
        _controllerTag = controllerTag,
        super(key: key);

  final Widget? _leadingSliver;
  final String _controllerTag;

  @override
  _PhotoGridState createState() => _PhotoGridState();
}

class _PhotoGridState extends State<PhotoGrid> {
  late final PhotoGridController _controller;

  @override
  void initState() {
    super.initState();

    _controller = Get.find(
      tag: widget._controllerTag,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        final status = _controller.status.value;
        final statusKind = status.kind;

        return CustomScrollView(
          slivers: [
            if (widget._leadingSliver != null) widget._leadingSliver!,
            if (statusKind == StatusKind.loading)
              const SliverFillRemaining(
                child: Center(
                  child: CupertinoActivityIndicator(),
                ),
              ),
            if (statusKind == StatusKind.none) const SliverFillRemaining(),
            if (statusKind == StatusKind.noResults)
              const SliverFillRemaining(
                child: Center(
                  child: Text(noResults),
                ),
              ),
            if (statusKind == StatusKind.results)
              SliverGrid(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    _controller.setSentinelIndex(index);

                    return FutureBuilder<ImageSourceDto>(
                      future: _controller.imageAtIndex(index),
                      builder: (context, snapshot) {
                        final image = snapshot.data;
                        if (image == null) {
                          return Container();
                        }

                        final backgroundColor =
                            AppTheme.of(context).backgroundColor;

                        return GestureDetector(
                          onTap: () async {
                            FocusScope.of(context).requestFocus(FocusNode());
                            showCupertinoModalPopup(
                              context: context,
                              builder: (context) {
                                return CupertinoPageScaffold(
                                  backgroundColor: backgroundColor,
                                  navigationBar: CupertinoNavigationBar(
                                    backgroundColor: backgroundColor,
                                    border: Border.all(color: backgroundColor),
                                  ),
                                  child: Center(
                                    child: CachedNetworkImage(
                                      imageUrl: image.large!,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                          child: Container(
                            color: AppTheme.of(context).photoMatColor,
                            margin: const EdgeInsets.all(6),
                            padding: const EdgeInsets.all(6),
                            child: CachedNetworkImage(
                              imageUrl: image.medium!,
                              fit: BoxFit.cover,
                            ),
                          ),
                        );
                      },
                    );
                  },
                  childCount: status.count,
                ),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                ),
              ),
          ],
        );
      },
    );
  }
}
