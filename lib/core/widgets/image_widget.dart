import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../utils/extensions.dart';

class ImageWidget extends StatelessWidget {
  const ImageWidget({
    super.key,
    this.url,
    this.height,
    this.width,
    this.fit,
    this.radius = 0,
    this.highQuality = false, this.placeholder,
  });

  final String? url;
  final String? placeholder;
  final double? height;
  final double? width;
  final double radius;
  final BoxFit? fit;
  final bool highQuality;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadiusGeometry.circular(radius),
      child: CachedNetworkImage(
        imageUrl: url ?? "",
        height: height,
        width: width,
        fit: fit,
        memCacheWidth: highQuality ? null : 250,
        cacheKey: "${url}_$highQuality",
        placeholder: (context, url) => Container(
          color: context.colorScheme.surfaceContainer,
          alignment: Alignment.center,
          child: CircularProgressIndicator(
            constraints: BoxConstraints(minWidth: 24, minHeight: 24),
            strokeWidth: 2,
          ),
        ),
        errorWidget: (context, url, error) => Container(
          decoration: BoxDecoration(
            color: context.colorScheme.surfaceContainer,
          ),
          child: placeholder!=null?Image.asset(placeholder!):SvgPicture.asset('assets/svg/svg_logo.svg'),
        ),
      ),
    );
  }
}
