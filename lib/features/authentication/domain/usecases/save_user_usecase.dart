import 'package:dakahlia_task/config/error/failure.dart';
import 'package:dakahlia_task/features/authentication/domain/entities/user.dart';
import 'package:dakahlia_task/features/authentication/domain/repositories/user_repo.dart';
import 'package:dartz/dartz.dart';

class SaveUserUsecase {
  final UserRepo userRepo;

  const SaveUserUsecase({required this.userRepo});

  Future<Either<Failure, User>> call(User user, bool rememberMe) async {
    return await userRepo.saveUser(user, rememberMe);
  }
}
