import 'package:peefo/data/constant/api_constant.dart';
import 'package:peefo/data/models/product/product_model.dart';
import 'package:peefo/data/utils/request.dart';
import 'package:peefo/domain/entities/product.dart';
import 'package:peefo/domain/repositories/product_repository.dart';

import '../utils/base_response.dart';
import '../utils/exception_handler.dart';

class ProductRepositoryImpl implements ProductRepository {
  @override
  Future<Product> getProduct(String id) async {
    try {
      final response =
          await request.get('${ApiConstant.GET_PRODUCT_BY_ID}/$id');
      if (response.statusCode == 200 && response.data != null) {
        return ProductModel.fromJson(response.data);
      } else {
        throw ApiException(
          errorCode: response.statusCode,
          errorMessage: response.statusMessage ?? 'Lỗi không xác định',
          errorStatus: response.statusCode.toString(),
        );
      }
    } catch (e) {
      throw ExceptionHandler.handleException(e);
    }
  }

  @override
  Future<BaseResponse<ProductModel>> getProducts(int page, int limit) async {
    try {
      final response = await request.get(
          '${ApiConstant.GET_ALL_PRODUCTS_STATUS_ACTIVE}',
          queryParameters: {
            'page': page,
            'limit': limit,
          });

      if (response.statusCode == 200) {
        List<dynamic> data = response.data['listResult'] ?? [];
        List<ProductModel> productList =
            data.map((item) => ProductModel.fromJson(item)).toList();

        return BaseResponse<ProductModel>(
          page: response.data['page'] ?? 0,
          totalPage: response.data['totalPage'] ?? 0,
          limit: response.data['limit'] ?? 0,
          listResult: productList,
        );
      } else {
        throw ApiException(
          errorCode: response.statusCode,
          errorMessage: response.statusMessage ?? 'Lỗi không xác định',
          errorStatus: response.statusCode.toString(),
        );
      }
    } catch (e) {
      throw ExceptionHandler.handleException(e);
    }
  }
}
