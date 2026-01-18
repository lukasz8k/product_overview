import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/theme/app_theme.dart';
import '../../providers/product_providers.dart';
import '../../widgets/common/error_message.dart';
import 'widgets/product_detail_app_bar.dart';
import 'widgets/product_image_container.dart';
import 'widgets/product_info.dart';
import 'widgets/skeletons/product_image_skeleton.dart';
import 'widgets/skeletons/product_info_skeleton.dart';

class ProductDetailScreen extends ConsumerWidget {
  final int productId;

  const ProductDetailScreen({super.key, required this.productId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productAsync = ref.watch(productProvider(productId));

    return Scaffold(
      body: productAsync.when(
        loading: () => _buildSkeletonContent(context),
        error: (error, stack) => CustomScrollView(
          slivers: [
            const ProductDetailAppBar(),
            SliverFillRemaining(
              child: ErrorMessage(
                message: error.toString(),
                onRetry: () => ref.invalidate(productProvider(productId)),
              ),
            ),
          ],
        ),
        data: (product) => _buildContent(context, product),
      ),
    );
  }

  Widget _buildContent(BuildContext context, dynamic product) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isDesktop = Breakpoints.isDesktop(constraints.maxWidth);

        return CustomScrollView(
          slivers: [
            const ProductDetailAppBar(),
            if (isDesktop)
              _buildDesktopLayout(context, product)
            else
              _buildMobileLayout(context, product),
          ],
        );
      },
    );
  }

  SliverToBoxAdapter _buildDesktopLayout(
    BuildContext context,
    dynamic product,
  ) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.all(AppTheme.spacingLarge),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ProductImageContainer(
                imageUrl: product.image,
                height: 500,
              ),
            ),
            const SizedBox(width: AppTheme.spacingLarge),
            Expanded(
              child: ProductInfo(
                title: product.title,
                price: product.price,
                description: product.description,
                rating: product.rating.rate,
                ratingCount: product.rating.count,
              ),
            ),
          ],
        ),
      ),
    );
  }

  SliverList _buildMobileLayout(BuildContext context, dynamic product) {
    return SliverList(
      delegate: SliverChildListDelegate([
        Padding(
          padding: const EdgeInsets.all(AppTheme.spacingMedium),
          child: ProductImageContainer(imageUrl: product.image, aspectRatio: 1),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppTheme.spacingLarge,
            vertical: AppTheme.spacingMedium,
          ),
          child: ProductInfo(
            title: product.title,
            price: product.price,
            description: product.description,
            rating: product.rating.rate,
            ratingCount: product.rating.count,
          ),
        ),
      ]),
    );
  }

  Widget _buildSkeletonContent(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isDesktop = Breakpoints.isDesktop(constraints.maxWidth);

        return CustomScrollView(
          slivers: [
            const ProductDetailAppBar(),
            SliverToBoxAdapter(
              child: Skeletonizer(
                enabled: true,
                child: isDesktop
                    ? _buildDesktopSkeletonLayout()
                    : _buildMobileSkeletonLayout(),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildDesktopSkeletonLayout() {
    return Padding(
      padding: const EdgeInsets.all(AppTheme.spacingLarge),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Expanded(child: ProductImageSkeleton(height: 500)),
          const SizedBox(width: AppTheme.spacingLarge),
          const Expanded(child: ProductInfoSkeleton()),
        ],
      ),
    );
  }

  Widget _buildMobileSkeletonLayout() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.all(AppTheme.spacingMedium),
          child: ProductImageSkeleton(aspectRatio: 1),
        ),
        const Padding(
          padding: EdgeInsets.all(AppTheme.spacingMedium),
          child: ProductInfoSkeleton(),
        ),
      ],
    );
  }
}
