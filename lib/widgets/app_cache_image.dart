import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

class AppCacheImage extends StatelessWidget {
  final String imageUrl;
  final BoxFit? fit;
  final double? height, width;
  const AppCacheImage({
    Key? key,
    required this.imageUrl,
    this.fit,
    this.height,
    this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      fit: fit,
      imageUrl: imageUrl,
      imageBuilder: (context, imageProvider) {
        return Container(
          height: height,
          width: width,
          decoration: BoxDecoration(
            image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
          ),
        );
      },
      progressIndicatorBuilder: (context, url, progress) {
        return Center(
          child: CircularProgressIndicator(value: progress.progress),
        );
      },
    );
  }
}
