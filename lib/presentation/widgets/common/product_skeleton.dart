import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/theme/theme_extensions.dart';

class ProductSkeleton extends StatelessWidget {
  const ProductSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: true,
      child: ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.only(
          left: AppTheme.spacingMedium,
          right: AppTheme.spacingMedium,
          top: AppTheme.spacingMedium,
          bottom: AppTheme.spacingSmall,
        ),
        itemCount: 10,
        itemBuilder: (context, index) {
          return const Padding(
            padding: EdgeInsets.only(bottom: AppTheme.spacingSmall),
            child: _SkeletonCard(),
          );
        },
      ),
    );
  }
}

class _SkeletonCard extends StatelessWidget {
  const _SkeletonCard();

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;

    return Container(
      height: AppTheme.productCardHeight,
      decoration: BoxDecoration(
        color: colors.surfaceCard,
        borderRadius: BorderRadius.circular(AppTheme.borderRadius),
        border: Border.all(color: colors.borderSubtle, width: 1),
      ),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(AppTheme.spacingSmall),
            child: Container(
              width: AppTheme.productImageSize,
              height: AppTheme.productImageSize,
              decoration: BoxDecoration(
                color: colors.imageBg,
                borderRadius: BorderRadius.circular(AppTheme.spacingSmall),
              ),
              child: const Bone.square(size: 40),
            ),
          ),

          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: AppTheme.spacingSmall, horizontal: AppTheme.spacingSmall),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [Bone.text(words: 3), SizedBox(height: 8), Bone.text(words: 1, fontSize: 14)],
              ),
            ),
          ),

          const Padding(
            padding: EdgeInsets.only(right: AppTheme.spacingMedium),
            child: Bone.icon(size: 24),
          ),
        ],
      ),
    );
  }
}
