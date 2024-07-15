import 'package:dakahlia_task/config/error/failure.dart';
import 'package:dakahlia_task/features/home/data/datasources/products_datasource.dart';
import 'package:dakahlia_task/features/home/domain/entities/product.dart';
import 'package:dakahlia_task/features/home/domain/repositories/products_repo.dart';
import 'package:dartz/dartz.dart';

class ProductsRepoImpl extends ProductsRepo {
  final ProductsDatasource productsDatasource;

  ProductsRepoImpl({required this.productsDatasource});
  @override
  Future<Either<Failure, List<Product>>> getProducts() async {
    try {
      return Right(await productsDatasource.getProducts());
    } catch (e) {
      return Left(ServerFailure(error: e.toString()));
    }
  }
}
