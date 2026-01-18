import 'package:flutter/material.dart';
import '../../../../core/theme/theme_extensions.dart';

class ProductDetailAppBar extends StatelessWidget {
  const ProductDetailAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      title: const Text('Product Details'),
      centerTitle: true,
      floating: true,
      snap: true,
      elevation: 0,
      scrolledUnderElevation: 0,
      backgroundColor: context.colors.background.withValues(alpha: 0.9),
      surfaceTintColor: Colors.transparent,
      shape: Border(
        bottom: BorderSide(color: context.colors.borderSubtle, width: 1),
      ),
    );
  }
}
