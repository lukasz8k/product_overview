import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/theme/app_theme.dart';
import '../../core/theme/theme_extensions.dart';
import '../providers/product_providers.dart';
import '../widgets/product_card.dart';
import '../widgets/common/product_skeleton.dart';
import '../widgets/common/error_message.dart';
import '../widgets/common/search_bar_widget.dart';

class ProductListScreen extends ConsumerStatefulWidget {
  const ProductListScreen({super.key});

  @override
  ConsumerState<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends ConsumerState<ProductListScreen> {
  bool _showSearch = false;
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _toggleSearch() {
    setState(() {
      _showSearch = !_showSearch;
      if (!_showSearch) {
        _searchController.clear();
        ref.read(searchQueryProvider.notifier).state = '';
      }
    });
  }

  void _onSearchChanged(String query) {
    ref.read(searchQueryProvider.notifier).state = query;
  }

  void _onClearSearch() {
    ref.read(searchQueryProvider.notifier).state = '';
  }

  @override
  Widget build(BuildContext context) {
    final filteredProductsAsync = ref.watch(filteredProductsProvider);
    final colors = context.colors;

    // Check if we should block scrolling (empty results)
    final products = filteredProductsAsync.valueOrNull;
    final hasNoResults = products != null && products.isEmpty;

    return Scaffold(
      body: NestedScrollView(
        physics: hasNoResults ? const NeverScrollableScrollPhysics() : null,
        floatHeaderSlivers: true,
        headerSliverBuilder: (context, innerBoxIsScrolled) {
          return [
            SliverAppBar(
              title: const Text('Products'),
              elevation: 0,
              scrolledUnderElevation: 0,
              backgroundColor: colors.background.withValues(alpha: 0.9),
              surfaceTintColor: Colors.transparent,
              pinned: _showSearch,
              floating: true,
              snap: !_showSearch,
              actions: [
                IconButton(
                  icon: Icon(
                    _showSearch ? Icons.close : Icons.search,
                    color: colors.textPrimary,
                  ),
                  onPressed: _toggleSearch,
                ),
              ],
            ),
            SliverToBoxAdapter(
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                curve: Curves.easeInOut,
                height: _showSearch ? 72 : 0,
                clipBehavior: Clip.antiAlias,
                decoration: BoxDecoration(
                  color: colors.background,
                  border: Border(
                    bottom: BorderSide(
                      color: _showSearch
                          ? colors.borderSubtle
                          : Colors.transparent,
                      width: 1,
                    ),
                  ),
                ),
                child: _showSearch
                    ? SearchBarWidget(
                        controller: _searchController,
                        onChanged: _onSearchChanged,
                        onClear: _onClearSearch,
                      )
                    : const SizedBox.shrink(),
              ),
            ),
            SliverToBoxAdapter(
              child: Container(height: 1, color: colors.borderSubtle),
            ),
          ];
        },
        body: filteredProductsAsync.when(
          loading: () => const ProductSkeleton(),
          error: (error, stack) => ErrorMessage(
            message: error.toString(),
            onRetry: () => ref.invalidate(productsProvider),
          ),
          data: (products) {
            if (products.isEmpty) {
              return CustomScrollView(
                physics: const NeverScrollableScrollPhysics(),
                slivers: [
                  SliverFillRemaining(
                    hasScrollBody: false,
                    child: Padding(
                      padding: const EdgeInsets.only(
                        top: AppTheme.spacingMedium,
                      ),
                      child: Align(
                        alignment: Alignment.topCenter,
                        child: Text(
                          ref.watch(searchQueryProvider).isNotEmpty
                              ? 'No products match your search'
                              : 'No products found',
                          style: TextStyle(color: colors.textSecondary),
                        ),
                      ),
                    ),
                  ),
                ],
              );
            }

            return ListView.builder(
              padding: const EdgeInsets.only(
                left: AppTheme.spacingMedium,
                right: AppTheme.spacingMedium,
                top: AppTheme.spacingMedium,
                bottom: AppTheme.spacingSmall,
              ),
              itemCount: products.length,
              itemBuilder: (context, index) => Padding(
                padding: const EdgeInsets.only(bottom: AppTheme.spacingSmall),
                child: ProductCard(product: products[index]),
              ),
            );
          },
        ),
      ),
    );
  }
}
