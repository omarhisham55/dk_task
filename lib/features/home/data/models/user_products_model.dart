import 'package:dakahlia_task/features/home/domain/entities/user_product.dart';

class UserProductsModel extends UserProducts {
  const UserProductsModel({
    required super.id,
    required super.userId,
    required super.productId,
  });

  factory UserProductsModel.fromJson(Map<String, dynamic> json) =>
      UserProductsModel(
        id: json['id'],
        productId: json['product_id'],
        userId: json['user_id'],
      );
}
