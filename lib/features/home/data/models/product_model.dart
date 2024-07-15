import 'package:dakahlia_task/features/home/domain/entities/product.dart';

class ProductModel extends Product {
  ProductModel({
    required super.id,
    required super.name,
    required super.size,
    required super.feddans,
    required super.img,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) => ProductModel(
        id: json['id'],
        name: json['name'],
        size: json['size'],
        feddans: json['feddans'],
        img: json['img'],
      );
}
