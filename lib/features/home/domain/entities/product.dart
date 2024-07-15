import 'package:dakahlia_task/features/home/data/models/product_model.dart';

class Product {
  final String id;
  final String name;
  final int size;
  final int feddans;
  final ImgModel img;

  Product({
    required this.id,
    required this.name,
    required this.size,
    required this.feddans,
    required this.img,
  });
}
