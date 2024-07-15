import 'package:dakahlia_task/config/error/failure.dart';
import 'package:dakahlia_task/features/home/domain/entities/user_product.dart';
import 'package:dakahlia_task/features/home/domain/repositories/user_products_repo.dart';
import 'package:dartz/dartz.dart';

class GetUserProductsUsecase {
  final UserProductsRepo userProductsRepo;

  GetUserProductsUsecase({required this.userProductsRepo});

  Future<Either<Failure, List<UserProducts>>> call(String userId) async {
    return userProductsRepo.getUserProducts(userId);
  }
}
