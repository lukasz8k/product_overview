import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/theme/theme_extensions.dart';

class ProductImageContainer extends StatelessWidget {
  final String imageUrl;
  final double? height;
  final double? aspectRatio;

  const ProductImageContainer({
    super.key,
    required this.imageUrl,
    this.height,
    this.aspectRatio,
  }) : assert(
         height != null || aspectRatio != null,
         'Either height or aspectRatio must be provided',
       );

  @override
  Widget build(BuildContext context) {
    final container = Container(
      height: height,
      decoration: BoxDecoration(
        color: context.colors.surfaceCard,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: context.colors.borderSubtle, width: 1),
      ),
      padding: const EdgeInsets.all(AppTheme.spacingLarge),
      child: CachedNetworkImage(
        imageUrl: imageUrl,
        fit: BoxFit.contain,
        fadeInDuration: const Duration(milliseconds: 300),
        fadeOutDuration: const Duration(milliseconds: 300),
        placeholder: (context, url) => Center(
          child: CircularProgressIndicator(
            color: context.colors.accent,
            strokeWidth: 3,
          ),
        ),
        errorWidget: (context, url, error) => Icon(
          Icons.broken_image_outlined,
          size: 64,
          color: context.colors.textMuted,
        ),
      ),
    );

    if (aspectRatio != null) {
      return AspectRatio(aspectRatio: aspectRatio!, child: container);
    }

    return container;
  }
}
