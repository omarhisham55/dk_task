import 'package:dakahlia_task/config/error/failure.dart';
import 'package:dakahlia_task/features/authentication/data/datasources/user_datasource.dart';
import 'package:dakahlia_task/features/authentication/domain/entities/user.dart';
import 'package:dakahlia_task/features/authentication/domain/repositories/user_repo.dart';
import 'package:dartz/dartz.dart';

class UserRepoImpl extends UserRepo {
  final UserDatasource userDatasource;

  UserRepoImpl({required this.userDatasource});
  @override
  Future<Either<Failure, User>> getUser(String id) async {
    try {
      return Right(await userDatasource.getUser(id));
    } catch (e) {
      return Left(ServerFailure(error: e.toString()));
    }
  }

  @override
  Future<Either<Failure, User>> saveUser(User user, bool rememberUser) async {
    try {
      return Right(await userDatasource.saveUser(user, rememberUser));
    } catch (e) {
      return Left(ServerFailure(error: e.toString()));
    }
  }
}
