import 'package:dakahlia_task/config/error/failure.dart';
import 'package:dakahlia_task/features/home/domain/entities/product.dart';
import 'package:dartz/dartz.dart';

abstract class ProductsRepo {
  Future<Either<Failure, List<Product>>> getProducts();
}
