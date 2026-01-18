import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../../../../../core/theme/theme_extensions.dart';

class ProductImageSkeleton extends StatelessWidget {
  final double? height;
  final double? aspectRatio;

  const ProductImageSkeleton({super.key, this.height, this.aspectRatio})
    : assert(
        height != null || aspectRatio != null,
        'Either height or aspectRatio must be provided',
      );

  @override
  Widget build(BuildContext context) {
    final skeleton = Container(
      height: height,
      decoration: BoxDecoration(
        color: context.colors.surfaceCard,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: context.colors.borderSubtle, width: 1),
      ),
      child: const Bone(
        width: double.infinity,
        height: double.infinity,
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
    );

    if (aspectRatio != null) {
      return AspectRatio(aspectRatio: aspectRatio!, child: skeleton);
    }

    return skeleton;
  }
}
