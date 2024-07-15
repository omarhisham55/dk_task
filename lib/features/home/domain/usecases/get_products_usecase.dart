import 'package:dakahlia_task/config/error/failure.dart';
import 'package:dakahlia_task/features/home/domain/entities/product.dart';
import 'package:dakahlia_task/features/home/domain/repositories/products_repo.dart';
import 'package:dartz/dartz.dart';

class GetProductsUsecase {
  final ProductsRepo productsRepo;

  GetProductsUsecase({required this.productsRepo});

  Future<Either<Failure, List<Product>>> call() async {
    return productsRepo.getProducts();
  }
}
