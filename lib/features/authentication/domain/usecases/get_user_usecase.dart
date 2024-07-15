import 'package:dakahlia_task/config/error/failure.dart';
import 'package:dakahlia_task/features/authentication/domain/entities/user.dart';
import 'package:dakahlia_task/features/authentication/domain/repositories/user_repo.dart';
import 'package:dartz/dartz.dart';

class GetUserUsecase {
  final UserRepo userRepo;

  const GetUserUsecase({required this.userRepo});

  Future<Either<Failure, User>> call(String id) async {
    return await userRepo.getUser(id);
  }
}
