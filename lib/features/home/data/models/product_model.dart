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
        img: ImgModel.fromJson(json['img'] ?? {}),
      );
}

class ImgModel {
  final String? type;
  final List<dynamic>? data;

  ImgModel({required this.type, required this.data});
  factory ImgModel.fromJson(Map<String, dynamic> json) => ImgModel(
        type: json['type'],
        data: json['data'],
      );
}
