import 'package:peefo/domain/entities.dart';

import '../../data/utils/base_response.dart';

abstract class ProductRepository {
  Future<BaseResponse<Product>> getProducts(int page, int limit);
  Future<Product> getProduct(String id);
}
