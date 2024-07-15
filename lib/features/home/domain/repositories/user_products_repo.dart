import 'package:dakahlia_task/config/error/failure.dart';
import 'package:dakahlia_task/features/home/domain/entities/user_product.dart';
import 'package:dartz/dartz.dart';

abstract class UserProductsRepo {
  Future<Either<Failure, List<UserProducts>>> getUserProducts(String userId);
}
