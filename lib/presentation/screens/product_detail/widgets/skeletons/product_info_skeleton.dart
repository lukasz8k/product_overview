import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../../../../../core/theme/app_theme.dart';

class ProductInfoSkeleton extends StatelessWidget {
  const ProductInfoSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Bone.text(words: 5, fontSize: 28),
        const SizedBox(height: AppTheme.spacingMedium),
        const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Bone.text(words: 1, fontSize: 24),
            Bone(width: 50, height: 28),
          ],
        ),
        const SizedBox(height: AppTheme.spacingLarge),
        const Bone(height: 1, width: double.infinity),
        const SizedBox(height: AppTheme.spacingLarge),
        const Bone.text(words: 1, fontSize: 18),
        const SizedBox(height: AppTheme.spacingSmall),
        const Bone.multiText(lines: 4),
      ],
    );
  }
}
