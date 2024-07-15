import 'package:dakahlia_task/features/authentication/domain/entities/user.dart';

class UserModel extends User {
  const UserModel({super.id, required super.username, required super.password});

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        id: json['id'],
        username: json['username'],
        password: json['password'],
      );

  Map<String, dynamic> toMap() => {'username': username, 'password': password};
}
