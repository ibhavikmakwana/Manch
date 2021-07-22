import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class NetworkCacheImages extends StatefulWidget {
  final bool circleAvatar;
  final String? imageUrl;
  final double? height;
  final double? width;
  final double? radius;

  const NetworkCacheImages({
    Key? key,
    this.circleAvatar = false,
    required this.imageUrl,
    this.height,
    this.width,
    this.radius,
  }) : super(key: key);

  @override
  _NetworkCacheImagesState createState() => _NetworkCacheImagesState();
}

class _NetworkCacheImagesState extends State<NetworkCacheImages> {
  @override
  Widget build(BuildContext context) {
    if (widget.circleAvatar) {
      return CircleAvatar(
        backgroundImage: NetworkImage(
          widget.imageUrl!,
        ),
        radius: widget.radius,
      );
    } else {
      return CachedNetworkImage(
        imageUrl: widget.imageUrl!,
        height: widget.height,
        width: widget.width,
        errorWidget: (_, __, ___) {
          return Placeholder(
            fallbackHeight: widget.height!,
            fallbackWidth: widget.width!,
          );
        },
      );
    }
  }
}
