import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ImageFrame extends StatelessWidget {
  const ImageFrame({required this.imageUrl, super.key});

  final String? imageUrl;

  @override
  Widget build(BuildContext context) {
    final devicePixel = MediaQuery.devicePixelRatioOf(context).round();

    final imageUrl = this.imageUrl;
    if (imageUrl != null) {
      return CachedNetworkImage(
        imageUrl: imageUrl,
        fit: BoxFit.cover,
        height: 400,
        memCacheWidth: 250 * devicePixel,
        memCacheHeight: 100 * devicePixel,
        imageBuilder: (context, imageProvider) {
          return Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: imageProvider,
                fit: BoxFit.cover,
              ),
              borderRadius: const BorderRadius.all(Radius.circular(2)),
            ),
          );
        },
        placeholder: (context, url) {
          return Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Container(
              color: Colors.grey[300],
              height: 200,
              width: double.infinity,
            ),
          );
        },
        errorWidget: (context, url, error) {
          return const _EmptyImage();
        },
      );
    } else {
      // TODO(danielgomezrico): Improve the loading indicator
      return const _EmptyImage();
    }
  }
}

class _EmptyImage extends StatelessWidget {
  const _EmptyImage();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      width: double.infinity,
      color: Colors.grey[300],
      child: const Icon(Icons.image_not_supported_outlined),
    );
  }
}
