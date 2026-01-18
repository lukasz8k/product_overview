import 'package:dio/dio.dart';
import '../../core/constants/app_constants.dart';
import '../../core/network/dio_client.dart';
import '../models/product.dart';

class ProductRepository {
  final Dio _dio;

  ProductRepository({Dio? dio}) : _dio = dio ?? DioClient.instance;

  Future<List<Product>> getProducts() async {
    try {
      final response = await _dio.get(ApiConstants.productsEndpoint);
      final List<dynamic> data = response.data;
      return data.map((json) => Product.fromJson(json)).toList();
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    }
  }

  Future<Product> getProductById(int id) async {
    try {
      final response = await _dio.get('${ApiConstants.productsEndpoint}/$id');
      return Product.fromJson(response.data);
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    }
  }
}