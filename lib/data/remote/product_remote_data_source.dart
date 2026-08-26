import '../../core/network/api_client.dart';
import '../../models/product_model.dart';

class ProductRemoteDataSource {
  final ApiClient apiClient;

  ProductRemoteDataSource(
    this.apiClient,
  );

  Future<List<ProductModel>> getProducts({
    String? search,
    String? type,
    int? currencyId,
  }) async {
    final queryParameters =
        <String, dynamic>{};

    if (search != null &&
        search.trim().isNotEmpty) {
      queryParameters['q'] =
          search.trim();
    }

    if (type != null &&
        type.isNotEmpty) {
      queryParameters['type'] =
          type;
    }

    if (currencyId != null) {
      queryParameters[
          'currency_id'] =
          currencyId;
    }

    final response =
        await apiClient.dio.get(
      '/products',
      queryParameters:
          queryParameters,
    );

    final root =
        Map<String, dynamic>.from(
      response.data as Map,
    );

    final list =
        root['data'] as List<dynamic>;

    return list
        .map(
          (item) => ProductModel.fromJson(
            Map<String, dynamic>.from(
              item as Map,
            ),
          ),
        )
        .toList();
  }

  Future<ProductModel> createProduct(
    Map<String, dynamic> payload,
  ) async {
    final response =
        await apiClient.dio.post(
      '/products',
      data: payload,
    );

    return _fromResponse(
      response.data,
    );
  }

  Future<ProductModel> updateProduct(
    int productId,
    Map<String, dynamic> payload,
  ) async {
    final response =
        await apiClient.dio.put(
      '/products/$productId',
      data: payload,
    );

    return _fromResponse(
      response.data,
    );
  }

  Future<ProductModel> setStatus({
    required int productId,
    required bool isActive,
  }) async {
    final response =
        await apiClient.dio.patch(
      '/products/$productId/status',
      data: {
        'is_active': isActive,
      },
    );

    return _fromResponse(
      response.data,
    );
  }

  ProductModel _fromResponse(
    dynamic responseData,
  ) {
    final root =
        Map<String, dynamic>.from(
      responseData as Map,
    );

    return ProductModel.fromJson(
      Map<String, dynamic>.from(
        root['data'] as Map,
      ),
    );
  }
}
