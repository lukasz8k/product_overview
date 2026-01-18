import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/models/product.dart';
import '../../data/repositories/product_repository.dart';

final productRepositoryProvider = Provider<ProductRepository>((ref) {
  return ProductRepository();
});

final productsProvider = FutureProvider<List<Product>>((ref) async {
  final repository = ref.watch(productRepositoryProvider);
  return repository.getProducts();
});

final productProvider = FutureProvider.family<Product, int>((ref, id) async {
  final repository = ref.watch(productRepositoryProvider);
  return repository.getProductById(id);
});

final searchQueryProvider = StateProvider<String>((ref) => '');

final filteredProductsProvider = Provider<AsyncValue<List<Product>>>((ref) {
  final productsAsync = ref.watch(productsProvider);
  final query = ref.watch(searchQueryProvider).toLowerCase().trim();

  return productsAsync.whenData((products) {
    if (query.isEmpty) {
      return products;
    }

    final queryWords = query.split(RegExp(r'\s+')).where((w) => w.isNotEmpty).toList();

    return products.where((product) {
      final title = product.title.toLowerCase();
      return queryWords.every((word) => title.contains(word));
    }).toList();
  });
});
