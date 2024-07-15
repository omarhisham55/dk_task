import 'package:dakahlia_task/config/error/failure.dart';
import 'package:dakahlia_task/features/authentication/domain/entities/user.dart';
import 'package:dartz/dartz.dart';

abstract class UserRepo {
  Future<Either<Failure, User>> getUser(String id);
  Future<Either<Failure, User>> saveUser(User user, bool rememberUser);
}
