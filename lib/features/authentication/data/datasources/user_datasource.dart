import 'package:dakahlia_task/config/dpi/dpi_controller.dart';
import 'package:dakahlia_task/config/sharedPrefs/shared_prefs.dart';
import 'package:dakahlia_task/core/api/dio_consumer.dart';
import 'package:dakahlia_task/core/api/end_points.dart';
import 'package:dakahlia_task/features/authentication/data/models/user_model.dart';
import 'package:dakahlia_task/features/authentication/domain/entities/user.dart';
import 'package:flutter/material.dart';

abstract class UserDatasource {
  Future<User> saveUser(User user, bool rememberUser);
  Future<UserModel> getUser(String id);
}

class UserDatasourceImpl extends UserDatasource {
  final DioConsumer client;

  UserDatasourceImpl({required this.client});
  @override
  Future<UserModel> getUser(id) async {
    final response = await client.get('${EndPoints.getUser}/$id');
    debugPrint('response: $response');
    return UserModel.fromJson(response);
  }

  @override
  Future<User> saveUser(User user, bool rememberUser) async {
    final response = await client.post(
      EndPoints.saveUser,
      body: {'username': user.username, 'password': user.password},
    );
    user = UserModel.fromJson(response);
    if (rememberUser) {
      await DpiController.getIt<SharedPrefsController>().save(
        'userId',
        user.id.toString(),
      );
    }
    return user;
  }
}
