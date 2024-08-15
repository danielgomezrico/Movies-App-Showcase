import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ImageFrame extends StatelessWidget {
  const ImageFrame({super.key, required this.imageUrl});

  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    final devicePixel = MediaQuery.devicePixelRatioOf(context).round();

    return CachedNetworkImage(
      imageUrl: imageUrl,
      fit: BoxFit.cover,
      height: 200,
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
        // TODO: Improve the loading indicator
        return const SizedBox(
          width: 50,
          height: 50,
          child: CircularProgressIndicator(),
        );
      },
      errorWidget: (context, url, error) {
        // TODO: Improve the loading indicator
        return const Icon(Icons.image_not_supported_outlined);
      },
    );
  }
}
