import 'package:dakahlia_task/core/api/api_consumer.dart';
import 'package:dakahlia_task/core/api/end_points.dart';
import 'package:dakahlia_task/features/home/data/models/product_model.dart';
import 'package:dakahlia_task/features/home/domain/entities/product.dart';
import 'package:flutter/material.dart';

abstract class ProductsDatasource {
  Future<List<Product>> getProducts();
}

class ProductsDatasourceImpl extends ProductsDatasource {
  final ApiConsumer client;

  ProductsDatasourceImpl({required this.client});
  @override
  Future<List<Product>> getProducts() async {
    List<Product> products = [];
    await client.get(EndPoints.getProducts).then(
          (value) => value.forEach((item) {
            products.add(
              ProductModel.fromJson(item),
            );
          }),
        );
    debugPrint('products ds: ${products}');
    return products;
  }
}
