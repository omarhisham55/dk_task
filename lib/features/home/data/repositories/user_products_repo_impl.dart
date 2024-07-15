import 'package:dakahlia_task/config/error/failure.dart';
import 'package:dakahlia_task/features/home/data/datasources/user_products_datasource.dart';
import 'package:dakahlia_task/features/home/domain/entities/user_product.dart';
import 'package:dakahlia_task/features/home/domain/repositories/user_products_repo.dart';
import 'package:dartz/dartz.dart';

class UserProductsRepoImpl extends UserProductsRepo {
  final UserProductsDatasource userProductsDatasource;

  UserProductsRepoImpl({required this.userProductsDatasource});

  @override
  Future<Either<Failure, List<UserProducts>>> getUserProducts(String userId) async {
    try {
      return Right(await userProductsDatasource.getUserProducts(userId));
    } catch (e) {
      return Left(ServerFailure(error: e.toString()));
    }
  }
}
