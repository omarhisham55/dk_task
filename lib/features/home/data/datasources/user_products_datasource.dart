import 'package:dakahlia_task/core/api/api_consumer.dart';
import 'package:dakahlia_task/core/api/end_points.dart';
import 'package:dakahlia_task/features/home/data/models/user_products_model.dart';
import 'package:dakahlia_task/features/home/domain/entities/user_product.dart';

abstract class UserProductsDatasource {
  Future<List<UserProducts>> getUserProducts(String userId);
}

class UserProductsDatasourceImpl extends UserProductsDatasource {
  final ApiConsumer client;

  UserProductsDatasourceImpl({required this.client});
  @override
  Future<List<UserProducts>> getUserProducts(String userId) async {
    List<UserProducts> products = [];
    await client.get('${EndPoints.getUserProducts}/$userId').then(
          (value) => value.forEach(
            (product) {
              products.add(UserProductsModel.fromJson(product));
            },
          ),
        );
    return products;
  }
}
